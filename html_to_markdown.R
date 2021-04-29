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
    res$reduce(~.x %+% '\n' %+% .y)
}

parse_dom <- function(dom) {
    # "https://unpkg.com/showdown/dist/showdown.min.js"
    converter <- showdown$Converter$new()
    converter$makeMarkdown(dom$outerHTML)
}

# (JSBench.me: showdown is 3 times faster than turndown.)
# parse_dom <- function(dom) {
#     # "https://unpkg.com/turndown/dist/turndown.js"
#     converter <- TurndownService$new()
#     converter$turndown(dom)
# }
