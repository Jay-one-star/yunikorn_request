#!/bin/bash
# 一鍵循環部署 200 次測試 YuniKorn 排程效果
# Namespace
NAMESPACE=yunikorn-test
# 循環次數
ITERATIONS=200

# Small Pod
SMALL_POD=$(cat <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: test-small
  namespace: $NAMESPACE
spec:
  schedulerName: yunikorn
  containers:
    - name: small
      image: busybox
      command: ["sh", "-c", "sleep 60"]
      resources:
        requests:
          cpu: "100m"
          memory: "128Mi"
        limits:
          cpu: "100m"
          memory: "128Mi"
EOF
)

# Medium Pod
MEDIUM_POD=$(cat <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: test-medium
  namespace: $NAMESPACE
spec:
  schedulerName: yunikorn
  containers:
    - name: medium
      image: busybox
      command: ["sh", "-c", "sleep 60"]
      resources:
        requests:
          cpu: "500m"
          memory: "512Mi"
        limits:
          cpu: "500m"
          memory: "512Mi"
EOF
)

# Large Pod
LARGE_POD=$(cat <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: test-large
  namespace: $NAMESPACE
spec:
  schedulerName: yunikorn
  containers:
    - name: large
      image: busybox
      command: ["sh", "-c", "sleep 60"]
      resources:
        requests:
          cpu: "1500m"
          memory: "1Gi"
        limits:
          cpu: "1500m"
          memory: "1Gi"
EOF
)

echo "=== 開始 200 次循環測試 YuniKorn 排程 ==="

for i in $(seq 1 $ITERATIONS); do
  echo "=== 第 $i 輪 ==="

  # 部署 Small / Medium / Large Pod
  echo "$SMALL_POD" | kubectl apply -f -
  echo "$MEDIUM_POD" | kubectl apply -f -
  echo "$LARGE_POD" | kubectl apply -f -

  # 等待 10 秒讓 Pod 排程
  sleep 10

  # 查看 Pod 狀態
  kubectl get pods -n $NAMESPACE -o wide

  # 刪除 Pod，下一輪重新排程
  kubectl delete pod test-small test-medium test-large -n $NAMESPACE --ignore-not-found

  # 小間隔再下一輪
  sleep 5
done

echo "=== 完成 200 輪循環測試 ==="
