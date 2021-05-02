#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

renderer = list(
    heading = function(text, level) {
        if (level == 1) return(class_div("board", text, add_class))
        if (level == 2) return(class_row("row", text, add_class))
        if (level == 3) return(class_div("column", text, add_class))
        if (level == 4) return(class_div("line", text, add_class))
        raw_str('`<h${level}>${text}</h${level}>`')
    }
)

# class_div :: character -> character
class_div <- function(classname, text, f = id) {
    ptext <- parse_text(text)
    text <- ptext$text
    res <- div(className = classname, innerText = text)
    f(res, ptext)$outerHTML
}

class_row <- function(classname, text, f = id) {
    ptext <- parse_text(text)
    text <- ptext$text
    res <- div(className = "row",
        div(className = "row-text", innerText = text),
        div(className = "row-content")
    )
    f(res, ptext)$outerHTML
}

id <- function(x) x


# Extending Markdown entries by metadata / fields
add_class <- function(el, ptext) {
    attr <- ptext$data_attr
    class_list <- attr$
        substr(1, attr$length - 2)$
        split(",")$
        map(x %=>% x$trim())$
        filter(x %=>% x != "")

    if (class_list$length > 0) {
        el$classList$add(...class_list)
    }
    el
}

add_data <- function() {}

unescape_html <- function(x) {
    x$replaceAll("&quot;", "\"")$
        replaceAll("&apos;", "\'")$
        replaceAll("&amp;", "&")$
        replaceAll("&lt;", "<")$
        replaceAll("&gt;", ">")
}
