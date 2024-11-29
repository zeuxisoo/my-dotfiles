COMMAND=${@:$OPTIND:1}

case $COMMAND in
    install)
        install
    ;;

    uninstall)
        uninstall
    ;;

    *)
        if [[ COMMAND != "" ]]; then
            print "[Utils]: unknown command > $COMMAND\n\n"
        fi
    ;;
esac
