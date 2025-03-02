{
  opts = {
    background = "dark";
    backup = false; # creates a backup file
    writebackup = false; # if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    clipboard = "unnamedplus"; # allows neovim to access the system clipboard
    cmdheight = 1; # more space in the neovim command line for displaying messages
    completeopt = [
      "menuone"
      "noselect"
      "noinsert"
    ];
    conceallevel = 0; # so that `` is visible in markdown files
    fileencoding = "utf-8"; # the encoding written to a file
    hidden = true; # required to keep multiple buffers and open multiple buffers

    hlsearch = true; # highlight all matches on previous search pattern
    incsearch = true;
    ignorecase = true; # ignore case in search patterns

    mousescroll = "ver:6,hor:10";
    showmode = false; # we don't need to see things like -- INSERT -- anymore
    smartcase = true; # smart case
    splitbelow = true; # force all horizontal splits to go below current window
    splitright = true; # force all vertical splits to go to the right of current window
    swapfile = false; # creates a swapfile
    termguicolors = true; # set term gui colors (most terminals support this)
    timeoutlen = 350; # time to wait for a mapped sequence to complete (in milliseconds)
    title = true; # set the title of window to the value of the titlestring
    titlestring = "%<%F%=%l/%L - xetavim"; # what the title of the window will be set to
    undofile = true; # enable persistent undo
    updatetime = 50; # faster completion
    expandtab = true; # convert tabs to spaces
    autoindent = true;
    smartindent = true;
    shiftwidth = 2; # the number of spaces inserted for each indentation
    softtabstop = 2;
    tabstop = 2; # insert 2 spaces for a tab
    cursorline = true; # highlight the current line
    relativenumber = true; # make line numbering relative to cursor position
    numberwidth = 2; # set number column width to 2 {default 4}
    signcolumn = "yes"; # always show the sign column, otherwise it would shift the text each time
    wrap = false; # display lines as one long line
    scrolloff = 8; # minimal number of screen lines to keep above and below the cursor.
    sidescrolloff = 8; # minimal number of screen lines to keep left and right of the cursor.
    showcmd = false;
    ruler = false;
    laststatus = 3;
    autowrite = true;
    wildmode = "longest:full,full";
    virtualedit = "block"; # allow cursor to move where there is no text in visual block mode:wildmode
    smoothscroll = true;
    foldmethod = "expr";
    linebreak = true; # Wrap lines at convenient points
    list = true; # Show some invisible characters (tabs...
    mouse = "a"; # Enable mouse mode
    number = true; # Print line number
    pumblend = 10; # Popup blend
    pumheight = 10; # Maximum number of entries in a popup
  };
}
