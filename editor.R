#! config(debug = T, rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))
#
# Editor setup ------------------------------------------------------------

setup_ace_editor <- function(id, path) {
    ace::config$set('basePath', path)
    editor <- ace::edit(id, list(mode = "ace/mode/markdown"))
    editor$setOptions(list(
        wrap = TRUE,
        indentedSoftWrap = FALSE,
        showLineNumbers = FALSE,
        theme = "ace/theme/monokai"
    ))
    editor_change <- function(delta) {
        tokens <- editor$getValue() %>%
            marked::lexer()
        select_dom("#token")$innerText <- JSON::stringify(tokens)

        html_doms <- tokens$
            map(~marked.parser(Array(.x)))$
            map(~string_to_dom(.x)) %>%
            linear_to_tree()

        TMP <<- html_doms
        parsed_value <- editor$getValue() %>%
            marked(list(gfm = TRUE))
        select_dom("#parsed")$innerText <- html_doms$outerHTML
        select_dom("#rendered")$innerHTML <- html_doms$outerHTML
        TRUE
    }
    editor$session$on('change', editor_change)
    editor
}
