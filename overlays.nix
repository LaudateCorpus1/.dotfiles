let
  vimPluginsOverlay = self: super: {
    vimPlugins = super.vimPlugins // {
      # Only necessary while on 19.09. Remove once upgraded.
      psc-ide-vim = self.vimUtils.buildVimPluginFrom2Nix {
        pname = "psc-ide-vim";
        version = "2019-09-17";
        src = self.fetchFromGitHub {
          owner = "frigoeu";
          repo = "psc-ide-vim";
          rev = "5fb4e329e5c0c7d80f0356ab4028eee9c8bd3465";
          sha256 = "0gzbxsq6wh8d9z9vyrff4hdpc66yg9y8hnxq4kjrz9qrccc75c1f";
        };
      };
    };
  };

in

[ vimPluginsOverlay ]
