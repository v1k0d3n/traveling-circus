#/bin/sh!
export TC_LABADMPASS="changethis"
export TC_KUBEPASS="changethat"
openstack user create --project=kube-os-lab-00 --password=$TC_LABADMPASS labadmin
openstack user create --project=kube-os-lab-00 --password=$TC_KUBEPASS kubeadmin00
openstack user create --project=kube-os-lab-01 --password=$TC_KUBEPASS kubeadmin01
openstack user create --project=kube-os-lab-02 --password=$TC_KUBEPASS kubeadmin02
openstack user create --project=kube-os-lab-03 --password=$TC_KUBEPASS kubeadmin03
openstack user create --project=kube-os-lab-04 --password=$TC_KUBEPASS kubeadmin04
openstack user create --project=kube-os-lab-05 --password=$TC_KUBEPASS kubeadmin05
openstack user create --project=kube-os-lab-06 --password=$TC_KUBEPASS kubeadmin06
openstack user create --project=kube-os-lab-07 --password=$TC_KUBEPASS kubeadmin07
openstack user create --project=kube-os-lab-08 --password=$TC_KUBEPASS kubeadmin08
openstack user create --project=kube-os-lab-09 --password=$TC_KUBEPASS kubeadmin09
openstack user create --project=kube-os-lab-10 --password=$TC_KUBEPASS kubeadmin10
openstack user create --project=kube-os-lab-11 --password=$TC_KUBEPASS kubeadmin11
openstack user create --project=kube-os-lab-12 --password=$TC_KUBEPASS kubeadmin12
openstack user create --project=kube-os-lab-13 --password=$TC_KUBEPASS kubeadmin13
openstack user create --project=kube-os-lab-14 --password=$TC_KUBEPASS kubeadmin14
openstack user create --project=kube-os-lab-15 --password=$TC_KUBEPASS kubeadmin15
openstack user create --project=kube-os-lab-16 --password=$TC_KUBEPASS kubeadmin16
openstack user create --project=kube-os-lab-17 --password=$TC_KUBEPASS kubeadmin17
openstack user create --project=kube-os-lab-18 --password=$TC_KUBEPASS kubeadmin18
openstack user create --project=kube-os-lab-19 --password=$TC_KUBEPASS kubeadmin19
openstack user create --project=kube-os-lab-20 --password=$TC_KUBEPASS kubeadmin20
openstack user create --project=kube-os-lab-21 --password=$TC_KUBEPASS kubeadmin21
openstack user create --project=kube-os-lab-22 --password=$TC_KUBEPASS kubeadmin22
openstack user create --project=kube-os-lab-23 --password=$TC_KUBEPASS kubeadmin23
openstack user create --project=kube-os-lab-24 --password=$TC_KUBEPASS kubeadmin24
openstack user create --project=kube-os-lab-25 --password=$TC_KUBEPASS kubeadmin25
