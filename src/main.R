#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

#! load_library("dom")
#! load_library("fontawesome")
#! load_library("io")

#! load_script("../assets/marked.min.js")
#! load_script("../assets/turndown.js")
#! load_script("../assets/turndown-plugin-gfm.js")
#! load_script("../assets/Sortable.min.js")

#! load_script("../assets/jquery-3.6.0.min.js")
#! load_script("../assets/textarea_tab.js")

#! load_script("../assets/styles.css")
#! load_script("../assets/tailwind_colors.css")

#! load_script("editor.R")
#! load_script("add_ons.R")
#! load_script("marked_setup.R")
#! load_script("markdown_to_html.R")
#! load_script("html_to_markdown.R")
#! load_script("data_attributes.R")

# Global variable
GLOBAL <- list(pointer = NULL,
               sortable = Array())

# UI helpers
fa_icon <- function(cls, text) {
    div(id = text, className = "icon",
        dom("i", list(className = cls, "aria-hidden" = TRUE)),
        div(innerText = text))
}

# UI layout
ui <- div(id = 'main',
    div(id = "sidebar",
        fa_icon("fa fa-floppy-o", "Save"),
        fa_icon("fa fa-folder-open-o", "Load"),
        fa_icon("fa fa-clipboard", "Template"),
        fa_icon("fa fa-question-circle", "Help")),
    div(id = 'editor', input_box),
    div(id = 'right'))
render(ui)

# UI behaviour
select_dom("#Save")$onclick <- function() {
    write(input_box$value, "markdown_org.md")
}

select_dom("#Load")$onclick <- function() {
    scan(function(text) {
        input_box$value <- text
        input_box$oninput()
    })
}

# Setup markdown parser
marked::use({renderer})
