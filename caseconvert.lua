-- Textconvert
-- Capitalized case adapted from http://stackoverflow.com/questions/20284515/capitalize-first-letter-of-every-word-in-lua
-- Slug code adapted from https://dracoblue.net/dev/convert-titlestring-to-url-slug-in-php-or-lua/
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "T", function()
    local current = hs.application.frontmostApplication()

    local chooser = hs.chooser.new(function(chosen)
        current:activate()
        hs.pasteboard.setContents(chosen.text)
    end)

    chooser:queryChangedCallback(function(string)
        local choices = {
            {
                ["text"] = string:lower(string),
                ["subText"] = "All lower case"
            },
            {
                ["text"] = string:upper(string),
                ["subText"] = "All upper case"
            },
            {
                ["text"] = string.gsub(" "..string, "%W%l", string.upper):sub(2),
                ["subText"] = "Capitalized case"
            },
            {
                ["text"] = string.gsub(string.gsub(string:lower(string),"[^ A-Za-z0-9]",""),"[ ]+","-"),
                ["subText"] = "Post slug"
            }
        }
        chooser:choices(choices)
    end)

    chooser:searchSubText(false)

    chooser:show()

end)
