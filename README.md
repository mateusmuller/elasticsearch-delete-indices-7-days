# ElasticSearch script to clear indices older than 7 days

Due to the creation of ElasticSearch indices, my homelab storage is getting full within ~2 weeks. Since I failed to use Index Lifecycle Policies from ElasticSearch, I've created this smalll automation as a workaround in the meantime.

- `check_indices.sh`: This is the script that makes the magic. Pretty much hitting the ElasticSearch API grabbing the indices that have the keyword "logstash" (coming from FluentD in my case). Feel free to change it. Everything older than 7 days should be removed.
- `Dockerfile`: To be used to build your own image.
- `job.yaml`: This has been used during development along with Skaffold.
- `skaffold.yaml`: Skaffold configuration for my development environment.

Inside of the folder `examples` you'll see the YAML file I'm using inside of the cluster with the generated image. This will execute everyday at 9PM.

I hope it helps!