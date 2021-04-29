#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

input_box <- dom("textarea", list(id = "input", className = "tabSupport"))
input_box$oninput <- function() {
    html_doms <- marked::lexer(this$value)$
        map(~.x %>%
                Array() %>%
                marked.parser() %>%
                string_to_dom())$
        filter(~.x)

    has_error <- FALSE
    tryCatch(
        output_doms <- linear_to_tree(html_doms),
        error = function(e) {
            has_error <<- TRUE
            console::log("An parsing error has occured. Here is the error reported by the browser:")
            console::log(e)
            console::log("Here is a log for developers:")
            console::log(JSON::stringify(html_doms))
            TMP <<- html_doms
            TRUE
        }
    )

    if (!has_error) {
        select_dom("#right")$innerHTML <- output_doms$outerHTML
    }
    TRUE
}
