package = "wc3codex"
version = "1.0-1"
source = {
   url = "..."
}
description = {
   summary = "A Warcraft III files codec.",
   detailed = [[
      Codecs for Warcraft III files.
   ]],
   homepage = "...", -- We don't have one yet
   license = "GPL" -- or whatever you like
}
dependencies = {
   "lua >= 5.3",
   "rapidjson >= 0.6.1-1"
}
build = {
   type = "builtin",
   modules = {}
}