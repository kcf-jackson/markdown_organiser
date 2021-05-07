# A minimalist Markdown based organiser
## Basic
### Semantics {w-60}
*   `h1` => `Board`
*   `h2` => `Row`
*   `h3` => `Column`

### Features
*   All cards and items are **editable** and **movable**. **Click** to edit the text, and **Drag** to move the objects.

*   Updates are **bidirectional**. Redundant new-lines and whitespaces in the Markdown file are not preserved.

*   Support CSS classes from the [tailwind](https://tailwindcss.com/) CSS framework at the heading levels (1, 2, and 3). For example, background colour options are encoded as `bg-COLOUR-WEIGHT`, where

    *   `COLOUR` can be one of {`gray, red, yellow, green, blue, indigo, purple, pink`}, and
    *   `WEIGHT` can be one of {`50, 100, 200, 300, ..., 900`}.
*   To use the colour, simple wrap the colour option in curly bracket and add it to the end of a heading, e.g. `# Board {bg-yellow-100}`.

# Project lists
_Some interesting projects that excite you_

## Project 1
### Todo
*   item 1
*   item 2

### Doing {bg-yellow-100}
*   item 1
*   item 2
*   item 3

### Done
*   item 1

## Project 2
### Todo
*   item 1
*   item 2

### Doing {bg-yellow-100}
*   item 1
*   item 2
*   item 3

### Done
*   item 1

# Weekly Task Planner
_Some uplifting quote that makes you productive_

## Week 17 (3 May -  9 May)
### Monday
*   item 1
*   item 2

### Tuesday
*   item 1
*   item 2

### Wednesday
*   item 1
*   item 2

### Thursday
*   item 1
*   item 2

### Friday
*   item 1
*   item 2

### Saturday
*   item 1
*   item 2

### Sunday
*   item 1
*   item 2

## Week 18 (10 May - 16 May)
### Monday
*   item 1
*   item 2

### Tuesday
*   item 1
*   item 2

### Wednesday
*   item 1
*   item 2

### Thursday
*   item 1
*   item 2

### Friday
*   item 1
*   item 2

### Saturday
*   item 1
*   item 2

### Sunday
*   item 1
*   item 2

# Notes / Buffers
## Note 1
This is handy when you need to take some quick notes.

## Note 2
Here is another note.
