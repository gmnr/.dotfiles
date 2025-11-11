#Requires AutoHotkey v2.0
#SingleInstance

; requires a windows colemak layout and remaps only colemak-dh matrix key maps
SC014::b
SC015::j
SC023::m
SC02f::d
SC030::v
SC031::k
SC032::h
SC022::g


; implement accented letters w/ hotstring
:?C*:a''::à
:?C*:e""::é
:?C*:e''::è
:?C*:i''::ì
:?C*:o''::ò
:?C*:u''::ù


; remap F10, F11 and F12 to media controls
F10::Media_Prev
F11::Media_Play_Pause
F12::Media_Next


; remap space plus keys
Space::return
Space Up::{
    if (A_PriorKey = "Space")
    {
        Send "{Space}"
    }
    return
    }

Space & 1::F1
Space & 2::F2
Space & 3::F3
Space & 4::F4
Space & 5::F5
Space & 6::F6
Space & 7::F7
Space & 8::F8
Space & 9::F9
Space & 0::F10
Space & -::F11
Space & =::F12


; right altgr as winkey
LControl & RAlt::RWin


; ctrl+ brackets to move between tabs
^[::^PgUp
^]::^PgDn


; caps lock behavoiur >> tap for esc and hold for ctrl
*CapsLock::Send "{Blind}{Ctrl DownR}"
*CapsLock Up::
{
    Send "{Blind}{Ctrl up}"
    If (A_PriorKey = "CapsLock")
        Send "{Esc}"
}
