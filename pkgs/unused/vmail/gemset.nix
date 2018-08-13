{
  blockenspiel = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1h701s45n5qprvcpc7fnr45n88p56x07pznkxqnhz1dbdbhb7xx8";
      type = "gem";
    };
    version = "0.5.0";
  };
  highline = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01ib7jp85xjc4gh4jg0wyzllm46hwv8p0w1m4c75pbgi41fps50y";
      type = "gem";
    };
    version = "1.7.10";
  };
  mail = {
    dependencies = ["mini_mime"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10dyifazss9mgdzdv08p47p344wmphp5pkh5i73s7c04ra8y6ahz";
      type = "gem";
    };
    version = "2.7.0";
  };
  mini_mime = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lwhlvjqaqfm6k3ms4v29sby9y7m518ylsqz2j74i740715yl5c8";
      type = "gem";
    };
    version = "1.0.0";
  };
  sequel = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0q33k2q02njfi74xx3glal8jlhrs1f7d3zsm1xhnls6whl5yzyay";
      type = "gem";
    };
    version = "3.48.0";
  };
  sqlite3 = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01ifzp8nwzqppda419c9wcvr8n82ysmisrs0hph9pdmv1lpa4f5i";
      type = "gem";
    };
    version = "1.3.13";
  };
  versionomy = {
    dependencies = ["blockenspiel"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0i0l4pzrl1vyp4lpg2cxhgkk56spki3lld943d6h7168fj8qyv33";
      type = "gem";
    };
    version = "0.5.0";
  };
  vmail = {
    dependencies = ["highline" "mail" "sequel" "sqlite3" "versionomy"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ysmmg9j3xx192f6qmr8hw0l09indfn5jp9w4sdajf8lm2jkn0jm";
      type = "gem";
    };
    version = "2.9.9";
  };
}