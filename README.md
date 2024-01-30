Created this script to backup important docker volumes and send them to google drive.

## Installing

First open up crontab

```shell
crontab -e
```

Then add it to run on a weekly basis

```bash
[..]
0 0 * * 1 /home/<user>/apps/docker_volume_backupper/backup-volumes.sh
```
