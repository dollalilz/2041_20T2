shrug-init
#Initialized empty shrug repository in .shrug
echo 1 >a
echo 2 >b
echo 3 >c
shrug-add a b c
shrug-commit -m "first commit"
#Committed as commit 0
echo 4 >>a
echo 5 >>b
echo 6 >>c
echo 7 >d
echo 8 >e
shrug-add b c d
echo 9 >b
shrug-rm a
#shrug-rm: error: 'a' in repository is different to working file
shrug-rm b
#shrug-rm: error: 'b' in index is different to both working file and repository
shrug-rm c  #up to here
#shrug-rm: error: 'c' has changes staged in the index
shrug-rm d
#shrug-rm: error: 'd' has changes staged in the index
shrug-rm e #>>>>>>>>>>>>>>> here 
#shrug-rm: error: 'e' is not in the shrug repository
shrug-rm --cached a
shrug-rm --cached b #>>>>>>>>>>>>>>>>>>>>>> HERE 
#shrug-rm: error: 'b' in index is different to both working file and repository
shrug-rm --cached c
shrug-rm --cached d
shrug-rm --cached e
#shrug-rm: error: 'e' is not in the shrug repository
shrug-rm --force a
#shrug-rm: error: 'a' is not in the shrug repository
shrug-rm --force b
shrug-rm --force c
#shrug-rm: error: 'c' is not in the shrug repository
shrug-rm --force d
#shrug-rm: error: 'd' is not in the shrug repository
shrug-rm --force e
#shrug-rm: error: 'e' is not in the shrug repository