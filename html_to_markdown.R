#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

html_to_markdown <- function(node, res = Array()) {
    if (node$classList$contains("board")) {
        res$push("# " %+% node$firstChild$data)
    } else if (node$classList$contains("row")) {
        res$push("## " %+% node$firstChild$data)
    } else if (node$classList$contains("column")) {
        res$push("### " %+% node$firstChild$data)
    } else if (!node$classList$contains("root")) {
        res$push(parse_dom(node))
    }

    for (child in node$children) {
        html_to_markdown(child, res)
    }
    res
}

parse_dom <- function(dom) {
    converter <- showdown$Converter$new()
    converter$makeMarkdown(dom$outerHTML)
}
