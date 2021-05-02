#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

renderer = list(
    heading = function(text, level) {
        if (level == 1) return(class_div("board", text))
        if (level == 2) return(class_row("row", text))
        if (level == 3) return(class_div("column", text))
        if (level == 4) return(class_div("line", text))
        raw_str('`<h${level}>${text}</h${level}>`')
    }
)

# class_div :: character -> character
class_div <- function(classname, text) {
    div(className = classname, innerText = text)$outerHTML
}

class_row <- function(classname, text) {
    res <- div(className = "row",
        div(className = "row-text", innerText = text),
        div(className = "row-content")
    )
    res$outerHTML
}
