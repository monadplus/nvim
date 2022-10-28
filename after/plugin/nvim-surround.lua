local ok, nvim_surround = pcall(require, "nvim-surround")
if not ok then
  return
end

-- :h nvim-surround.configuration
nvim_surround.setup {}
