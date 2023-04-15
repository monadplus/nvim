local ok, marks = pcall(require, "marks")
if not ok then
  return
end

marks.setup {
  default_mappings = true,
  builtin_marks = {}, -- { ".", "<", ">", "^" },
  cyclic = true,
  refresh_interval = 250,
  sign_priority = { lower = 2, upper = 3, builtin = 1, bookmark = 4 },
  excluded_filetypes = {},
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    annotate = false,
  },
  mappings = {}
}
