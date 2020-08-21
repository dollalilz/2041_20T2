shrug-init

shrug-rm --force a 
touch a 
shrug-add a
shrug-commit -m "hello"

shrug-rm --force a 
shrug-rm --force b

touch b 
shrug-add b
shrug-commit -m "hello"
shrug-rm --force b

