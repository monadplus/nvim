local ok, orgmode = pcall(require, "orgmode")
if not ok then
  return
end

-- Set up custom org filetype treesitter.
orgmode.setup_ts_grammar()

orgmode.setup({
  org_agenda_files = {'~/Dropbox/org/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})

local ok2, org_bullets = pcall(require, "org-bullets")
if not ok2 then
  return
end
org_bullets.setup()

local ok3, headlines = pcall(require, "headlines")
if not ok3 then
  return
end
headlines.setup()
