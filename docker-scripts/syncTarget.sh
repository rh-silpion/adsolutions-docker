#!/usr/bin/env sh

(
    if [[ "$1" == "force" ]]; then
      echo -e "\n-----------------------" &&
      echo "Forced synchronization!" &&
      echo -e "-----------------------\n" &&
      rsync -rth --info=progress2 --no-inc-recursive --no-compress --links --stats --delete --delete-before /app/target/ /tmp/target/
    else
      rsync -ruth --info=progress2 --no-inc-recursive --no-compress --links --stats /tmp/target/ /app/target/ &&
      rsync -ruth --info=progress2 --no-inc-recursive --no-compress --links --stats /app/target/ /tmp/target/
    fi
)
