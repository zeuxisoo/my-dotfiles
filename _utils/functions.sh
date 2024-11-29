function print {
    if [[ $QUIET == 0 ]]; then
        echo -ne "$1";
    fi
}

function new_line {
    echo ""
}
