shrug-init
touch a b c d e f

shrug-add a b
shrug-rm --force a b

shrug-rm --cache a b
shrug-rm a b

shrug-commit -m hello
shrug-rm --force a b

shrug-rm --cache a b
shrug-rm a b

shrug-add c d e 
shrug-commit -m hello
shrug-rm --force a b

shrug-rm --cache a b
shrug-rm a b

