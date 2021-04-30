#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

# Interface
html_to_markdown <-  function(node) {
    res <- node %>%
        rm_content_editable() %>%
        convert_html_to_markdown()
    make_content_editable(node)
    res
}


# Core function
convert_html_to_markdown <- function(node, res = Array()) {
    # Handle the parent
    if (node$nodeName == "DIV") {
        node_cls <- node$classList
        data <- ifelse(node$firstChild, node$firstChild$data || "", "")

        if (node_cls$contains("root")) {
            # Do nothing and skip

        } else if (node_cls$contains("board")) {
            res$push("# " %+% data)

        } else if (node_cls$contains("row")) {
            res$push("## " %+% data)

        } else if (node_cls$contains("column")) {
            res$push("### " %+% data)

        } else {
            res$push(parse_dom(node))
        }

        # Handle the children
        for (child in node$children) {
            convert_html_to_markdown(child, res)
        }

    } else {
        res$push(parse_dom(node))
    }

    # Clean Markdown output and then join them into one string
    res$reduce(~.x %+% '\n' %+% .y)
}


# parser_dom :: DOM -> character
# parse_dom <- function(node) {
#     # "https://unpkg.com/showdown/dist/showdown.min.js"
#     converter <- showdown$Converter$new()
#     converter$makeMarkdown(node$outerHTML)
# }


# parser_dom :: DOM -> character
parse_dom <- function(node) {
    # "https://unpkg.com/turndown/dist/turndown.js"
    converter <- TurndownService$new()
    converter$turndown(node)
}


# JSBench.me: showdown is 3 times faster than turndown,
# but turndown generates more accurate conversion.
