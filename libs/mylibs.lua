local function table_copy(t)
  -- copy a table (deep copy)
  local copy = {}
  for k,v in pairs(t) do
    if type(v) == 'table' then
      v = table_copy(v)
    end
    copy[k] = v
  end
  return copy
end
