local helpers = require('helpers')
local get_visual = helpers.get_visual

-- Math context detection 
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

-- Return snippet tables
return
{
  -- Probability space
  s({trig = "psp", snippetType="autosnippet"},
    {
      t("\\left(\\Omega, \\mathcal{F}, \\mathbb{P}\\right)"),
    },
    {condition = tex.in_mathzone}
  ),

  -- Random variable
  s({trig = "rv"},
    {
      t("random variable "),
    }),

  -- Probability
  s({trig = "prb"},
    {
      t("probability "),
    }),

  -- Function
  s({trig = "fn"},
    {
      t("function "),
    }),
}

