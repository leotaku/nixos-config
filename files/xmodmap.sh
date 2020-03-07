#!/usr/bin/env sh
setxkbmap -layout de -option altgr-intl -variant nodeadkeys

# Arrow keys on AltGr+hjkl
xmodmap /dev/stdin <<< "
keycode 43 = h H NoSymbol NoSymbol Left   NoSymbol
keycode 44 = j J NoSymbol NoSymbol Down   NoSymbol  
keycode 45 = k K NoSymbol NoSymbol Up     NoSymbol  
keycode 46 = l L NoSymbol NoSymbol Right  NoSymbol  
"

# All parens on umlauts
xmodmap /dev/stdin <<< "
keycode 47 = parenleft parenright NoSymbol NoSymbol parenleft    NoSymbol
keycode 48 = bracketleft bracketright D NoSymbol NoSymbol bracketleft  NoSymbol
keycode 34 = braceleft braceright NoSymbol NoSymbol braceleft    NoSymbol
"

xmodmap /dev/stdin <<< "
keycode 38 = a A NoSymbol NoSymbol adiaeresis Adiaeresis
keycode 32 = o O NoSymbol NoSymbol odiaeresis Odiaeresis
keycode 30 = u U NoSymbol NoSymbol udiaeresis Udiaeresis
"

# Page up and down to prev and next
xmodmap /dev/stdin <<< "
keycode 112 = XF86Back NoSymbol NoSymbol NoSymbol NoSymbol NoSymbol
keycode 117 = XF86Forward NoSymbol NoSymbol NoSymbol NoSymbol NoSymbol
"

xdouble() {
    key="$1"
    mod="$2"
    
    xmodmap /dev/stdin <<< "
    keysym $key = $mod
    keycode any = $key"

    xcape -e "$mod=$key"
}


kill $(pgrep xcape)
xcape -e 'ISO_Level3_Shift=Escape'
xcape -e 'Alt_L=Control_L|G'
#xcape -e 'Alt_L=Control_L|X'

xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Accel Speed" 0.21
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Disable While Typing Enabled" 1
