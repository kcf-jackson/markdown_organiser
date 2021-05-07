library(shiny)
source("calendar.R")


# # Compile R files on-the-fly
# # This is commented out because shinyapps.io has difficulty inferring
# # the correct dependencies. So the compilation is done ahead of time
# # instead.
# remotes::install_github("kcf-jackson/sketch", "experiment")
# setwd("./src")
# file.copy(
#     sketch::source_r("main.R", launch_browser = NULL),
#     "../www/index.html", overwrite = T
# )
# setwd("../")


# Define server logic to handle templates and file IO
server <- function(input, output, session) {
    observeEvent(input$request,{
         req <- input$request
         if (req$type == "template_page") {
             if (req$message == "kanban") {
                 template <- file_to_json("./data/kanban.md")
             }
             if (req$message == "daily-planner") {
                 template <- file_to_json("./data/daily_planner.md")
             }
             if (req$message == "weekly-planner") {
                 template <- file_to_json("./data/weekly_planner.md")
             }
             if (req$message == "monthly-planner") {
                 template <- jsonlite::toJSON(
                     paste(
                         paste(readLines("./data/monthly_planner.md"),
                               collapse = "\n"),
                         calendar_table(this_year(), this_month()),
                         sep = "\n"
                     ),
                     auto_unbox = TRUE
                 )
             }
             session$sendCustomMessage("render_template", template)
         }

         if (req$type == "help_page") {
             help_desc <- file_to_json("./data/description.md")
             session$sendCustomMessage("render_help", help_desc)
         }

         if (req$type == "setup") {
             textarea_desc <- file_to_json("./data/sample_input.md")
             session$sendCustomMessage("render_textarea", textarea_desc)
         }
    })
}

file_to_json <- function(x) {
    jsonlite::toJSON(
        paste(readLines(x), collapse = "\n"),
        auto_unbox = TRUE
    )
}


# Run the application
shinyApp(ui = htmlTemplate("./www/index.html"), server)
