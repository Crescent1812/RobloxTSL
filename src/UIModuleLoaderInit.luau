return function()
   for i,v: ModuleScript in pairs(script.Parent.UI) do
      require(v)
   end
end
