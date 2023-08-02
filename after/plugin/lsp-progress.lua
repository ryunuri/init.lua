require("lsp-progress").setup({
    format = function(messages)
        local sign = " LSP"

        if #messages > 0 then
            return sign .. " " .. table.concat(messages, " ")
        end

        local cur_filetype = vim.api.nvim_buf_get_option(0, "filetype")
        local active_clients = vim.lsp.get_active_clients()

        if #active_clients > 0 then
            local client_names = {}

            for _, client in ipairs(active_clients) do
                local filetypes = client.config.filetypes
                local client_name = client.name
                local has_filetype = vim.fn.index(filetypes, cur_filetype) ~= -1
                if filetypes and has_filetype and client_name ~= "" then
                    table.insert(client_names, "[" .. client_name .. "]")
                end
            end

            return sign .. " " .. table.concat(client_names, " ")
        end

        return ""
    end,
})
