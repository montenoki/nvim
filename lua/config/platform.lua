local M = {}

-- Nix-managed environments set this explicitly. Do not infer it from the OS:
-- native Windows and non-Nix Linux/macOS still use Mason as the tool provider.
M.nix_managed_tools = vim.env.NVIM_NIX_MANAGED_TOOLS == "1"

return M
