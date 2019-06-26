#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon ; disable icon in tray
#Hotstring EndChars `n?.,! `t ; enter, space and tab trigger the hotstring
;(also include puntuation)

; use Esc with Capslock
Capslock::Esc 
Esc::Capslock

; Next Song
#Right::Send {Media_Next}

; Previous Song
#Left::Send {Media_Prev}

; Play/Pause
#Space::Send {Media_Play_Pause}

; Volume up
#Up::Send {Volume_Up 5}

; Volume down
#Down::Send {Volume_Down 5}

; Mute Mic with WIN + F4 in Skype for Business
^m::Send #{F4}

; make window always on top
^]:: Winset, Alwaysontop, , A

; Run Spotify
^|::run "C:\Users\guido.minieri\AppData\Roaming\Spotify\Spotify.exe"

; Run Vim
^?::run, "C:\Program Files (x86)\Vim\vim81\gvim.exe", C:\Users\guido.minieri


; send accented letters
:?:a''::{Asc 133}   ; a
:?:e'''::{Asc 130}   ; e acuto
:?:e''::{Asc 138}   ; e grave
:?:i''::{Asc 141}  ; i
:?:o''::{Asc 149}   ; o
:?:u''::{Asc 151}  ; u



; Launch Snipping tool
^\::
IfWinExist Snipping Tool
	WinActivate
else
	Run "c:\windows\system32\SnippingTool.exe"
    WinWait,  Snipping Tool,,1
	ControlClick, x11 y45, Snipping Tool
return

!`:: ; Next window
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
Loop, % List
{
    index := List - A_Index + 1
    WinGet, State, MinMax, % "ahk_id " List%index%
    if (State <> -1)
    {
        WinID := List%index%
        break
    }
}
WinActivate, % "ahk_id " WinID
return

!^`:: ; Last window
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
Loop, % List
{
    index := List - A_Index + 1
    WinGet, State, MinMax, % "ahk_id " List%index%
    if (State <> -1)
    {
        WinID := List%index%
        break
    }
}
WinActivate, % "ahk_id " WinID
return
