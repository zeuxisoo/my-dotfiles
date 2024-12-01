function link {
    config_path=$1
    shift
    link_files=("${@}")

    # Bash version: >=4.3, call: "LINK_FILES[@]"
    # link_files=("${!2}")

    mkdir -p $config_path

    for link_file in "${link_files[@]}"; do
        config_file_path=$INSTALLER_PATH/$link_file

        echo "Link from $config_file_path"

        rm -rf $config_path/$link_file
        ln -s $config_file_path $config_path/$link_file
    done
}

function unlink {
    config_path=$1
    shift
    link_files=("${@}")

    for link_file in ${link_files[@]}; do
        config_file_path=$INSTALLER_PATH/$link_file

        echo "Unlink from $config_file_path"

        rm -rf $config_path/$link_file
    done
}
