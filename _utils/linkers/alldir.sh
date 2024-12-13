function link {
    if [[ -z "${CONFIG_PATH+any}" ]]; then
        echo 'Please set the CONFIG_PATH variable first when using the `alldir` linker'
        exit 1
    fi

    mkdir -p $CONFIG_PATH

    for file_or_dir_path in `ls -d $INSTALLER_PATH/??* $INSTALLER_PATH/.??* | grep -vE '.DS_Store|README.md|main.sh$'`; do
        echo "Link from $file_or_dir_path"

        file_or_dir_name=$(basename $file_or_dir_path)

        rm -rf $CONFIG_PATH/$file_or_dir_name
        ln -s $file_or_dir_path $CONFIG_PATH/$file_or_dir_name
    done
}

function unlink {
    if [[ -z "${CONFIG_PATH+any}" ]]; then
        echo 'Please set the CONFIG_PATH variable first when using the `alldir` linker'
        exit 1
    fi

    for file_or_dir_path in `ls -d $INSTALLER_PATH/??* $INSTALLER_PATH/.??* | grep -vE '.DS_Store|README.md|main.sh$'`; do
        echo "Unlink from $file_or_dir_path"

        file_or_dir_name=$(basename $file_or_dir_path)

        rm -rf $CONFIG_PATH/$file_or_dir_name
    done

    rm -rf $CONFIG_PATH
}
