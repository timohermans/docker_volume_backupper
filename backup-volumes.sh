#!/bin/bash

volumes=(server_db_data)
remote="gdrive"

echo "Starting selected docker volume backups"

for i in "${volumes[@]}"
do
  file="$i.tar"
  rclone_file="$(date +%s)_$file"

  if ! vackup export $i $file 
  then
    echo "failed creating backup for $i"
    exit 1
  fi

  cp $file $rclone_file
  rm -f $file

  if ! rclone copyto $rclone_file $remote:/backups/docker_volumes/$i/$rclone_file 
  then
    echo "Failed uploading volume $i to remote $remote"
  else
    echo "Successfully backed up volume $i to remote $remote"
  fi

  rm $rclone_file
done

echo "Done with all backups of docker volumes"
