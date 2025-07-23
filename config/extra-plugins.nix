{ plugins, ... }:
{
  extraConfigLuaPost = ''
    require("telescope").load_extension "file_browser"
  '';

  extraPlugins = with plugins; [
    nvim-various-textobjs
    nvim-treesitter-textsubjects
    satellite-nvim
    vim-wordmotion
    vim-smartword
    telescope-file-browser-nvim
  ];
}
