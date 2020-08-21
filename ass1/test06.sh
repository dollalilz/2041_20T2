shrug-init
touch a b c d e f

shrug-add a b
shrug-rm --force a b

shrug-rm --cache a b
shrug-rm a b

rm .shrug
shrug-rm --cache a b
shrug-rm a 
shrug-init
shrug-add a b c 