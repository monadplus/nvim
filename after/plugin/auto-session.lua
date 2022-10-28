local ok, auto_session = pcall(require, "auto-session")
if not ok then
  return
end

auto_session.setup {
  log_level = "error",
  auto_session_suppress_dirs = { "~", "~/Downloads", "/" },
}
