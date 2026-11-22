local M = {}

local function say(msg)
  if #vim.api.nvim_list_uis() == 0 then
    io.stdout:write(msg .. "\n")
  else
    vim.schedule(function()
      vim.notify(msg, vim.log.levels.INFO, { title = "Mason" })
    end)
  end
end

-- installed packages whose version differs from the registry's latest
function M.outdated()
  local list = {}
  for _, pkg in ipairs(require("mason-registry").get_installed_packages()) do
    local installed, latest = pkg:get_installed_version(), pkg:get_latest_version()
    if installed and installed ~= latest then
      table.insert(list, { pkg = pkg, from = installed, to = latest })
    end
  end
  return list
end

function M.run(opts)
  opts = opts or {}
  local done = false

  require("mason-registry").update(function(ok)
    if not ok then
      say("mason: registry update failed")
      done = true
      return
    end

    local todo = M.outdated()
    if #todo == 0 then
      say("mason: everything up to date")
      done = true
      return
    end

    local pending = #todo
    for _, item in ipairs(todo) do
      say(("mason: %s %s -> %s"):format(item.pkg.name, item.from, item.to))
      item.pkg:install({ version = item.to }, function(success, err)
        if not success then
          say(("mason: %s failed: %s"):format(item.pkg.name, tostring(err)))
        end
        pending = pending - 1
        done = pending == 0
      end)
    end
  end)

  if opts.wait then
    vim.wait(10 * 60 * 1000, function()
      return done
    end, 200)
  end
end

return M
