local helpers = require('helpers')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- Directory generation given a path
    s({trig="pilres", snippetType="autosnippet"},
      fmta(
        [[
        <>.resize(size=(<>, <>), resample=Image.Resampling.LANCZOS)
      ]],
        {
          d(1, get_visual),
          i(2, 'width'),
          i(3, 'height'),
        }
      ),
      {condition = line_begin}
    ),

  }

