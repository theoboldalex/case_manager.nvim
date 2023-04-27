local M = {}

local to_snake = function(word, current_format)
    -- let's find a better pattern to convert them than this :D
    if current_format == 'snake' then
        return word
    end
    if current_format == 'camel' then
        local formatted_word = string.gsub(word, '(%u)', '_%1')
        vim.cmd('normal! ciw' .. string.lower(formatted_word))
    end
    if current_format == 'kebab' then
        local formatted_word = string.gsub(word, '%-', '_')
        vim.cmd('normal! ciw' .. string.lower(formatted_word))
    end
end

local to_camel = function(word, current_format)
    if current_format == 'camel' then
        return word
    end
    if current_format == 'kebab' then
        local formatted_word = string.gsub(word, '%-[a-z]', function(char)
            return string.upper(char)
        end)
        formatted_word = string.gsub(formatted_word, '%-', '')
        vim.cmd('normal! ciw' .. formatted_word)
    end
    if current_format == 'snake' then
        local formatted_word = string.gsub(word, '_[a-z]', function(char)
            return string.upper(char)
        end)
        formatted_word = string.gsub(formatted_word, '_', '')
        vim.cmd('normal! ciw' .. formatted_word)
    end
end

local to_kebab = function(word, current_format)
    if current_format == 'kebab' then
        return word
    end
    if current_format == 'camel' then
        local formatted_word = string.gsub(word, '(%u)', '-%1')
        vim.cmd('normal! ciw' .. string.lower(formatted_word))
    end
    if current_format == 'snake' then
        local formatted_word = string.gsub(word, '_', '-')
        vim.cmd('normal! ciw' .. formatted_word)
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
        s = to_snake,
        c = to_camel,
        k = to_kebab,
        default = print, -- probably need to handle this better
    }

    if (case[choice]) then
        case[choice](word, current_format)
    else
        case['default']('Your choice was invalid.')
    end
end

return M
