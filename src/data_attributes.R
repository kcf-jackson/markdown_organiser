#! config(debug = T, rules = basic_rules(), deparsers = dp("basic", "auto"))

# There must be only one data attribute list and it must be at the end
# parse_text :: String -> String
parse_text <- function(text) {
    # Helpers
    result <- function(a, b) list(text = a, data_attr = b)
    last <- function(xs) xs[xs$length - 1]

    # Main
    text_arr <- text$split("")
    if (last(text_arr) != "}") return(result(text, "{}"))

    buffer <- ""
    open_cb <- 0
    while (text_arr$length > 0) {
        char0 <- text_arr$pop()
        if (char0 == "}") {
            open_cb <- open_cb + 1
            buffer <- char0 %+% buffer
            next
        }
        if (char0 == "{") {
            open_cb <- open_cb - 1
            buffer <- char0 %+% buffer
            if (open_cb == 0) {
                return(result(text_arr$join(""), buffer))
            }
            next
        }
        buffer <- char0 %+% buffer
    }

    # Unmatched brackets leave a non-empty buffer, which should
    # be treated as normal text.
    result(buffer, "{}")
}


# Unit test
# diagnose <- function(text) {
#     console::log("Input: ", text)
#     console::log("Output: ", parse_text(text), "\n")
# }
#
# diagnose("## heading {class: red, notes; time: 12.00;}")
# diagnose("## heading {1} {2}")
# diagnose("## heading {{a, b}}")
# diagnose("## heading {{a, b}")
# diagnose("## heading {{a, b}}}")
#
# diagnose("## heading {{1}} {2}")
# diagnose("## heading {1}} {2}")
# diagnose("## heading {{1} {2}")
#
# diagnose("## heading {1} {{2}}")
# diagnose("## heading {1} {2}}")
# diagnose("## heading {1} {{2}")
#
# diagnose("## heading {{1} {2}}")
