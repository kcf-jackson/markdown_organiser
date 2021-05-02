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
            res$push("# " %+% data %+% classList_to_metadata(node_cls, "board"))

        } else if (node_cls$contains("row") || node_cls$contains("row-content")) {
            # Do nothing and skip

        } else if (node_cls$contains("row-text")) {
            p_node_cls <- node$parentNode$classList
            res$push("## " %+% data %+% classList_to_metadata(p_node_cls, "row"))

        } else if (node_cls$contains("column")) {
            res$push("### " %+% data %+% classList_to_metadata(node_cls, "column"))

        } else {
            res$push(parse_dom(node))
        }

        # Handle the children
        for (child in node$children) {
            convert_html_to_markdown(child, res)
        }

    } else if (node$nodeName == "UL" ||
               node$nodeName == "OL" ||
               node$nodeName == "P") {
        res$push(parse_dom(node) %+% "\n")

    } else {
        res$push(parse_dom(node))
    }

    # Clean Markdown output and then join them into one string
    res$reduce(~.x %+% '\n' %+% .y)
}


# parse_dom :: DOM -> character
parse_dom <- function(node) {
    # "https://unpkg.com/turndown/dist/turndown.js"
    converter <- TurndownService$new()
    converter$use(turndownPluginGfm::gfm)
    converter$turndown(node)
}


# A see-through pipe function
console_pipe <- function(x, display) {
    if (display) console::log(x)
    x
}


# classList_to_metadata :: Array -> String
classList_to_metadata <- function(xs, exclude) {
    sortable_ls <- Array("sortable-chosen", "sortable-ghost", "sortable-drag")
    res <- Array(...xs)$
        filter(x %=>% !sortable_ls$includes(x))$
        filter(x %=>% x != exclude)$
        join(", ")
    if (res != "") return("{" %+% res %+% "}")
    res
}
