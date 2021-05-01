#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

make_content_editable <- function(x) {
    x$contentEditable <- TRUE
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

# Make items sortable
enable_sortable <- function() {
    for (selector in Array(".root", ".board", ".row", ".column",
                           "ul", "ol")) {
        for (head in select_doms(selector)) {
            options <- list(group = selector, animation = 150,
                            swapThreshold = 0.60)
            s <- Sortable$new(head, options)
            # Keep a reference for destruction later
            GLOBAL$sortable$push(s)
        }
    }
    NULL
}

destory_sortable <- function(xs) {
    while (xs$length > 0) {
        s <- xs$pop()
        s$destroy()
    }
    xs
}
