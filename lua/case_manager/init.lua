local M = {}

local to_snake = function(word, current_format)
    -- let's find a better pattern to convert them than this :D
    if current_format == 'snake' then
        return word
    end
    if current_format == 'camel' then
        local formatted_word = string.gsub(word, '(%u)', '_%1' )
        vim.cmd('normal! ciw' .. string.lower(formatted_word))
    end
    if current_format == 'kebab' then
        local formatted_word = string.gsub(word, '%-', '_')
        vim.cmd('normal! ciW' .. string.lower(formatted_word))
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
        vim.cmd('normal! ciW' .. formatted_word)
    end
    if current_format == 'snake' then
        local formatted_word = string.gsub(word, '_[a-z]', function(char)
            return string.upper(char)
        end)
        formatted_word = string.gsub(formatted_word, '_', '')
        vim.cmd('normal! ciW' .. formatted_word)
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
        vim.cmd('normal! ciW' .. formatted_word)
    end
end
to_kebab('hello_world_hello_world', 'snake')

local get_current_format = function(word)
    if (string.find(word, '-', 1, true)) then
        return 'kebab'
    end
    if (string.find(word, '_')) then
        return 'snake'
    end
    return 'camel'
end

local expand_choice = function(choice)
    local opts = {
        s = 'snake',
        c = 'camel',
        k = 'kebab',
    }

    return opts[choice]
end

M.convert = function(choice, word)
    local current_format = get_current_format(word)
    local expanded_choice = expand_choice(choice)
    local case = {
        snake = to_snake,
        camel = to_camel,
        kebab = to_kebab,
        default = print, -- probably need to handle this better
    }

    if (case[expanded_choice]) then
        case[expanded_choice](word, current_format)
    else
        case['default']('Your choice was invalid.')
    end
end

return M
