local M = {}

local to_snake = function(word, current_format)
    if current_format == 'snake' then
        return word
    end
end

local to_camel = function(word, current_format)
    if current_format == 'camel' then
        return word
    end
end

local to_kebab = function(word, current_format)
    if current_format == 'kebab' then
        return word
    end
end

local get_current_format = function(word)
    if (string.find(word, '-', 1, true)) then
        return 'kebab'
    end
    if (string.find(word, '_')) then
        return 'snake'
    end
    return 'camel'
end

M.convert = function(choice, word)
    local current_format = get_current_format(word)
    local case = {
        snake = to_snake,
        camel = to_camel,
        kebab = to_kebab,
        default = print, -- probably need to handle this better
    }

    if (case[choice]) then
        case[choice](word, current_format)
    else
        case['default']('Your choice was invalid.')
    end
end

return M
