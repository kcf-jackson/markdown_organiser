#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

linear_to_tree <- function(ps) {
    root <- div(className = "root")
    pointer <- list(board = NULL, row = NULL, col = NULL)
    active_header <- root
    for (p in ps) {
        if (p$classList$contains("board")) {
            pointer$board <- p
            active_header <- p
            root$appendChild(p)
            next
        }
        if  (p$classList$contains("row")) {
            pointer$row <- p
            active_header <- p
            pointer$board$appendChild(p)
            next
        }
        if  (p$classList$contains("column")) {
            pointer$col <- p
            active_header <- p
            pointer$row$appendChild(p)
            next
        }
        active_header$appendChild(p)
    }
    root
}

string_to_dom <- function(x) {
    div(innerHTML = x)$firstElementChild
}
