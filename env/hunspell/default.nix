{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
hunspellWithDicts 
  (lib.mapAttrsToList 
    (n: v: if (lib.isDerivation v) then v else null)
    hunspellDicts)

# hunspellWithDicts (with hunspellDicts; [
#   de-at         
#   de-ch         
#   de-de         
#   en-ca         
#   en-gb-ise     
#   en-gb-ize     
#   en-us         
#   es-any        
#   es-ar         
#   es-bo         
#   es-cl         
#   es-co         
#   es-cr         
#   es-cu         
#   es-do         
#   es-ec         
#   es-es         
#   es-gt         
#   es-hn         
#   es-mx         
#   es-ni         
#   es-pa         
#   es-pe         
#   es-pr         
#   es-py         
#   es-sv         
#   es-uy         
#   es-ve         
#   eu-es         
#   fr-any        
#   fr-classique  
#   fr-moderne    
#   fr-reforme1990
#   it-it         
#   sv-fi         
#   sv-se         
# ])
