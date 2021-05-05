#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))


# Make items content-editable ---------------------------------------------
enable_content_editable <-  function(node) {
    node$onclick <- function(evt) {
        el <- evt$target
        if (GLOBAL$pointer == el) return(NULL)

        GLOBAL$pointer <- el
        rm_content_editable(node)
        if (!el$classList$contains("root")) {
            el$contentEditable <- TRUE
            el$focus()
        }
    }
    node
}

rm_content_editable <- function(x) {
    x$removeAttribute("contentEditable")
    for (child in x$children) {
        rm_content_editable(child)
    }
    x
}



# Make items sortable ---------------------------------------------------
enable_sortable <- function() {
    for (selector in Array(".root", ".board", ".row",
                           ".row-content", ".column", "ul", "ol")) {
        for (head in select_doms(selector)) {
            options <- list(group = selector,
                            animation = 150,
                            swapThreshold = 1,
                            dragClass = "lightgray")
            s <- Sortable$new(head, options)
            # Keep a reference for destruction later
            GLOBAL$sortable$push(s)
        }
    }
    NULL
}

destroy_sortable <- function(xs) {
    while (xs$length > 0) {
        s <- xs$pop()
        s$destroy()
    }
    xs
}



# Enable reverse update from HTML to Markdown -----------------------------
enable_reverse_update <- function(node) {
    rev_update <- compose(update_input_box, html_to_markdown)
    node %>%
        add_reactive_update(rev_update)
}

# Watch a node and call `f` for when the node changes
add_reactive_update <- function(node, f) {
    options <- list(attributes = T, subtree = T, characterData = T)
    guard <- MutationObserver$new(function() { f(node) })
    guard$observe(node, options)
    node
}

# Update the value of the editor
update_input_box <- function(res, id = "#input") {
    select_dom(id)$value <- res
    NULL
}

# Compose two functions
compose <- function(f, g) {
    function(x) f(g(x))
}
