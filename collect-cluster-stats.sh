#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin:/snap/bin
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
LOGFILE="cluster-stats-$TIMESTAMP.txt"

{
  echo "===== Cluster Stats @ $TIMESTAMP ====="
  echo
  echo "--- Node Usage ---"
  kubectl describe nodes

  echo "--- Pod Status ---"
  kubectl get pods -A -o wide
} > $LOGFILE

echo "Saved: $LOGFILE"



'''
chmod +x collect-cluster-stats.sh


crontab -e
*/3 * * * *  /home/ama111138/yunikorn-test/collect-cluster-stats.sh

'''

