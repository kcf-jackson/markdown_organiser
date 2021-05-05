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
#! load_script("../assets/shiny.min.js")

#! load_script("../assets/styles.css")
#! load_script("../assets/tailwind_colors.css")

#! load_script("ui.R")
#! load_script("editor.R")
#! load_script("add_ons.R")
#! load_script("marked_setup.R")
#! load_script("markdown_to_html.R")
#! load_script("html_to_markdown.R")
#! load_script("data_attributes.R")
#! load_script("shiny.R")

# Global variable
GLOBAL <- list(pointer = NULL,
               sortable = Array(),
               caret = 0)

# UI layout
ui <- div(id = 'main',
    div(id = "sidebar",
        fa_icon("fa fa-floppy-o", "Save"),
        fa_icon("fa fa-folder-open-o", "Load"),
        fa_icon("fa fa-clipboard", "Template"),
        fa_icon("fa fa-info-circle", "Info")),
    div(id = 'editor', input_box),
    div(id = 'right'))
render(ui)

overlay <- div(id = "overlay", className = "overlay")
render(overlay)

template_page <- div(
    id = "template_page_container",
    className = "display-none",
    div(
        id = "template_page",
        template_option("Kanban Todo", "kanban", "/img/kanban.png"),
        template_option("Daily Planner", "daily-planner", "/img/daily.png"),
        template_option("Weekly Planner", "weekly-planner", "/img/weekly.png"),
        template_option("Monthly Planner", "monthly-planner", "/img/monthly.png"),
        div(style = "display:flex; flex-direction:row;",
            button(innerText = "OK", id = "okay"),
            button(innerText = "Cancel", id  ="cancel")
        )
    )
)
render(template_page, "#overlay")

help_page <- div(id = "help_page_container", className = "display-none",
                 div(id = "help_page"))
render(help_page, "#overlay")


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

select_dom(".overlay")$onclick <- function(evt) {
    if (evt$target == this) {
        hide("#overlay")
        hide("#template_page_container")
        hide("#help_page_container")
    }
}

select_dom("#Template")$onclick <- function() {
    # Record textarea caret
    GLOBAL$caret <- select_dom("textarea")$selectionStart
    show("#template_page_container")
    show("#overlay")
}

select_dom("#Info")$onclick <- function() {
    # Click --> Shiny Server --> "render_help" in pages.R
    send_shiny_request(list(type = "help_page", message = NULL))
    show("#help_page_container")
    show("#overlay")
}

select_dom("#cancel")$onclick <- function() {
    hide("#overlay")
    hide("#template_page_container")
    hide("#help_page_container")
}

select_dom("#okay")$onclick <- function() {
    for (x in select_doms("input[name='template']")) {
        if (x$checked) {
            send_shiny_request(list(type = "template_page", message = x$value))
        }
    }
    TRUE
}


# Setup markdown parser
window$onload <- function() {
    marked::use({renderer})
    send_shiny_request(list(type = "setup", message = NULL))
}
