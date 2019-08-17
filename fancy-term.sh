# Colors
white=$(tput setaf 15);
blue=$(tput setaf 45);
purple=$(tput setaf 62);
yellow=$(tput setaf 228);

# Util
bold=$(tput bold);
reset=$(tput sgr0);

PS1="\[${bold}\]";
PS1+="\[${blue}\]\u"; #username
PS1+="\[${white}\] @ ";
PS1+="\[${purple}\]\h" #host
PS1+="\[${white}\] in ";
PS1+="\[${yellow}\]\W"; #working directory
PS1+="\n";
PS1+="\[${white}\]-> \[${reset}\]"; # `$` then reset color 

export PS1;
