#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

make_content_editable <- function(x) {
    x$contentEditable <- true
    for (child in x$children) {
        make_content_editable(child)
    }
    x
}

rm_content_editable <- function(x) {
    x$removeAttribute("contentEditable")
    for (child in x$children) {
        rm_content_editable(child)
    }
    x
}
