local ok, neorg = pcall(require, "neorg")
if not ok then
  return
end

neorg.setup {
  load = {
    -- https://github.com/nvim-neorg/neorg#core-modules
    ["core.defaults"] = {},
    -- ["core.gtd.base"] = {},
    -- ["core.norg.completion"] = {},
    -- ["core.norg.concealer"] = {},
    -- ["core.norg.dirman"] = {},
    -- ["core.norg.journal"] = {},
    -- ["core.norg.qol.toc"] = {},
    -- ["core.presenter"] = {},
  }
}
