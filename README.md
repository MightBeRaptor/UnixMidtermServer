# UnixMidtermServer
This is a mid term project for a Unix System Administration course.

## Overview
Create 3 servers and 1 dashboard api/agent that monitors the servers, displays performance statistics, reboots the servers when they fail, and includes basic notification support.

## Disclaimer
This server is designed to be cloned into a GCP Google Cloud Ubuntu VM instance. The `get_metrics.sh` script may not function as expected in other environments and may require alterations for other operating systems during the dependency installation stage.

## Setup
1. Within the GCP instance, `git clone https://github.com/MightBeRaptor/UnixMidtermServer.git`
2. `cd UnixMidTermServer`
3. Create `.env` using `.env.example` as a guide
4. `bash src/update_dependencies.sh` - Installs dependencies for checking metrics and stressing the server
5. WIP `bash src/add_crontab.sh` - Adds a crontab entry that WIP runs `bash src/get_socket_status.sh` every 5 minutes which saves the socket's current status to `tmp/socket_status.txt` and restarts `python src/server.py`

## Starting the server socket
1. The crontab will start the server (if its not already up) with `python src/server.py`    
2. Every 5 minutes of the dashboard's runtime, it will request the server to run:
    2.1. `bash src/stresser.sh` - Stresses the server
    2.2. `bash src/get_metrics.sh` - Retrieve's metrics and writes them to `data/metrics_<timestamp>.txt`
    2.3. `python3 src/parse_metrics.py` - Parses the metrics from the raw txt into a readable json format in `data/metrics_<timestamp>.json`
    2.4. WIP: sends `data/metrics_<timestamp.json` back to the dashboard at `data/serverN/metrics_<timestamp>.json`, where serverN is the server_name from `.env`
3. When the server is no longer connected to the dashboard, it will run
    3.1. WIP `rm tmp/socket_status.txt` - To ensure the next time its started its not using the previous session's status