# touch a b c 
# shrug-init
# echo hello > .status/a 
# echo hello > .status/b 
# echo hello > .status/c
# touch e f
# update_tracker

# shrug-status

shrug-init
#Initialized empty shrug repository in .shrug
touch a b c
shrug-add a b c
shrug-commit -m 'first commit'
#Committed as commit 0
echo hello >a
echo hello >b
echo hello >c
shrug-add a b
echo world >a
rm d
shrug-status