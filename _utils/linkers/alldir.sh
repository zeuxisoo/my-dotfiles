function link {
    mkdir -p $CONFIG_PATH

    for file_or_dir_path in `ls -d $INSTALLER_PATH/??* $INSTALLER_PATH/.??* | grep -vE '.DS_Store|README.md|main.sh$'`; do
        echo "Link from $file_or_dir_path"

        file_or_dir_name=$(basename $file_or_dir_path)

        rm -rf $CONFIG_PATH/$file_or_dir_name
        ln -s $file_or_dir_path $CONFIG_PATH/$file_or_dir_name
    done
}

function unlink {
    for file_or_dir_path in `ls -d $INSTALLER_PATH/??* $INSTALLER_PATH/.??* | grep -vE '.DS_Store|README.md|main.sh$'`; do
        echo "Unlink from $file_or_dir_path"

        file_or_dir_name=$(basename $file_or_dir_path)

        rm -rf $CONFIG_PATH/$file_or_dir_name
    done

    rm -rf $CONFIG_PATH
}
