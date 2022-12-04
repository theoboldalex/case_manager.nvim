local manager = require('case_manager')

local prompt = vim.ui.input({prompt = 'Enter new case ([s]nake, [c]amel, [p]ascal, [k]ebab): '}, function(input)
    print(input)
end)

-- vim command to run the case manager command and call prompt, which then calls methods on manager
