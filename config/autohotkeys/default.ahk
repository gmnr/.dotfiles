#NoEnv                            ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input                    ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%       ; Ensures a consistent starting directory.
#NoTrayIcon                       ; disable icon in tray
#Hotstring EndChars `n?.,! `t     ; enter, space and tab trigger the hotstring

; send accented letters for string expansion
:?:a''::{Asc 133}      ; a
:?:e""::{Asc 130}      ; e acuto
:?:e''::{Asc 138}      ; e grave
:?:i''::{Asc 141}      ; i
:?:o''::{Asc 149}      ; o
:?:u''::{Asc 151}      ; u

; ctrl+ brackets to move between tabs
^[::^PgUp
^]::^PgDn

; caps lock behavoiur >> tap for `esc` hold for `ctrl`
*CapsLock::
    Send {Blind}{Ctrl Down}
    cDown := A_TickCount
Return

*CapsLock up::
    If ((A_TickCount-cDown)<100)  ; Modify press time as needed (milliseconds)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
Return

