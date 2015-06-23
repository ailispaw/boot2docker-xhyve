set TERM_PROGRAM to (system attribute "TERM_PROGRAM")

set COMMAND to "sudo ./xhyverun.sh && exit"

if TERM_PROGRAM = "Apple_Terminal" then
  set UnixPath to POSIX path of ((path to me as text) & "::")
  tell application "Terminal"
    do script "cd " & UnixPath & "; " & COMMAND
  end tell
else if TERM_PROGRAM = "iTerm.app" then
  tell application "iTerm"
    tell application "System Events" to keystroke "d" using {shift down, command down}
    tell application "System Events" to keystroke "[" using {command down}
    tell the last session of current terminal
      write text COMMAND
    end tell
  end tell
end if
