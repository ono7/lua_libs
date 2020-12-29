local function table_copy(t)
  -- copy a table (deep copy)
  local copy = {}
  for n,v in pairs(t) do
    if type(v) == 'table' then
      v = table_copy(v)
    end
    copy[n] = v
  end
  return copy
end
