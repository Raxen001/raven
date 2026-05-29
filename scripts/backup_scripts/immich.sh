UPLOAD_LOCATION="~/.config/postgres"
BACKUP_PATH="/home/raven/backups/immich"
REMOTE_HOST="raxen@192.168.1.11"
REMOTE_BACKUP_PATH="/home/raxen/Downloads/backup/raven/immich"

borg init --encryption=none "$REMOTE_HOST:$REMOTE_BACKUP_PATH/immich-borg"
