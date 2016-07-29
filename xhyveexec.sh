#!/bin/sh

CMD="cd '$(pwd)'; sudo ./xhyverun.sh && exit"

if [ "${TERM_PROGRAM}" = "Apple_Terminal" ] ; then
  osascript <<END
    tell application "Terminal"
      do script "${CMD}"
    end tell
END
elif [ "${TERM_PROGRAM}" = "iTerm.app" ] ; then
  VERSION=$(osascript -e 'tell application "iTerm" to version')
  VERSION=($(echo ${VERSION} | tr -s '.' ' '))
  WINDOW="window"
  if [[ ${VERSION[0]} -lt 2 ]]; then
    WINDOW="terminal"
  elif [[ (${VERSION[0]} -eq 2) && (${VERSION[1]} -lt 9) ]]; then
    WINDOW="terminal"
  fi
  osascript <<END
    tell application "iTerm"
      tell application "System Events" to keystroke "d" using {shift down, command down}
      tell the current session of current ${WINDOW} to write text "${CMD}"
      tell application "System Events" to keystroke "[" using {command down}
    end tell
END
fi
