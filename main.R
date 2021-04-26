#! config(debug = T, rules = basic_rules(), deparsers = dp("basic", "dom", "auto"))
#! load_library("dom")
#! load_script("styles.css")

#! load_script("./assets/ace.min.js")
#! load_script("./assets/theme-monokai.min.js")
#! load_script("https://cdnjs.cloudflare.com/ajax/libs/marked/1.1.1/marked.min.js")

#! load_script("editor.R")

# UI
ui <- div(id = 'main',
    div(id = 'editor'),
    div(id = 'right',
        div(id = "parsed"),
        div(id = "rendered")))
render(ui)

renderer = list(
    heading = function(text, level) {
        escapedText <- text$toLowerCase()$replace(raw_str("/[^\\w]+/g"), '-')
        return(raw_str('`
        <h${level}>
            <a name="${escapedText}" class="anchor" href="#${escapedText}">
                <span class="header-link"></span>
                    </a>
                    ${text}
                </h${level}>`'))
    }
)
marked::use(list(renderer))

editor <- setup_ace_editor("editor", './assets')

# BLOCK LEVEL ----
# code(string code, string infostring, boolean escaped)
# blockquote(string quote)
# html(string html)
# heading(string text, number level, string raw, Slugger slugger)
# hr()
# list(string body, boolean ordered, number start)
# listitem(string text, boolean task, boolean checked)
# checkbox(boolean checked)
# paragraph(string text)
# table(string header, string body)
# tablerow(string content)
# tablecell(string content, object flags)
#
# Inline level renderer methods ----
# strong(string text)
# em(string text)
# codespan(string code)
# br()
# del(string text)
# link(string href, string title, string text)
# image(string href, string title, string text)
# text(string text)
