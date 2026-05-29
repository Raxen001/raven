#!/bin/sh

# Paths
UPLOAD_LOCATION="/home/raven/Pictures"
REMOTE_HOST="raxen@192.168.1.11"
REMOTE_BACKUP_PATH="/home/raxen/Downloads/backup/raven/immich"


### Local

# Backup Immich database
# docker exec -t immich_postgres pg_dumpall --clean --if-exists --username=<DB_USERNAME> > "$UPLOAD_LOCATION"/database-backup/immich-database.sql
# For deduplicating backup programs such as Borg or Restic, compressing the content can increase backup size by making it harder to deduplicate. If you are using a different program or still prefer to compress, you can use the following command instead:
docker exec -t immich_postgres pg_dumpall --clean --if-exists --username=postgres | /usr/bin/gzip --rsyncable > "$UPLOAD_LOCATION"/database-backup/immich-database.sql.gz

### Append to remote Borg repository
borg create "$REMOTE_HOST:$REMOTE_BACKUP_PATH/immich-borg::{now}" "$UPLOAD_LOCATION" --exclude "$UPLOAD_LOCATION"/thumbs/ --exclude "$UPLOAD_LOCATION"/encoded-video/
borg prune --keep-weekly=4 --keep-monthly=3 "$REMOTE_HOST:$REMOTE_BACKUP_PATH"/immich-borg
borg compact "$REMOTE_HOST:$REMOTE_BACKUP_PATH"/immich-borg
