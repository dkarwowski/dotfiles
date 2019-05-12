#!/usr/bin/sh -e

# screenshot
scrot /tmp/screen_locked.png

# pixellate
convert /tmp/screen_locked.png -scale 5% -scale 2000% -fill black -colorize 15% /tmp/screen_locked.png
# center lock icon
convert /tmp/screen_locked.png "$HOME/.config/i3lock/lock.png" -gravity center -composite -matte /tmp/screen_locked.png

# Lock screen this
i3lock -i /tmp/screen_locked.png -u -f && systemctl suspend
