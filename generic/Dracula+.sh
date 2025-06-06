#!/bin/sh
# Dracula+

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  "21/22/2c"
put_template 1  "ff/55/55"
put_template 2  "50/fa/7b"
put_template 3  "ff/cb/6b"
put_template 4  "82/aa/ff"
put_template 5  "c7/92/ea"
put_template 6  "8b/e9/fd"
put_template 7  "f8/f8/f2"
put_template 8  "54/54/54"
put_template 9  "ff/6e/6e"
put_template 10 "69/ff/94"
put_template 11 "ff/cb/6b"
put_template 12 "d6/ac/ff"
put_template 13 "ff/92/df"
put_template 14 "a4/ff/ff"
put_template 15 "f8/f8/f2"

color_foreground="f8/f8/f2"
color_background="21/21/21"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8f8f2"
  put_template_custom Ph "212121"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "f8f8f2"
  put_template_custom Pk "545454"
  put_template_custom Pl "eceff4"
  put_template_custom Pm "282828"
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background
