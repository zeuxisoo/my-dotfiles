source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
source $PWD/_utils/linker.sh

CURRENT_PATH=$CURRENT_PATH/screen

function install {
    link
}

function uninstall {
    unlink
}

source $PWD/_utils/commands.sh
