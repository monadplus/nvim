local ok, comment = pcall(require, "Comment")
if not ok then
  return
end

-- :help comment-nvim
comment.setup()
