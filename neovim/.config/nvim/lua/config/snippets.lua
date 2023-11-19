local luasnip_loaded, luasnip = pcall(require, "luasnip")
if not luasnip_loaded then return end

local s = luasnip.snippet
local partial = require("luasnip/extras").partial
local rep = require("luasnip/extras").rep
local fmt = require("luasnip/extras/fmt").fmt
local fmta = require("luasnip/extras/fmt").fmta

luasnip.add_snippets("all", {
  s(
    {
      trig = "ffam",
      dscr = "Link Jira Ticket using Slug",
    },
    fmt("[FFAM-{}](https://billsdev.atlassian.net/browse/FFAM-{})", {
      luasnip.i(1),
      rep(1),
    })
  ),
  s(
    {
      trig = "time",
      dscr = "Insert the current time",
    },
    partial(os.date, "%r")
  ),
  s(
    {
      trig = "date",
      dscr = "Insert the current date",
    },
    partial(os.date, "%Y-%m-%d")
  ),
})

luasnip.add_snippets("markdown", {
  s(
    {
      trig = "dd",
      name = "diary link",
      dscr = "Create diary link [txt](date).",
    },
    fmt("* [{}]({}){}", {
      luasnip.i(1),
      luasnip.f(function(_, snip)
        return os.date("%Y-%m-%d")
      end, {}),
      luasnip.i(0),
    })
  ),
})

luasnip.add_snippets("javascript", {
  s(
    {
      trig = "cl",
      name = "console log",
      dscr = "Add console.log() statement",
    },
    fmt("console.log({});", {
      luasnip.i(1),
    })
  ),
  s(
    {
      trig = "cld",
      name = "console log for debug",
      dscr = "Add console.log(\"[DEBUG]: \") statement",
    },
    fmt("console.log(\"[DEBUG]:\", {});", {
      luasnip.i(1),
    })
  ),
})
-- extend to other filetypes
luasnip.filetype_extend("javascriptreact", { "javascript" })
luasnip.filetype_extend("typescript", { "javascript" })
luasnip.filetype_extend("typescriptreact", { "javascript" })
