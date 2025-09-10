-- Filter out divs with .solution class in HTML (save for PDF); filter out
-- .hidden in PDF (save for HTML), because that is usually MathJaX preamble code
-- https://github.com/hits-mbm-dev/paper-talin-loop/blob/1d85e2b9d3c7b76b38ed185182abfa45b18eedaa/www/conditional-content.lua

local function matchAny(str, patternList)
    for _, pattern in ipairs(patternList) do
        local w = str:match(pattern)
        if w then return w end
    end
end

local printFormats = {'latex', 'docx', 'pdf', 'opendocument', 'odt', 'beamer', 'epub'}

return {
   {
      Div = function(div)
         if (div.classes:includes("solution") or
             (div.classes:includes("hidden") and matchAny(FORMAT, printFormats))) then
            return {}
         else
            return div
         end
      end
   },
}
