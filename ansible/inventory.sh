#ansible-inventory -i my.gcp.yml --list --output inventory.json
#!/bin/bash

app_ip=$(gcloud compute instances describe reddit-app-0 --format='get(networkInterfaces[0].accessConfigs[0].natIP)' --zone europe-west1-b)
db_ip=$(gcloud compute instances describe reddit-db --format='get(networkInterfaces[0].accessConfigs[0].natIP)' --zone europe-west1-b)
i=$(echo "{
  "app": {
    "hosts": [\"$app_ip \"]
    },
  "db": {
    "hosts": [\"$db_ip \"]
    }
}"
)

echo $i > inventory.json
