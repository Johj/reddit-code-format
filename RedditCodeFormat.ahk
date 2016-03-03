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
	FileSelectFile, file_path, 3,, RedditCodeFormat - Select a file to format, AutoHotkey (*.ahk)
	if ErrorLevel {
		MsgBox, % 48 + 262144, RedditCodeFormat, No file was selected! Closing script..., 3
	}
	else {
		FileRead, FILE_I, %file_path%
		MsgBox, % 64 + 262144, Options, Press 1 for file -> Reddit.`nPress 2 for Reddit -> file.`nOK to close script.
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
	temp := ""
	file := RegExReplace(FILE_I, TAB, SPACES)
	Loop, Parse, file, `n, `r
	{
		temp .= SPACES . A_LoopField . "`n"
	}
	file := RegExReplace(temp, "`n$", "")
return

ReplaceSpaces:
	temp := ""
	file := RegExReplace(FILE_I, SPACES, TAB)
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
	Run, %FILE_O%
	ExitApp
return

2::
	Gosub, ReplaceSpaces
	Gosub, WriteFile
	Sleep, 500
	Run, %FILE_O%
	ExitApp
return
#IfWinExist