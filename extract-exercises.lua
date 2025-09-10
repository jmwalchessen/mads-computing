-- Only include exercise divs, solutions, and their contents. Based on example in
-- Pandoc manual
-- https://pandoc.org/lua-filters.html#creating-a-handout-from-a-paper

local exerciseClasses = {'solution', 'exercise'}
local logging = require 'logging'

-- https://github.com/quarto-dev/quarto-cli/blob/9bbeec830d5de0694f5acb01911b4e0497329f67/src/resources/filters/common/refs.lua#L42
function refType(id)
  local match = string.match(id, "^(%a+)%-")
  if match then
    return pandoc.text.lower(match)
  else
    return nil
  end
end

function Pandoc(doc)
   local hblocks = {}
   for i, el in pairs(doc.blocks) do
      if ((el.t == "Div" and
           (el.classes:includes("solution") or
            refType(el.attr.identifier) == "exr"))
         or (el.t == "Header")) then
         table.insert(hblocks, el)
      end
   end
   return pandoc.Pandoc(hblocks, doc.meta)
end
