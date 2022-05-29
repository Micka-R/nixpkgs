{ config, pkgs, lib, vimUtils, ... }:

let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  # always installs latest version
  plugin = pluginGit "HEAD";
  pathconfig = "/home/pkngr/.config/nixpkgs/";


in {
  nixpkgs.overlays = [
	  (import (builtins.fetchTarball {
	    url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
	  }))
	];
  programs.neovim = {

    enable = true;

    # read in the vim config from filesystem
    # this enables syntaxhighlighting when editing those
    extraConfig = builtins.concatStringsSep "\n" [
      #(lib.strings.fileContents ./base.vim)
      #(lib.strings.fileContents ./plugins.vim)
      #(lib.strings.fileContents ./lsp.vim)

      # this allows you to add lua config files
      ''
        lua dofile("${pathconfig}/programs/nvim/nvim/init.lua")
      ''
    ];

    # install needed binaries here
    extraPackages = with pkgs; [
      # used to compile tree-sitter grammar
      tree-sitter

      # installs different langauge servers for neovim-lsp
      # have a look on the link below to figure out the ones for your languages
      # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      nodePackages.typescript nodePackages.typescript-language-server
      gopls
      nodePackages.pyright
      rust-analyzer
    ];
    plugins = with pkgs.vimPlugins; [
      # you can use plugins from the pkgs

      # or you can use our function to directly fetch plugins from git

      (plugin "catppuccin/nvim")
      (plugin "dracula/vim")
      (pluginGit "main" "folke/tokyonight.nvim")

      (plugin "neovim/nvim-lspconfig")

      (plugin "hrsh7th/cmp-nvim-lsp")
      (plugin "hrsh7th/cmp-buffer")
      (plugin "hrsh7th/cmp-path")
      (plugin "hrsh7th/cmp-emoji")
      (plugin "hrsh7th/cmp-nvim-lua")
      (plugin "hrsh7th/cmp-path")
      (plugin "hrsh7th/cmp-cmdline")
      (plugin "hrsh7th/nvim-cmp")


      (plugin "nvim-lualine/lualine.nvim")


      (plugin "L3MON4D3/LuaSnip")
      (plugin "saadparwaiz1/cmp_luasnip")
      (plugin "rafamadriz/friendly-snippets")
      (plugin "tami5/lspsaga.nvim")
      (plugin "RishabhRD/popfix")
      (plugin "RishabhRD/nvim-lsputils")

      (plugin "folke/trouble.nvim")

      (plugin "nvim-treesitter/nvim-treesitter")
      (plugin "OmniSharp/omnisharp-roslyn")
      (plugin "OmniSharp/omnisharp-vim")

      (plugin "kyazdani42/nvim-web-devicons")
      (plugin "kyazdani42/nvim-tree.lua")

      (plugin "rcarriga/nvim-notify")
      (plugin "glepnir/dashboard-nvim")

      (plugin "tpope/vim-commentary")
      (plugin "nvim-lua/plenary.nvim")
      (plugin "nvim-telescope/telescope.nvim")

      (plugin "junegunn/fzf.vim")
      (plugin "folke/which-key.nvim")
      (plugin "jiangmiao/auto-pairs")
      (plugin "machakann/vim-sandwich")

      (plugin "jose-elias-alvarez/null-ls.nvim")
      (plugin "MunifTanjim/prettier.nvim")
      (plugin "vimwiki/vimwiki")
      (plugin "tpope/vim-fugitive")
      (plugin "fatih/vim-go")
      (plugin "chrisbra/Colorizer")
      (plugin "glepnir/dashboard-nvim")

      (plugin "puremourning/vimspector")

    ];
  };
}
