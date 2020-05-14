{ config, pkgs, lib, ... }:

let
  XDG_CONFIG_HOME = "$HOME/.config";
  XDG_CACHE_HOME = "$HOME/.cache";
  XDG_DATA_HOME = "$HOME/.local/share";
  # NOTE: Protect usually volatile runtime dir
  XDG_RUNTIME_DIR = "/tmp/user/$UID";
in {
  # Fix apps that do not properly respect XDG conventions
  # https://wiki.archlinux.org/index.php/XDG_Base_Directory

  environment.variables = rec {
    # Adapt XDG defaults
    inherit XDG_RUNTIME_DIR XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME;
    TMPDIR = XDG_RUNTIME_DIR;

    CARGO_HOME = XDG_DATA_HOME + "/cargo";
    HISTFILE = XDG_DATA_HOME + "/bash_history";
    LESSHISTFILE = XDG_CACHE_HOME + "/lesshist";
    MPLAYER_HOME = XDG_CONFIG_HOME + "/mplayer";
    NOTMUCH_CONFIG = XDG_CONFIG_HOME + "/notmuch/notmuchrc";
    PARALLEL_HOME = XDG_CONFIG_HOME + "/parallel";
    RUSTUP_HOME = XDG_DATA_HOME + "/rustup";
    TEXMFCACHE = XDG_CACHE_HOME + "/texmf-var";
    WEECHAT_HOME = XDG_CONFIG_HOME + "/weechat";
    XAUTHORITY = "$HOME/.Xauthority";
    XCOMPOSECACHE = XDG_CACHE_HOME + "/xcompose";
    XCOMPOSEFILE = XDG_CONFIG_HOME + "/xcompose";
  };
}
