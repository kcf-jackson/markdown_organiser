#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

# UI helpers

# fa_icon :: String -> String -> DOM
fa_icon <- function(cls, text) {
    div(id = text, className = "icon",
        dom("i", list(className = cls, "aria-hidden" = TRUE)),
        div(innerText = text, style = "padding: 0 3px;"))
}

# hide :: String -> Empty
hide <- function(x) {
    select_dom(x)$style$display <- "none"
    x
}

# show :: String -> String -> Empty
show <- function(x, type = "block") {
    select_dom(x)$style$display <- type
    x
}

# send_shiny_request :: List -> Empty
send_shiny_request <- function(x) {
    Shiny::setInputValue("request", x, list(priority = "event"))
}

# template_option :: String -> String -> String -> DOM
template_option <- function(label0, value, image_file) {
    radio_dom <- input(type = "radio", id = value, value = value, name = "template")

    label_dom <- dom("label", list(innerText = label0, className = "bold"))
    label_dom$setAttribute("for", value)

    img_dom <- dom("label", list(),
                   img(src = image_file))
    img_dom$setAttribute("for", value)

    div(className = "template_option",
        div(radio_dom, label_dom),
        img_dom
    )
}
