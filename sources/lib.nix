let 
  flatMap = f: v:
    builtins.mapAttrs
      (n: v: 
        (if builtins.isAttrs v
         then flatMap f v
         else f v)) v;
  
  mapAttrsToLists = n: path': attrs:
  map (name: 
    (let 
      v = attrs.${name}; 
      path = path' ++ [name];
    in
      if builtins.isAttrs v
      then (if 0 != n 
            then mapAttrsToLists (n - 1) path v
            else v // { inherit path; })
      else v
    )
  ) (builtins.attrNames attrs);
  
  collectLists = list:
    builtins.foldl' (acc: v: 
    (if builtins.isList v
    then acc ++ collectLists v
    else acc ++ [v]
    )
    ) [] list;

  mapAttrsToList = n: attrs:
    collectLists (mapAttrsToLists n [] attrs);

in
{
  inherit flatMap collectLists mapAttrsToList mapAttrsToLists;
}
