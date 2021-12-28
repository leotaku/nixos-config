{ config, pkgs, lib, ... }:

let
  XDG_CONFIG_HOME = "$HOME/.config";
  XDG_CACHE_HOME = "$HOME/.cache";
  XDG_DATA_HOME = "$HOME/.local/share";
  XDG_RUNTIME_DIR = "/run/user/$UID";
in {
  # Fix apps that do not properly respect XDG conventions
  # https://wiki.archlinux.org/index.php/XDG_Base_Directory

  environment.variables = rec {
    # Adapt XDG defaults
    inherit XDG_RUNTIME_DIR XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME;
    TMPDIR = XDG_RUNTIME_DIR;

    CABAL_CONFIG = XDG_CONFIG_HOME + "/cabal/config";
    CABAL_DIR = XDG_CACHE_HOME + "/cabal";
    CARGO_HOME = XDG_DATA_HOME + "/cargo";
    CONAN_USER_HOME = XDG_DATA_HOME + "/conan";
    GOPATH = XDG_DATA_HOME + "/go";
    HISTFILE = XDG_DATA_HOME + "/bash_history";
    LESSHISTFILE = XDG_CACHE_HOME + "/lesshist";
    MPLAYER_HOME = XDG_CONFIG_HOME + "/mplayer";
    NOTMUCH_CONFIG = XDG_CONFIG_HOME + "/notmuch/notmuchrc";
    PARALLEL_HOME = XDG_CONFIG_HOME + "/parallel";
    RLWRAP_HOME = XDG_DATA_HOME + "/rlwrap";
    RUSTUP_HOME = XDG_DATA_HOME + "/rustup";
    R_LIBS_USER = XDG_DATA_HOME + "/R";
    STACK_ROOT = XDG_DATA_HOME + "/stack";
    TEXMFCACHE = XDG_CACHE_HOME + "/texmf-var";
    WEECHAT_HOME = XDG_CONFIG_HOME + "/weechat";
    XCOMPOSECACHE = XDG_CACHE_HOME + "/xcompose";
    XCOMPOSEFILE = XDG_CONFIG_HOME + "/xcompose";
  };
}
