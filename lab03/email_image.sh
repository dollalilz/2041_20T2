#!/bin/sh

for image in "$@"
do
    display "$image"
    echo "Address to e-mail this image to?"
    read email
    echo "Message to accompany image?"
    read message
    echo "$message" | mutt -s "$image" -e 'set copy=no' -a "$image" -- "$email"
    echo "$message sent to $email"
done