{ package, overrides ? {} }: (import <nixpkgs> {}).callPackage package overrides
