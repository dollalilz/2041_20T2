shrug-init
touch a b c d

shrug-add a b
shrug-rm a b
shrug-commit -m hello
shrug-rm a b
shrug-add c d 
shrug-rm --force c d 

shrug-show :c