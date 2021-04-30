#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

# Interface
html_to_markdown <-  function(node) {
    node$cloneNode(TRUE) %>%
        rm_content_editable() %>%
        convert_html_to_markdown() %>%
        console_pipe(F)
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

    } else if (node$nodeName == "UL" || node$nodeName == "OL") {
        res$push(parse_dom(node) %+% "\n")

    } else {
        res$push(parse_dom(node))
    }

    # Clean Markdown output and then join them into one string
    res$reduce(~.x %+% '\n' %+% .y)
}


# parser_dom :: DOM -> character
parse_dom <- function(node) {
    # "https://unpkg.com/turndown/dist/turndown.js"
    converter <- TurndownService$new()
    converter$turndown(node)
}


# A see-through pipe function
console_pipe <- function(x, display) {
    if (display) console::log(x)
    x
}
