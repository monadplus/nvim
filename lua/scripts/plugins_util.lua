local M = {}

-- plugin_name: name of the plugin (e.g. 'trouble.nvim')
-- f: function with no arguments
-- NOTE: a plugin may be enabled, but no yet loaded
function M.when_plugin_loaded(plugin_name, f)
  if packer_plugins and packer_plugins[plugin_name] and packer_plugins[plugin_name].loaded then
    f()
  end
end

return M
