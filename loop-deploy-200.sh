docker save mytest/small:1.0 -o small.tar
docker save mytest/medium:1.0 -o medium.tar
docker save mytest/large:1.0 -o large.tar

scp small.tar ama111138@ama111138-host:/home/ama111138/
scp medium.tar ama111138@ama111138-host:/home/ama111138/
scp large.tar ama111138@ama111138-host:/home/ama111138/

sudo ctr -n=k8s.io images import small.tar
sudo ctr -n=k8s.io images import medium.tar
sudo ctr -n=k8s.io images import large.tar

sudo ctr -n=k8s.io images ls

