#!/bin/bash
NAMESPACE=yunikorn-test
OUTPUT_FILE=pods-150.yaml

echo "# Auto-generated Pod list for YuniKorn test" > $OUTPUT_FILE

generate_pod() {
  local TYPE=$1
  local CPU=$2
  local MEM=$3
  local COUNT=$4

  for i in $(seq 1 $COUNT); do
cat <<EOF >> $OUTPUT_FILE
---
apiVersion: v1
kind: Pod
metadata:
  name: test-${TYPE}-${i}
  namespace: $NAMESPACE
spec:
  schedulerName: yunikorn
  restartPolicy: Never
  containers:
    - name: ${TYPE}
      image: busybox
      command: ["sh", "-c", "sleep 5"]
      resources:
        requests:
          cpu: "$CPU"
          memory: "$MEM"
        limits:
          cpu: "$CPU"
          memory: "$MEM"
EOF
  done
}

# 產生 small/medium/large 各 50 個
generate_pod "small"  "100m"  "128Mi" 50
generate_pod "medium" "500m"  "512Mi" 50
generate_pod "large"  "1500m" "1Gi"   50

echo "=== YAML 已產生：$OUTPUT_FILE ==="
echo "=== 使用以下指令部署 150 個 Pods ==="
echo
echo "kubectl apply -f $OUTPUT_FILE"
