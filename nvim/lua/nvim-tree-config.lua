require("nvim-tree").setup({
  disable_netrw = false,
  hijack_netrw = true,
  --	open_on_setup = false,
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = false,
  filters = {
    git_ignored = false
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  --renderer = {
  --add_trailing = true,
  --group_empty = true,
  --highlight_git = true,
  --highlight_opened_files = "none",
  --root_folder_modifier = ":~",
  --indent_markers = {
  --enable = true,
  --icons = {
  --corner = "└ ",
  --edge = "│ ",
  --none = "  ",
  --},
  --},
  --icons = {
  --webdev_colors = true,
  --git_placement = "before",
  --padding = " ",
  --symlink_arrow = " ➛ ",
  --show = {
  --file = true,
  --folder = true,
  --folder_arrow = true,
  --git = true,
  --},
  --glyphs = {
  --default = "",
  --symlink = "",
  --folder = {
  --arrow_closed = "",
  --arrow_open = "",
  --default = "",
  --open = "",
  --empty = "",
  --empty_open = "",
  --symlink = "",
  --symlink_open = "",
  --},
  --git = {
  --unstaged = "✗",
  --staged = "✓",
  --unmerged = "",
  --renamed = "➜",
  --untracked = "★",
  --deleted = "",
  --ignored = "◌",
  --},
  --},
  --},
  --},
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  view = {
    width = 40,
    -- height = 30,
    side = "right",
    mappings = {
      custom_only = false,
      list = {},
    },
  },
})
