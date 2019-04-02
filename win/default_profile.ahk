#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon ; disable icon in tray
#Hotstring EndChars `n!? `t ; enter, space and tab trigger the hotstring

; F12 to toggle the script
F12::Suspend, Toggle

; use Esc with Capslock
Capslock::Esc 

; Next Song
^0::Send {Media_Next}

; Previous Song
^8::Send {Media_Prev}

; Play/Pause
^9::Send {Media_Play_Pause}

; Volume up
+PgUp::Send {Volume_Up 5}

; Volume down
+PgDn::Send {Volume_Down 5}

; Mute Mic with WIN + F4 in Skype for Business
^m::Send #{F4}

; make window always on top
^=:: Winset, Alwaysontop, , A

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
