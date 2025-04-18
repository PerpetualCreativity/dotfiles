prnt = require 'hs.console'.printStyledtext

-- from https://github.com/Hammerspoon/hammerspoon/issues/2386
function is_dark()
  local _, darkmode = hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode.get()")
  return darkmode
end

function handle(is_dark_t)
  theme = is_dark_t and "dark" or "light"
  output, status, type, rc = hs.execute("/opt/homebrew/bin/fish $HOME/.config/.bin/switch-theme " .. theme)
  prnt('status', status)
  prnt('type', type)
  prnt('rc', rc)
  prnt(output)
end

was_dark = is_dark()
handle(was_dark)

counter = 0

watcher = hs.distributednotifications.new(function(name, object, userInfo)
  is_dark_t = is_dark()
  if is_dark_t ~= was_dark then handle(is_dark_t) end
  was_dark = is_dark_t
end, 'AppleInterfaceThemeChangedNotification')

watcher:start()
