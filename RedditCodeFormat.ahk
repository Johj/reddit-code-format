#NoEnv
#SingleInstance, Force

; Constants
TAB := "`t"
SPACES := "    " ; 4 spaces to indicate code comment on reddit
FILE_O = %A_ScriptDir%\formatted.txt

Gosub, OpenPrompt

return

; Labels
OpenPrompt:
	FileSelectFile, file_i, 3,, RedditCodeFormat - Select a file to format, AutoHotkey (*.ahk)
	if ErrorLevel {
		MsgBox, % 48 + 262144, RedditCodeFormat, No file was selected! Closing script..., 3
	}
	else {
		FileRead, file, %file_i%
		MsgBox, % 64 + 262144, Options, Press 1 for spaces.`nPress 2 for tabs.`nOK to close script.
	}
	ExitApp
return

WriteFile:
	IfExist, %FILE_O%
	{
		FileRecycle, %FILE_O%
	}
	FileAppend, %file%, %FILE_O%
return

ReplaceTabs:
	file := RegExReplace(file, TAB, SPACES)
return

ReplaceSpaces:
	file := RegExReplace(file, SPACES, TAB)
return

; Hotkeys
#IfWinExist, Options
1::
	Gosub, ReplaceTabs
	Gosub, WriteFile
return

2::
	Gosub, ReplaceSpaces
	Gosub, WriteFile
return
#IfWinExist