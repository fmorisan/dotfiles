return {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function (_, opts)
        require("neorg").setup(opts)
    end,
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.qol.todo_items"] = {},
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/notes",
                    },
                },
            },
        },
    },
}
