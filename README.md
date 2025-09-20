A Powerline-Style PS1 for BASH

![2021-06-20_01-10.png](http://zw963.github.io/images/11278115292820.png)

You probaly need install a font that supports Powerline symbols.

e.g. `PowerlineSymbols.otf`(included in this project) or `FiraCode-Regular-Symbol.otf` etc.

Following code install `PowerlineSymbols.otf` into `~/.local/share/fonts`

```sh
mkdir -p ~/.local/share/fonts
cp PowerlineSymbols.otf ~/.local/share/fonts
fc-cache -rf
```

Note: This script has only been tested with BASH, I've been using it for over ten 
years only with a little modifications, and it works quite well for me.

However, it may not work correctly with other shells.

It also integrates automatically with [RVM](https://rvm.io/) and [asdf](https://asdf-vm.com/) and git.

# How to use it.

Add the following lines to your `~/.bashrc`:

```sh
# Git provides this file; some functions from it are used in PS1
source /the/path/of/git-prompt.sh

source /the/path/of/powerbash.sh
```
