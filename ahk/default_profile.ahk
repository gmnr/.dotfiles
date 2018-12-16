#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon ; disable icon in tray

; use Esc with Capslock
Capslock::Esc 

; useful quitting
;- easy delete
^q::Send {Delete}
return

; make window always on top
^=:: Winset, Alwaysontop, , A

; MEDIA KEYS MAPPINGS
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

; Run vim
^.::run, "C:\Program Files (x86)\Vim\vim80\gvim.exe", C:\Users\rem\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc\LocalState\rootfs\home\guido

; Run Sublime Text 3
^/::run, "C:\Program Files\Sublime Text 3\sublime_text.exe"

; Run Spotify
^|::run spotify.exe

; Launch Snipping tool
^\::
IfWinExist Snipping Tool
	WinActivate
else
	Run "c:\windows\system32\SnippingTool.exe"
    WinWait,  Snipping Tool,,1
	ControlClick, x11 y45, Snipping Tool
return
