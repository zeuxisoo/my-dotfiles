cmd_exists() {
    (( $+commands[$1] ));
}
