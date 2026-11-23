-- Helpers for the LuaSnip snippet files in nvim/snppts/<filetype>.lua.
local M = {}

local ls = require("luasnip")
local s, t, f = ls.snippet, ls.text_node, ls.function_node

-- text on the line before the trigger
local function prefix(line_to_cursor, trigger)
  return line_to_cursor:sub(1, #line_to_cursor - #trigger)
end

-- UltiSnips default: the trigger is a whole whitespace-separated word
function M.whole_word(line_to_cursor, trigger)
  local before = prefix(line_to_cursor, trigger)
  return before == "" or before:match("%s$") ~= nil
end

-- UltiSnips `w`: the character before the trigger isn't part of a word ('iskeyword')
function M.word_boundary(line_to_cursor, trigger)
  local last = vim.fn.matchstr(prefix(line_to_cursor, trigger), [[.$]])
  return last == "" or vim.fn.match(last, [[\k]]) == -1
end

-- expanded with <Tab> (UltiSnips: no options)
function M.tab(trig, nodes, dscr)
  return s({ trig = trig, dscr = dscr, wordTrig = false, condition = M.whole_word }, nodes)
end

-- expands as you type, at a word boundary (UltiSnips: wA)
function M.auto_word(trig, dscr, nodes)
  return s({
    trig = trig,
    dscr = dscr,
    wordTrig = false,
    condition = M.word_boundary,
    snippetType = "autosnippet",
  }, nodes)
end

-- expands as you type, anywhere, also inside a word (UltiSnips: iA)
function M.auto_anywhere(trig, dscr, nodes)
  return s({ trig = trig, dscr = dscr, wordTrig = false, snippetType = "autosnippet" }, nodes)
end

-- today's date, computed when the snippet expands
function M.today()
  return f(function()
    return vim.fn.strftime("%Y-%m-%d")
  end)
end

-- Italian accents: letter + '' (or e"" for é); shared by ledger, markdown, text
function M.accents()
  return {
    M.auto_anywhere("e''", "accented e", t("è")),
    M.auto_anywhere('e""', "other accented e", t("é")),
    M.auto_anywhere("a''", "accented a", t("à")),
    M.auto_anywhere("i''", "accented i", t("ì")),
    M.auto_anywhere("o''", "accented o", t("ò")),
    M.auto_anywhere("u''", "accented u", t("ù")),
  }
end

return M
