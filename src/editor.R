#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

# Editor for the Markdown source
input_box <- dom("textarea",
                 list(id = "input", className = "tabSupport mytextarea"))

input_box$oninput <- function() {
    tryCatch({
        # Destroy previous Sortable instances
        destroy_sortable(GLOBAL$sortable)

        # Convert the Markdown input into HTML
        output_doms <- markdown_to_html(this$value) %>%
            enable_content_editable() %>%   # Enable content editable
            enable_reverse_update()         # Add reactive update in the reverse direction

        # Render the HTML to screen
        right_panel <- select_dom("#right")
        right_panel$innerHTML <- ""
        right_panel$appendChild(output_doms)

        # Add Sortable functionality (must happen after rendering)
        enable_sortable()
    },
    error = function(e) {
            console::log("An parsing error has occured. Here is the error reported by the browser:")
            console::log(e)
    })
    TRUE
}

input_box$onclick <- function() {
    if (select_dom(".root")) {
        rm_draggable(select_dom(".root"))
    }
    TRUE
}

rm_draggable <- function(x) {
    x$removeAttribute("draggable")
    for (child in x$children) {
        rm_draggable(child)
    }
    x
}
