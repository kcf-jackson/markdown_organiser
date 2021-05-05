Shiny::addCustomMessageHandler(
    "render_help",
    function(message) {
        select_dom("#help_page")$innerHTML <- marked(message)
        TRUE
    }
)

Shiny::addCustomMessageHandler(
    "render_template",
    function(message) {
        message <- message %+% '\n\n'

        position <- GLOBAL$caret
        new_position <- GLOBAL$caret + message$length

        cval <- select_dom("textarea")$value
        new_val <- cval$slice(0, position) %+% message %+% cval$slice(position)

        textarea <- select_dom("textarea")
        textarea$value <- new_val
        textarea$selectionStart <- new_position
        GLOBAL$caret <- new_position

        textarea$oninput()
    }
)

Shiny::addCustomMessageHandler(
    "render_textarea",
    function(message) {
        select_dom("textarea")$value <- message
        select_dom("textarea")$oninput()
    }
)
