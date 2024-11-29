function link {
    for dotfile_path in `ls -d $INSTALLER_PATH/.??* | grep -vE '.DS_Store|.git$'`; do
        echo "Link from $dotfile_path"

        dotfile_name=$(basename $dotfile_path)

        rm -rf $HOME_PATH/$dotfile_name
        ln -s $dotfile_path $HOME_PATH/$dotfile_name
    done
}

function unlink {
    for dotfile_path in `ls -d $INSTALLER_PATH/.??* | grep -vE '.DS_Store|.git$'`; do
        echo "Unlink from $dotfile_path"

        dotfile_name=$(basename $dotfile_path)

        rm -rf $HOME_PATH/$dotfile_name
    done
}
