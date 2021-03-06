local msg = require 'mp.msg'
local utils = require 'mp.utils'

msg.info("v0.1 loaded")

local function set_clipboard(text)
   mp.commandv("run", "/bin/bash", "-c", "printf '"..text.."' | xsel");
end

function copyurl()
   local url = mp.get_property("path")
   set_clipboard(url)
   mp.osd_message("copied "..url)
end

mp.add_key_binding("Ctrl+u", "copyurl", copyurl)

local function get_clipboard()
   local args = { 'xclip', '-selection', primary and 'primary' or 'clipboard', '-out' }
   return utils.subprocess({ args = args, cancellable = false }).stdout
end

function addurl()
   local url = get_clipboard()
   url = url:gsub("subscriptions.gir.st", "youtube.com")
   url = url:gsub("invidious.snopyta.org", "youtube.com")

   if url then
      mp.commandv("loadfile", url, "append-play")
      mp.osd_message("added "..url)
   end
end

mp.add_key_binding("Ctrl+a", "addurl", addurl)
