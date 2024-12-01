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
            echo "[Utils]: unknown command > $COMMAND"
        fi
    ;;
esac
