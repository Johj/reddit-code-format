#NoEnv
#SingleInstance, Force

; Constants
TAB := "`t"
SPACES := "    " ; 4 spaces to indicate code comment on reddit
FILE_OUT_PATH = %A_ScriptDir%\formatted.txt

Gosub, ReadFile

return

; Labels
ReadFile:
	FileSelectFile, FILE_IN_PATH, 3,, RedditCodeFormat - Select a file to format, AutoHotkey (*.ahk)
	if ErrorLevel {
		MsgBox, % 48 + 262144, RedditCodeFormat, No file was selected! Closing script..., 3
	}
	else {
		FileRead, file, %FILE_IN_PATH%
		MsgBox, % 64 + 262144, Options, Press 1 for file -> Reddit.`nPress 2 for Reddit -> file.`nOK to close script.
	}
	ExitApp
return

WriteFile:
	IfExist, %FILE_OUT_PATH%
	{
		FileRecycle, %FILE_OUT_PATH%
	}
	FileAppend, %file%, %FILE_OUT_PATH%
return

ReplaceTabs:
	temp := ""
	file := RegExReplace(file, TAB, SPACES)
	Loop, Parse, file, `n, `r
	{
		temp .= SPACES . A_LoopField . "`n"
	}
	file := RegExReplace(temp, "`n$", "")
return

ReplaceSpaces:
	temp := ""
	file := RegExReplace(file, SPACES, TAB)
	Loop, Parse, file, `n, `r
	{
		temp .= RegExReplace(A_LoopField, "^" . TAB, "") . "`n"
	}
	file := RegExReplace(temp, "`n$", "")
return

; Hotkeys
#IfWinExist, Options
1::
	Gosub, ReplaceTabs
	Gosub, WriteFile
	Sleep, 500
	Run, %FILE_OUT_PATH%
	ExitApp
return

2::
	Gosub, ReplaceSpaces
	Gosub, WriteFile
	Sleep, 500
	Run, %FILE_OUT_PATH%
	ExitApp
return
#IfWinExist