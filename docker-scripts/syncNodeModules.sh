#!/usr/bin/env sh

(
    if [[ "$1" == "force" ]]; then
      echo -e "\n-----------------------" &&
      echo "Forced synchronization!" &&
      echo -e "-----------------------\n" &&
      rsync -rth --info=progress2 --no-inc-recursive --no-compress --links --stats --delete --delete-before /app/node_modules/ /tmp/node_modules/
    else
      rsync -ruth --info=progress2 --no-inc-recursive --no-compress --links --stats /tmp/node_modules/ /app/node_modules/ &&
      rsync -ruth --info=progress2 --no-inc-recursive --no-compress --links --stats /app/node_modules/ /tmp/node_modules/
    fi
)
