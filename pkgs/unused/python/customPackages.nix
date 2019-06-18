{ pkgs, fetchFromGitHub, fetchurl, ... }:
with pkgs.python3.pkgs;

{
  SpeechRecognition = buildPythonPackage rec {
    pname = "SpeechRecognition";
    version = "3.8.1";
    name = "${pname}-${version}";

    src = fetchFromGitHub {
      owner = "Uberi";
      repo = "speech_recognition";
      rev = "${version}";
      sha256 = "1lq6g4kl3y1b4ch3b6wik7xy743x6pp5iald0jb9zxqgyxy1zsz4";
    };
    
    propagatedBuildInputs = with pkgs; [ customPythonPackages.pyaudio flac ];
    doCheck = false;
  };

  pocketsphinx = buildPythonPackage rec {
    pname = "pocketsphinx";
    version = "0.1.3";
    name = "${pname}-${version}";

    src = fetchPypi {
      inherit pname version;
      sha256 = "0v9l43s6s256qy4bs31akvmqkkrxdkk8mld40s3vfnn8xynml4mc";
    };

    postPatch = ''
    substitute ./setup.py ./setup.py \
      --replace "open('README.rst').read()" "'nichts'"
    '';
    propagatedBuildInputs = with pkgs; [ gcc swig pulseaudioLight ];

    doCheck = false;
  };

  pyaudio = pyaudio.overrideAttrs (oldAttrs: rec {
    version = "0.2.11";
    src = fetchPypi {
      inherit version;
      pname = "PyAudio";
      sha256 = "0x7vdsigm7xgvyg3shd3lj113m8zqj2pxmrgdyj66kmnw0qdxgwk";
    };
  });
}
