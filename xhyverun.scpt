tell application "iTerm"
  tell application "System Events" to keystroke "d" using {shift down, command down}
  tell application "System Events" to keystroke "[" using {command down}
  tell the last session of current terminal
    write text "sudo ./xhyverun.sh && exit"
  end tell
end tell
