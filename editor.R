#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

# Editor for the Markdown source
input_box <- dom("textarea", list(id = "input", className = "tabSupport"))
input_box$oninput <- function() {
    tryCatch({
        # Convert the Markdown input into HTML
        output_doms <- marked::lexer(this$value)$
            map(~.x %>%
                    Array() %>%
                    marked.parser() %>%
                    string_to_dom())$
            filter(~.x) %>%
            linear_to_tree() %>%
            make_content_editable()

        # Render the HTML to screen
        select_dom("#right")$innerHTML <- output_doms$outerHTML

        # Add bidirectional support
        # select_dom(".root") %>% add_reactive_update(html_to_markdown)

    },
    error = function(e) {
            console::log("An parsing error has occured. Here is the error reported by the browser:")
            console::log(e)
    })
    TRUE
}


# Watch a node and call `f` for when the node changes
add_reactive_update <- function(node, f) {
    options <- list(attributes = T, childList = T, subtree = T,
                    characterData = T)
    guard <- MutationObserver$new(function(ms) {
        res <- f(select_dom(".root"))
        console::log(res)
    })
    guard$observe(node, options)
    node
}
