{
  addressable = {
    dependencies = ["public_suffix"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0viqszpkggqi8hq87pqp0xykhvz60g99nwmkwsb0v45kc2liwxvk";
      type = "gem";
    };
    version = "2.5.2";
  };
  archive-tar-minitar = {
    dependencies = ["minitar" "minitar-cli"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0qwmzp55444b4fvn4d15kb3jb9m40z3czrfa4qpx2kqpyykqafah";
      type = "gem";
    };
    version = "0.6.1";
  };
  bcrypt = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1d254sdhdj6mzak3fb5x3jam8b94pvl1srladvs53j05a89j5z50";
      type = "gem";
    };
    version = "3.1.11";
  };
  bcrypt-ruby = {
    dependencies = ["bcrypt"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1j0rpi6g5jikfaigzi7xcfcplzidl26k7aa2d5ylvy9dycancw0j";
      type = "gem";
    };
    version = "3.1.5";
  };
  datamapper = {
    dependencies = ["dm-aggregates" "dm-constraints" "dm-core" "dm-migrations" "dm-serializer" "dm-timestamps" "dm-transactions" "dm-types" "dm-validations"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1fvci6rixk9x1zvfr27q7nip33ldfkmvz4848xq65ywzkpmf0w5z";
      type = "gem";
    };
    version = "1.2.0";
  };
  dm-aggregates = {
    dependencies = ["dm-core"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0s61gxr42pcsjjnfc8mkv132xr5ha2n6y3gj7zmz496r5aj3kk08";
      type = "gem";
    };
    version = "1.2.0";
  };
  dm-constraints = {
    dependencies = ["dm-core"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0a1hkms0b8rg7a946y0fbks16ki7d25v9801n4jjpw2mf2aghmgp";
      type = "gem";
    };
    version = "1.2.0";
  };
  dm-core = {
    dependencies = ["addressable"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "09x67ka6f1lxh4iwrg87iama0haq0d0z35gavvnvzpx9kn9pfbnw";
      type = "gem";
    };
    version = "1.2.1";
  };
  dm-migrations = {
    dependencies = ["dm-core"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "04hr8qgm4j1z5fg0cfpr8r6apvk5xykad0d0xqfg48rjv5rdwc0i";
      type = "gem";
    };
    version = "1.2.0";
  };
  dm-serializer = {
    dependencies = ["dm-core" "fastercsv" "json" "json_pure" "multi_json"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0mvpb2d4cniysw45d3c9xidjpdb3wmfl7x5lgvnsfm69wq24v5y4";
      type = "gem";
    };
    version = "1.2.2";
  };
  dm-timestamps = {
    dependencies = ["dm-core"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0sxha2fr3fx1zqf5f3c17yqs5k1m48j9gb6adaizamfazh0mkq3v";
      type = "gem";
    };
    version = "1.2.0";
  };
  dm-transactions = {
    dependencies = ["dm-core"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1g9p65xgcx2kyhabzfh3dd3z7l5bdx408x10xz6ncanwh2gynqwy";
      type = "gem";
    };
    version = "1.2.0";
  };
  dm-types = {
    dependencies = ["bcrypt-ruby" "dm-core" "fastercsv" "json" "multi_json" "stringex" "uuidtools"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "12kc125gmy1v8h4fif5z70arw6dlh8msa6fn8wvlafwmqjh407jk";
      type = "gem";
    };
    version = "1.2.2";
  };
  dm-validations = {
    dependencies = ["dm-core"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0ald0nbwyw0yghpccqgvfrqiz57d3bpsfqrp8hs4r765vn52jq2z";
      type = "gem";
    };
    version = "1.2.0";
  };
  fastercsv = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1df3vfgw5wg0s405z0pj0rfcvnl9q6wak7ka8gn0xqg4cag1k66h";
      type = "gem";
    };
    version = "1.5.5";
  };
  hashie = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1hh5lybf8hm7d7xs4xm8hxvm8xqrs2flc8fnwkrclaj746izw6xb";
      type = "gem";
    };
    version = "3.5.7";
  };
  json = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0qmj7fypgb9vag723w1a49qihxrcf5shzars106ynw2zk352gbv5";
      type = "gem";
    };
    version = "1.8.6";
  };
  json_pure = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1vllrpm2hpsy5w1r7000mna2mhd7yfrmd8hi713lk0n9mv27bmam";
      type = "gem";
    };
    version = "1.8.6";
  };
  minitar = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1pcx0rpi39xmbg15qpx5xqgvn9pp91vma4rmrw013k6dbvfxqp6z";
      type = "gem";
    };
    version = "0.6.1";
  };
  minitar-cli = {
    dependencies = ["minitar" "powerbar"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0df7d43kcqyq2k9kdqsdrjrkz40021k7j527p3sbf7znr0450a4a";
      type = "gem";
    };
    version = "0.6.1";
  };
  multi_json = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1rl0qy4inf1mp8mybfk56dfga0mvx97zwpmq5xmiwl5r770171nv";
      type = "gem";
    };
    version = "1.13.1";
  };
  mustermann = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "07sb7fckrraqh48fjnqf6yl7vxxabfx0qrsrhfdz67pd838g4k8g";
      type = "gem";
    };
    version = "1.0.2";
  };
  powerbar = {
    dependencies = ["hashie"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "07qgc26ycikpg6q6ppfv8q1xk732v0hw37d11whvakwwcpmm8kp6";
      type = "gem";
    };
    version = "1.0.18";
  };
  public_suffix = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1x5h1dh1i3gwc01jbg01rly2g6a1qwhynb1s8a30ic507z1nh09s";
      type = "gem";
    };
    version = "3.0.2";
  };
  rack = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1mfriw2r2913dv8qf3p87n7yal3qfsrs478x2qz106v8vhmxa017";
      type = "gem";
    };
    version = "2.0.4";
  };
  rack-protection = {
    dependencies = ["rack"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0ywmgh7x8ljf7jfnq5hmfzki3f803waji3fcvi107w7mlyflbng7";
      type = "gem";
    };
    version = "2.0.1";
  };
  rake = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "190p7cs8zdn07mjj6xwwsdna3g0r98zs4crz7jh2j2q5b0nbxgjf";
      type = "gem";
    };
    version = "12.3.0";
  };
  sinatra = {
    dependencies = ["mustermann" "rack" "rack-protection" "tilt"];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "03ns7d8gcilsdmvlijyaqb3rb7sjj6hcqn9sx1cc3ynwv2cs59wv";
      type = "gem";
    };
    version = "2.0.1";
  };
  stringex = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "18kydzgw49df9i6k887764zp8mjqm0m4hmf2zgvazm9mdbqbfb0c";
      type = "gem";
    };
    version = "1.5.1";
  };
  tilt = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0020mrgdf11q23hm1ddd6fv691l51vi10af00f137ilcdb2ycfra";
      type = "gem";
    };
    version = "2.0.8";
  };
  uuidtools = {
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0zjvq1jrrnzj69ylmz1xcr30skf9ymmvjmdwbvscncd7zkr8av5g";
      type = "gem";
    };
    version = "2.1.5";
  };
}