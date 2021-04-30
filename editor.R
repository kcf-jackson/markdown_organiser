#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

# Editor for the Markdown source
input_box <- dom("textarea", list(id = "input", className = "tabSupport"))

input_box$oninput <- function() {
    tryCatch({
        # Convert the Markdown input into HTML
        output_doms <- markdown_to_html(this$value)

        # Render the HTML to screen
        right_panel <- select_dom("#right")
        right_panel$innerHTML <- ""
        right_panel$appendChild(output_doms)
    },
    error = function(e) {
            console::log("An parsing error has occured. Here is the error reported by the browser:")
            console::log(e)
    })
    TRUE
}
