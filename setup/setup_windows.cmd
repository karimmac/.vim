rem Linking might work on Vista+; it doesn't work well on XP.
rem mklink requires administrator privileges.

mklink /d "%HOME%\vimfiles" "%~dp0.."
mklink "%HOME%\.vimrc" "%~dp0..\.vimrc"
