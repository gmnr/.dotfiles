#Requires AutoHotkey v2.0
#SingleInstance
#Hotstring EndChars `n?.,! `t     ; enter, space and tab trigger the hotstring

; send accented letters for string expansion
:?:a''::{Asc 133}      ; à'
:?:e""::{Asc 130}      ; é
:?:e''::{Asc 138}      ; è
:?:i''::{Asc 141}      ; ì
:?:o''::{Asc 149}      ; ò
:?:u''::{Asc 151}      ; ù

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

; add colemak-dh matrix key maps
SC012::f
SC013::p
SC014::b
SC015::j
SC016::l
SC017::u
SC018::y
SC019::;
SC01F::r
SC020::s
SC021::t
SC023::m
SC024::n
SC025::e
SC026::i
SC027::o
SC02f::d
SC030::v
SC031::k
SC032::h
