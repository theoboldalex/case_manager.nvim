local M = {}

M.to_snake = function(current_format)
end

M.to_camel = function(current_format)
end

M.to_pascal = function(current_format)
end

M.to_kebab = function(current_format)
end

M.get_current_format = function(word)
end

M.convert = function(choice, word)
    local current_format = M.get_current_format(word)
    local case = {
        snake = function()
            M.to_snake(current_format)
        end,
        camel = function()
            M.to_camel(current_format)
        end,
        pascal = function()
            M.to_pascal(current_format)
        end,
        kebab = function()
            M.to_kebab(current_format)
        end,
        default = function()
            print('Your choice was invlaid.') -- probably need to handle this better
        end,
    }

    if (case[choice]) then
        case[choice]()
    else
        case['default']()
    end
end

return M
