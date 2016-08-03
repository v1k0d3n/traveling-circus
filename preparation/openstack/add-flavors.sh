#/bin/sh!
openstack flavor create J1.LAB.5M.10XG --id  61 --ram 512   --disk 10  --vcpus 1 --public
openstack flavor create J1.LAB.1G.20XG --id  62 --ram 1024  --disk 15  --vcpus 1 --public
openstack flavor create J1.LAB.2G.40XG --id  63 --ram 2048  --disk 20  --vcpus 1 --public
