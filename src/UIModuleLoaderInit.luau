return function()
   for i,v in pairs(script.Parent.UI) do
      require(v)
   end
end
