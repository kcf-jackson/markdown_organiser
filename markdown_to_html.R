#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

# markdown_to_html :: String -> DOM
markdown_to_html <- function(md_string) {
    base <- marked::lexer(md_string)$
        map(~.x %>%
                Array() %>%
                marked.parser() %>%
                string_to_dom())$
        filter(~.x) %>%              # Remove null items
        linear_to_tree() %>%         # Add nested structure
        make_content_editable()      # Enable content editable

    base %>%
        add_reactive_update(         # Add bidirectional update
            compose(update_input_box, html_to_markdown)
        )
}


# Create nested structure based on headings
linear_to_tree <- function(ps) {
    root <- div(className = "root")
    pointer <- list(board = NULL, row = NULL, col = NULL)
    active_header <- root
    for (p in ps) {
        if (p$classList$contains("board")) {
            pointer$board <- p
            active_header <- p
            root$appendChild(p)
            next
        }
        if  (p$classList$contains("row")) {
            pointer$row <- p
            active_header <- p
            pointer$board$appendChild(p)
            next
        }
        if  (p$classList$contains("column")) {
            pointer$col <- p
            active_header <- p
            pointer$row$appendChild(p)
            next
        }
        active_header$appendChild(p)
    }
    root
}


# Create DOM element from string
string_to_dom <- function(x) {
    div(innerHTML = x)$firstElementChild
}


# Watch a node and call `f` for when the node changes
add_reactive_update <- function(node, f) {
    options <- list(attributes = T, childList = T, subtree = T,
                    characterData = T)
    guard <- MutationObserver$new(function() { f(node) })
    guard$observe(node, options)
    node
}


update_input_box <- function(res, id = "#input") {
    select_dom(id)$value <- res
    NULL
}

compose <- function(f, g) {
    function(x) f(g(x))
}

