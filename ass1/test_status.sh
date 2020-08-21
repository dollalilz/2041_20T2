shrug-init
#Initialized empty shrug repository in .shrug
touch a b c d e f g h
shrug-add a b c d e f
shrug-commit -m 'first commit'
#Committed as commit 0
echo hello >a
echo hello >b
echo hello >c
shrug-add a b
echo world >a
rm d
shrug-rm e
shrug-add g
shrug-status
# a - file changed, different changes staged for commit
# b - file changed, changes staged for commit
# c - file changed, changes not staged for commit
# d - file deleted
# e - deleted
# f - same as repo
# g - added to index
# h - untracked
# shrug-add - untracked
# shrug-commit - untracked
# shrug-init - untracked
# shrug-rm - untracked
# shrug-status - untracked