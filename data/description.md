# A minimalist Markdown organiser {heading-1}

## Semantics {v-margin-0}
*   `#` => `h1` => `Board`
*   `##` => `h2` => `Row`
*   `###` => `h3` => `Column`

## Features {v-margin-0}
*   All cards and items are **editable** and **movable**. **Click** to edit the text, and **Drag** to move the objects.
*   Updates are bidirectional (redundant new-lines and whitespaces in the Markdown file are not preserved)
*   Support basic colour options at the heading levels (1, 2, and 3). Colour options are encoded as `COLOUR-WEIGHT`, where 
    - `COLOUR` can be one of {`gray, red, yellow, green, blue, indigo, purple, pink`}, and 
    - `WEIGHT` can be one of {`50, 100, 200, 300, ..., 900`}. 
    
    To use the colour, simple wrap the colour option in curly bracket and add it to the end of a heading, e.g. `# Board {blue-100}`.

## Q and A {v-margin-0}
*   Q. What is this app about?  
    A. This is an experiment to extend Markdown's functionality without changing its syntax or forgoing its plain-text appeal. I made this because I like the simplicity and robustness of plain text, and I also like having visual aids and being able to interact with data in an intuitive way. 
    
*   Q. How do I copy a card?  
    A. It's Markdown, copying a card is just copying the text!
    
*   Q. Is there a search function?  
    A. It's Markdown, Ctrl / Cmd-F would work as usual!

*   Q. How is this app built?  
    A. This app is built with the R packages [sketch](https://github.com/kcf-jackson/sketch/tree/experiment) and  [shiny](https://shiny.rstudio.com/) and various JavaScript libraries  ([marked.js](https://marked.js.org/), [turndown.js](https://github.com/domchristie/turndown) and [sortable.js](https://sortablejs.github.io/Sortable/)). 

*   Q. Can I customise it?  
    A. Yes! Fork the repository and start by modifying the `styles.css` file (or even the R source code directly)!
