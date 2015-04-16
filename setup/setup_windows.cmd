rem Linking might work on Vista+; it doesn't work well on XP.
rem mklink requires administrator privileges.

if not exist "%HOME%\vimfiles" (
  mklink /d "%HOME%\vimfiles" "%~dp0.."
)
if not exist "%HOME%\.vimrc" (
  mklink "%HOME%\.vimrc" "%~dp0..\.vimrc"
)
