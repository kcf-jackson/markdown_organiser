#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

linear_to_tree <- function(ps) {
    root <- div(className = "root")
    pointer <- list(board = NULL, row = NULL, col = NULL)
    for (p in ps) {
        if (p$classList$contains("board")) {
            pointer$board <- p
            root$appendChild(p)
            next
        }
        if  (p$classList$contains("row")) {
            pointer$row <- p
            pointer$board$appendChild(p)
            next
        }
        if  (p$classList$contains("column")) {
            pointer$col <- p
            pointer$row$appendChild(p)
            next
        }
        pointer$col$appendChild(p)
    }
    root
}

string_to_dom <- function(x) {
    div(innerHTML = x)$firstElementChild
}
