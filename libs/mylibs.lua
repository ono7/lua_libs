---------------------------------------------------------------------------------
--                              table operations                               --
---------------------------------------------------------------------------------

local function table_copy(t)
  -- copy a table (deep copy)
  local copy = {}
  for k, v in pairs(t) do
    if type(v) == "table" then
      v = table_copy(v)
    end
    copy[k] = v
  end
  return copy
end

---------------------------------------------------------------------------------
--                            iterate over strings                             --
---------------------------------------------------------------------------------

--- iterate over strings using string.byte

print(string.rep("-", 20))

local start = os.clock()

local str = " a"
str_t = {string.byte(str, 1, #str)}
counter = 0

for i = 1, #str_t do
  if str_t[i] == string.byte(" ") or string.byte("a") then
    print(str_t[i])
    counter = counter + 1
  end
end
print(string.format("found %s", counter))

local elapsed = os.clock() - start

print(string.format("V1: elapsed time: %.3f", elapsed))

-- iterate over strings using string.sub

for c in str:gmatch "." do
  -- do something with c
  print(c)
end

---------------------------------------------------------------------------------
--                             tostring metamethod                             --
---------------------------------------------------------------------------------

-- prints table to stdout, affects tostring and print functions
function mt.__tostring(tbl)
  -- mt = metatable
  local result = "{"

  for i = 1, #tbl do
    if i > 1 then
      result = result .. ", "
    end
    result = result .. tostring(tbl[i])
  end

  result = result .. "}"
  return result
end

---------------------------------------------------------------------------------
--                                  __concat                                   --
---------------------------------------------------------------------------------

-- mt.__contact

mt.__concat = mt.__add

print(t1 .. t2)

-- mt.__newindex

function mt.___newindex(tbl, key, value)
  if key == "banana" then
    error("Cannot set a protected key")
  else
    rawset(tbl, key, value)
  end
end

---------------------------------------------------------------------------------
--                                     hex                                     --
---------------------------------------------------------------------------------

local string = require "string"

function string.fromhex(str)
  return (str:gsub(
    "..",
    function(cc)
      return string.char(tonumber(cc, 16))
    end
  ))
end

function string.tohex(str)
  return (str:gsub(
    ".",
    function(c)
      return string.format("\\x%02X", string.byte(c))
    end
  ))
end

--[[

> string.tohex('AAAA')
\x41\x41\x41\x41

--]]
local string = require "string"

function string.tohex(str)
  return (str:gsub(
    ".",
    function(c)
      return string.format("%02X", string.byte(c))
    end
  ))
end

function string.hexifly(str)
  return (str:gsub(
    "..",
    function(cc)
      return string.format("\\x%s", cc)
    end
  ))
end

function string.fromhex(str)
  return (str:gsub(
    "..",
    function(cc)
      return string.char(tonumber(cc, 16))
    end
  ))
end

--[[

  local p = "AAAA"
  local hex_p = string.tohex(p)

  print(p:tohex())
  print(p:tohex():hexifly())
  print(hex_p:fromhex())
  > lua test2.lua
  > 41414141
  > \x41\x41\x41\x41
  > AAAA

--]]
