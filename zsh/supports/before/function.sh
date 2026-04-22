cmd_exists() {
    (( $+commands[$1] ));
}

path_exists() {
    [[ -e $1 ]]
}
