function link {
    mkdir -p $CONFIG_PATH

    for link_file in "${LINK_FILES[@]}"; do
        config_file_path=$INSTALLER_PATH/$link_file

        echo "Link from $config_file_path"

        rm -rf $CONFIG_PATH/$link_file
        ln -s $config_file_path $CONFIG_PATH/$link_file
    done
}

function unlink {
    for link_file in ${LINK_FILES[@]}; do
        config_file_path=$INSTALLER_PATH/$link_file

        echo "Unlink from $config_file_path"

        rm -rf $CONFIG_PATH/$link_file
    done

    # file list do not need to remove config path because it just link needed files
}
