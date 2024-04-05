shortcutName := "hk.lnk"
shortcutPath := A_Startup . "\" . shortcutName

FileCreateShortcut, %A_ScriptFullPath%, %shortcutPath%, %A_ScriptDir%

AppsKey::Run, powershell.exe -nologo -noprofile -file %A_ScriptDir%\hk.ps1