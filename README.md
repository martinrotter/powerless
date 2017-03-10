# powerless
Tiny &amp; simple pure ZSH prompt inspired by powerline.

### Terminix (Linux)
![alt text](https://raw.githubusercontent.com/martinrotter/powerless/master/screenshots/powerless.png)

### Mintty (Cygwin)
![alt text](https://raw.githubusercontent.com/martinrotter/powerless/master/screenshots/powerless-mintty.png)

## What is this stuff?
This is fast and tiny set of ZSH scripts providing some nice ZSH setup, including powerline-inspired prompt and some other enhancements. The prompt offers some nice visual experience and information, including Git repositories metadata.

This is pure ZSH script and should work on any platform supported by ZSH. You do not need anything else like oh-my-zsh and similar shit. Just plain old working ZSH and terminal emulator with support of 255 colors. Tested on Linux (Terminix) and on Cygwin (mintty). So what exactly you need is:

* ZSH,
* terminal emulator,
* Perl.

## What it shows?
This is simple prompt which shows:

* current hostname & username,
* working directory,
* result code of previous command,
* current Git branch (if any),
* current state of Git repository (if any), including:
    * "M" character if there are modified files,
    * "A" character if there are newly added files,
    * "D" character if there are newly deleted files,
    * "C" character if your work is ready for commit (this means that that there options "M", "A" and "D" are not present anymore).
* some specific situations are shown with special color (like error in previous command).

## Installation.
1. Make sure that you have some powerline-enabled font installed and activated in your terminal emulator.
2. Clone this repo into standalone folder: `git clone https://github.com/martinrotter/powerless.git powerless`.
3. Source main powerless script in your `.zshrc`: `source "/path/to/powerless/powerless.zsh"`.
4. **!optional!** In your `.zshrc`, source script `/path/to/powerless/utilities.zsh`. That will enable some advanced ZSH goodies like completion, aliases etc.
5. Make sure that your `.zshrc` does not contain any code which might conflict with powerless scripts.
6. Make sure that selected powerline-enabled font supports all the characters, check screenshots for comparison. I have good experience with DejaVu Sans Mono for Powerline.
