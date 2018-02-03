self: super:

{
  # Custom packages
  instant-markdown-d = ((import ./instant-markdown-d/default.nix) {}).package;
  bobthefish = super.callPackage ./bobfish/default.nix {};
}
