docker run --network website_tokyohackerspace \
  --mount type=bind,source=$HOME/Tokyohackerspace/website/backups,target=/tmp/backups \
  --mount type=bind,source=$HOME/Tokyohackerspace/website/data,target=/data \
  --mount type=bind,source=$HOME/Tokyohackerspace/website/ths-backup-management/scripts,target=/tmp/scripts \
  -it ths-backup-management /bin/bash