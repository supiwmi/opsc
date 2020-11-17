#!/bin/bash

sed -n -e 's/\(password\|username\)="\(.*\)"/\2/gp' userlist.txt \
  | while IFS= read -r line; do
    if [ -n "$username" ]; then
      password="$line"
      # create password for that user
      echo $password | passwd --stdin $username
      passwd -e $username

      # At the end you need to unset the username and password:
      username=
      password=
    else
      username="$line"
      #add a new user
      useradd -m $username -s /bin/bash
    fi
  done
