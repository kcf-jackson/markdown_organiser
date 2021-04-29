#! config(rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))

#! load_library("dom")
#! load_script("https://cdnjs.cloudflare.com/ajax/libs/marked/1.1.1/marked.min.js")
#! load_script("https://unpkg.com/showdown/dist/showdown.min.js")
#! load_script("https://code.jquery.com/jquery-3.6.0.min.js")

#! load_script("./assets/textarea_tab.js")
#! load_script("./assets/styles.css")

#! load_script("editor.R")
#! load_script("marked_setup.R")
#! load_script("markdown_to_html.R")
#! load_script("html_to_markdown.R")

# UI
ui <- div(id = 'main',
    div(id = 'editor', input_box),
    div(id = 'right'))
render(ui)

# Setup markdown parser
marked::use({renderer})
