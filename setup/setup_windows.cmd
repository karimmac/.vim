rem mklink requires administrator privileges.

mklink /d "%USERPROFILE%\vimfiles" "%~dp0.."
mklink "%USERPROFILE%\.vimrc" "%~dp0..\.vimrc"
