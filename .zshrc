# Customize to your needs...
for file in ~/.{zsh_function,zsh_export,zsh_alias}; do
    [ -r "$file" ] && source "$file"
done
unset file
