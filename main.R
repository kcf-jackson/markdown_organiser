#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

#! load_library("dom")
#! load_script("https://cdnjs.cloudflare.com/ajax/libs/marked/1.1.1/marked.min.js")
#! load_script("https://unpkg.com/showdown/dist/showdown.min.js")

#! load_script("./assets/styles.css")
#! load_script("./assets/ace.min.js")
#! load_script("./assets/theme-monokai.min.js")

#! load_script("editor.R")
#! load_script("marked_setup.R")
#! load_script("markdown_to_html.R")
#! load_script("html_to_markdown.R")

# UI
ui <- div(id = 'main',
    div(id = 'editor'),
    div(id = 'right',
        div(id = "token"),
        div(id = "parsed"),
        div(id = "rendered")))
render(ui)

# Setup markdown parser
marked::use({renderer})

# Setup markdown editor
editor <- setup_ace_editor("editor", './assets')
