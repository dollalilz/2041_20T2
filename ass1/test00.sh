shrug-init
touch a b c 
shrug-add a b c
shrug-commit -m 'first'
echo hi > a 
echo hi > b 
echo hi > c

shrug-add a b
shrug-rm a b  
shrug-rm --force a b
shrug-rm --cached a b
