curl -LO https://github.com/containerd/nerdctl/releases/download/v1.7.6/nerdctl-full-1.7.6-linux-amd64.tar.gz
sudo tar Cxzvvf /usr/local/bin nerdctl-full-1.7.6-linux-amd64.tar.gz

sudo tar -xvzf nerdctl-full-1.7.6-linux-amd64.tar.gz -C /usr/local/bin

wget https://github.com/containerd/nerdctl/releases/download/v1.7.7/nerdctl-full-1.7.7-linux-amd64.tar.gz
sudo tar zxvf nerdctl-full-1.7.7-linux-amd64.tar.gz -C /usr/local
echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc


sudo nerdctl --namespace k8s.io build -t mytest/small:1.0 .
sudo nerdctl --namespace k8s.io build -t mytest/medium:1.0 .
sudo nerdctl --namespace k8s.io build -t mytest/large:1.0 .


nerdctl save mytest/small:1.0 | sudo ctr -n=k8s.io images import -
nerdctl save mytest/medium:1.0 | sudo ctr -n=k8s.io images import -
nerdctl save mytest/large:1.0 | sudo ctr -n=k8s.io images import -

sudo ctr -n=k8s.io images ls | grep mytest
