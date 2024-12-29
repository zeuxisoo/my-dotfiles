source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
source $PWD/_utils/linkers/dotfile.sh

# Set install directory path
INSTALLER_PATH=$CURRENT_PATH/vim

# Set self linked directory path
CONFIG_PATH=$HOME_PATH/.config/vim

function install {
    mkdir -p $CONFIG_PATH
    git clone https://github.com/VundleVim/Vundle.vim.git $CONFIG_PATH/bundle/Vundle.vim
    link
    vim +PluginInstall +qall
}

function uninstall {
    unlink
    rm -rf $CONFIG_PATH/bundle/Vundle.vim
    rm -rf $CONFIG_PATH
}

source $PWD/_utils/commands.sh
