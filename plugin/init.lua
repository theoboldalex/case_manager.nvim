Manager = require('case_manager')

Prompt = function(word)
    return vim.ui.input({prompt = 'Enter case ([s]nake, [c]amel, [k]ebab): '}, function(choice)
        Manager.convert(choice, word)
    end)
end

vim.cmd([[ command! CaseManager :lua Prompt(vim.call('expand', '<cword>')) ]])
