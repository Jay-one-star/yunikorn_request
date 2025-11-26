apiVersion: apps/v1
kind: Deployment
metadata:
  name: small-pods
  namespace: yunikorn-test
spec:
  replicas: 50
  selector:
    matchLabels:
      app: small
  template:
    metadata:
      labels:
        app: small
    spec:
      schedulerName: yunikorn
      restartPolicy: Always
      containers:
        - name: small
          image: mytest/small:1.0
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "100m"
              memory: "128Mi"

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: medium-pods
  namespace: yunikorn-test
spec:
  replicas: 50
  selector:
    matchLabels:
      app: medium
  template:
    metadata:
      labels:
        app: medium
    spec:
      schedulerName: yunikorn
      restartPolicy: Always
      containers:
        - name: medium
          image: mytest/medium:1.0
          resources:
            requests:
              cpu: "500m"
              memory: "512Mi"
            limits:
              cpu: "500m"
              memory: "512Mi"

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: large-pods
  namespace: yunikorn-test
spec:
  replicas: 50
  selector:
    matchLabels:
      app: large
  template:
    metadata:
      labels:
        app: large
    spec:
      schedulerName: yunikorn
      restartPolicy: Always
      containers:
        - name: large
          image: mytest/large:1.0
          resources:
            requests:
              cpu: "1500m"
              memory: "1Gi"
            limits:
              cpu: "1500m"
              memory: "1Gi"



kubectl annotate namespace yunikorn-test yunikorn.apache.org/scheduler=yunikorn
kubectl annotate namespace online-boutique yunikorn.apache.org/scheduler=yunikorn
kubectl apply -f ~/pods-150.yaml



