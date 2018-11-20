let 
  pathFromJson = json:
    with (import ./nixpkgs {}).nix-update-source;
    (fetch json).src;

  # pair = json:
  #   let 
  #     path = pathFromJson json;
  #   in
  #   {
  #     inherit path;
  #     src = import path {};
  #   };

  derivWithPath = json: options:
    let 
      path = pathFromJson json;
    in
    (import path options) // { inherit path; };

  makeNixpkgs = derivWithPath;
  
in
rec {
  nixpkgs = {
    nixos-unstable = pathFromJson ./out/nixos-unstable.json; 
    nixos-18_09 = pathFromJson ./out/nixos-18.09.json;
    unstable-aarch64 = pathFromJson ./out/unstable-aarch64.json;
    master = pathFromJson ./out/nixpkgs-master.json;
    
    system = nixpkgs.nixos-unstable;
  };
  libs = {
    nixpkgs-mozilla = pathFromJson ./out/nixos-mozilla.json;
    home-manager = pathFromJson ./out/home-manager.json;
    clever = pathFromJson ./out/clever.json;
  };
}
