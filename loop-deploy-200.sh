curl -LO https://github.com/containerd/nerdctl/releases/download/v1.7.6/nerdctl-full-1.7.6-linux-amd64.tar.gz
sudo tar Cxzvvf /usr/local/bin nerdctl-full-1.7.6-linux-amd64.tar.gz

nerdctl build -t mytest/small:1.0 .
nerdctl build -t mytest/medium:1.0 .
nerdctl build -t mytest/large:1.0 .

nerdctl save mytest/small:1.0 | sudo ctr -n=k8s.io images import -
nerdctl save mytest/medium:1.0 | sudo ctr -n=k8s.io images import -
nerdctl save mytest/large:1.0 | sudo ctr -n=k8s.io images import -

sudo ctr -n=k8s.io images ls | grep mytest
