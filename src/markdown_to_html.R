#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

# markdown_to_html :: String -> DOM
markdown_to_html <- function(md_string) {
    marked::lexer(md_string)$
        map(~.x %>%
                Array() %>%
                marked.parser() %>%
                string_to_dom())$
        filter(~.x) %>%              # Remove null items
        linear_to_tree()             # Add nested structure
}


# Create nested structure based on headings
linear_to_tree <- function(ps) {
    root <- div(className = "root")
    pointer <- list(board = root, row = root)
    active_header <- root
    for (p in ps) {
        if (p$classList$contains("board")) {
            pointer <- list(board = p, row = p)
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
            active_header <- p
            pointer$row %>% append_column(p)
            next
        }
        active_header %>% append_general(p)
    }
    root
}


# Handle the special case related to the row container
append_column <- function(parent, child) {
    if (parent$classList$contains("row")) {
        s <- parent$querySelector(".row-content")
        return(s$appendChild(child))
    }
    parent$appendChild(child)
}

append_general <- function(parent, child) {
    if (parent$classList$contains("row")) {
        s <- parent$querySelector(".row-content")
        return(parent$insertBefore(child, s))
    }
    parent$appendChild(child)
}


# Create DOM element from string
string_to_dom <- function(x) {
    div(innerHTML = x)$firstElementChild
}
