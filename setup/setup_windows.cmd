rem Linking might work on Vista+; it doesn't work well on XP.
rem mklink requires administrator privileges.

mklink /d "%USERPROFILE%\vimfiles" "%~dp0.."
mklink "%USERPROFILE%\.vimrc" "%~dp0..\.vimrc"
