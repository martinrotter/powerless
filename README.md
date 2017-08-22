# powerless
Tiny &amp; simple pure ZSH prompt inspired by powerline.

![alt text](https://raw.githubusercontent.com/martinrotter/powerless/master/screenshots/powerless.gif)

## What is this stuff?
This is fast and tiny set of ZSH scripts providing some nice ZSH setup, including powerline-inspired prompt and some other enhancements. The prompt offers some nice visual experience and information, including Git repositories metadata.

This is pure ZSH script and should work on any platform supported by ZSH. You do not need anything else like oh-my-zsh and similar shit. Just plain old working ZSH and terminal emulator with support of 255 colors. Tested on Linux (Terminix) and on Cygwin (mintty). So what exactly you need is:

* ZSH,
* terminal emulator.

**You do not need anything else, like powerline-enabled font. This prompt does NOT use special "powerline" characters, nor special UTF-8 characters. It relies on ASCII characters where possible.**

## What does the prompt show?
This is simple prompt which shows:

* current username (and hostname **if connected via SSH**),
* working directory,
* result code of previous command (**if differs from 0**),
* current Git branch (**if any**) and indication of dirty state,
* some specific situations are shown with special color (like error in previous command or root prompt).

## `utilities` script
There is additional `utilities.zsh` script which offers some extra goodies:

* custom keyboard bindings:
    * `Ctrl+Left/Right` - move cursor one word left/right,
    * `Home/End` - go to beginning/end of line,
    * `Ctrl+Backspace/Delete` - delete whole word left/right from cursor,
    * `Ctrl+Up/Down` - complete command line with previous/next matching item from history.
* ignore duplicates in history,
* allow folders to be browser without `cd`,
* persistent directory stack,
* simple & quite fast setup for completions.    
    
## Installation
1. Clone this repo into standalone folder: `git clone https://github.com/martinrotter/powerless.git powerless`.
2. Source main powerless script in your `.zshrc`: `source "/path/to/powerless/powerless.zsh"`.
3. **!optional!** In your `.zshrc`, source script `/path/to/powerless/utilities.zsh`. That will enable some advanced ZSH goodies like completion, aliases etc.