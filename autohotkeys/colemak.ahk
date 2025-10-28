#Requires AutoHotkey v2.0
#SingleInstance

; requires a colemak layout installed on win, and remaps the different keys for colemak-dh matrix
SC014::b
SC015::j
SC023::m
SC02f::d
SC030::v
SC031::k
SC032::h
SC022::g

; hotstring for accented letters
:?C*:a''::à
:?C*:e""::é
:?C*:e''::è
:?C*:i''::ì
:?C*:o''::ò
:?C*:u''::ù

; right altgr as winkey
LControl & RAlt::RWin

; ctrl+ brackets to move between tabs
^[::^PgUp
^]::^PgDn

; caps lock behavoiur >> tap for `esc` hold for `ctrl`
*CapsLock::Send "{Blind}{Ctrl DownR}"
*CapsLock Up::
{
  Send "{Blind}{Ctrl up}"
  If (A_PriorKey = "CapsLock")
    Send "{Esc}"
}
