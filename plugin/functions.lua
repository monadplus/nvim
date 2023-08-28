-- Removes trailing whitespaces if the file is not a binary nor a diff.
function _G.trim_trailing_whitespaces()
  if not vim.o.binary and vim.o.filetype ~= 'diff' then
    local current_view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(current_view)
  end
end

function _G.file_exists(file)
  return vim.loop.fs_stat(file) ~= nil
end

-- Open using xdg-open (linux), wslview (WSL), or open (macOS).
--
-- Source: https://github.com/folke/lazy.nvim/blob/main/lua/lazy/util.lua#L13-L44
function _G.open(uri)
  if _G.file_exists(uri) then
    vim.notify(table.concat({ '_G.float() not implemented' }, "\n"), vim.log.levels.ERROR)
    -- return _G.float({ style = "", file = uri })
  end

  local cmd
  if vim.fn.executable("xdg-open") == 1 then
    cmd = { "xdg-open", uri }
  elseif vim.fn.executable("wslview") == 1 then
    cmd = { "wslview", uri }
  else
    cmd = { "open", uri }
  end

  local ret = vim.fn.jobstart(cmd, { detach = true })
  if ret <= 0 then
    local msg = {
      "Failed to open uri",
      ret,
      vim.inspect(cmd),
    }
    vim.notify(table.concat(msg, "\n"), vim.log.levels.ERROR)
  end
end

-- Inspect (arbitrary) lua values.
-- ```
-- :lua put(vim.loop)
-- ```
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end
