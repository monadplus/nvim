local fileExtension = '.lua'

local function isLuaFile(filename)
  return filename:sub(- #fileExtension) == fileExtension
end

local function load_lua_dir(path)
  local scan = require('plenary.scandir')
  for _, file in ipairs(scan.scan_dir(path, { depth = 0 })) do
    if isLuaFile(file) then
      dofile(file)
    end
  end
end

return load_lua_dir
