<!-- Element attributes -->
### Kubernetes for Everyone <!-- .element: class="title" style="color:black; text-align:left; font-size:3.0em;" -->
<b><span style="color:#464646">Brandon B. Jozsa</span></b>
<br><b><span style="color:#464646">AT&T:</span></b> Principal Community Development Lead
<br>    Open Source Software and Container Strategy
<br><b><span style="color:#464646">Email:</span></b> bjozsa@jinkit.com
<br><b><span style="color:#464646">Twitter:</span></b> @v1k0d3n
<br><b><span style="color:#464646">Date:</span></b> Aug 3rd, 2016
<!-- .slide: style="color:white; text-align:left; font-size:0.65em;"> -->



## Labwork <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
(Part I: Building Kubernetes)
<!-- .slide: style="color:white; text-align:center;"> -->
Note: We've actually going to start building our containers first, and while our environments are being deployed/built, we're going to discuss the benefits of using Kubernetes. After we discuss these benefits, we're going to deploy an application in our environment(s) and were going to dive in a little deeper.


### Requirements <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- <span style="color:#464646">WiFi:</span> "kubelab"
  - <span style="color:#464646">Pass:</span> "openstack"
- Terminal Application (for SSH connectivity to lab hosts)
- Web Browser
<!-- .slide: style="color:white; text-align:left;"> -->
Note: Have users verify that they can connect to the WiFi network provided.


### Getting Started: Horizon <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- <span style="color:#464646">URL:</span> https://192.168.70.25
  - <span style="color:#464646">SSID:</span> "kubeadmin{{xx}}"
  - <span style="color:#464646">Pass:</span> "kubelab"
<!-- .slide: style="color:white; text-align:left;"> -->
Note: Ensure that users can access the Horizon portal.


### Getting Started: Terminal <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- <span style="color:#464646">SSH:</span> 172.29.248.40
  - <span style="color:#464646">SSID:</span> "kubeadmin{{xx}}"
  - <span style="color:#464646">Pass:</span> "kubepass"
<!-- .slide: style="color:white; text-align:left;"> -->
Note: Make sure that everyone can access the kubernetes control node. This is the server users will deploy their Kubernetes clusters from.


### Openstack-CLI <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
```sh
$ ssh kubeadmin01@172.29.248.40
 ...
 ...
kube-control:~$ cd openstack/
kube-control:~/openstack$ ls -asl
.
drwxr-xr-x  2 kubeadmin01 users        .
drwxr-xr-x 10 kubeadmin01 kubeadmin00  ..
-rwxr--r--  1 kubeadmin01 users        deploy-environment.sh
-rwxr--r--  1 kubeadmin01 users        deploy-servers.sh
-rwxr--r--  1 kubeadmin01 users        destroy-lab.sh
-rwxr--r--  1 kubeadmin01 users        openrc
-rwxr--r--  1 kubeadmin01 users        rebuild-servers.sh
kube-control:~/openstack$ source openrc
Please enter your OpenStack Password:
kube-control:~/openstack$
```
<!-- .slide: style="color:white; text-align:center;"> -->
Note: Have users look around. They have some folders in their /home directories. Have them explore, and run their first Openstack command in this lab.


### Openstack-CLI <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
```sh
kube-control:~/openstack$ openstack image list
+--------------------------------------+---------------------------------+--------+
| ID                                   | Name                            | Status |
+--------------------------------------+---------------------------------+--------+
| 8f738d67-4884-4c2f-bde3-98246ad05c9d | coreos-alpha-1097.0.0           | active |
| 9d61c1d8-e9bb-4174-b1dc-be574dcb1f33 | coreos-beta-1068.3.0            | active |
| 1a4f5b8e-85fc-4abb-977a-9bf805242851 | coreos-stable-1010.6.0          | active |
+--------------------------------------+---------------------------------+--------+
kube-control:~/openstack$ ./deploy-environment.sh
kube-control:~/openstack$ ./deploy-servers.sh
kube-control:~/openstack$
```
<!-- .slide: style="color:white; text-align:center;"> -->
Note: Have users focus on CoreOS for the purpose of this demonstration.


<!-- Element attributes -->
### Review: Impact of IaaS <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- Published Public SSH Key to Openstack <!-- .element: class="fragment" data-fragment-index="1" -->
- Created Firewall Security Groups <!-- .element: class="fragment" data-fragment-index="2" -->
- Added Firewall Rules to the Security Groups <!-- .element: class="fragment" data-fragment-index="2" -->
- Created CoreOS Instances <!-- .element: class="fragment" data-fragment-index="3" -->
  - <span style="color:#464646">CPU:</span> 1
  - <span style="color:#464646">Memory:</span> 2GB
  - <span style="color:#464646">Disk Space:</span> 20GB
  - <span style="color:#464646">Names:</span> kube-node01-03
- Deployed Public Key to the CoreOS Instances <!-- .element: class="fragment" data-fragment-index="4" -->
- Attached Network Interfaces to our Instances <!-- .element: class="fragment" data-fragment-index="5" -->
- Applied Firewall Rules <!-- .element: class="fragment" data-fragment-index="6" -->
<!-- .slide: style="color:white; text-align:left;"> -->
Note: Talk about what just happened and the overall impact of IaaS. But what about applications? Enter Kubernetes!


### Kubernetes: API's <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
```sh
kube-control:~/kargo$ cd ~
kube-control:~$ ./changepass.sh
oldpass: R3MpFX7hx7WKVKtjzvwbWWnsf4WcTc4qRg9mnmqnRbwpKxxqfgzqRstg7pFj7X4P
newpass: LcpszLskKkpqcNPdmHnrp9H73HLH9rzPKddWwL3HxgkmdXJMWHmkTndmpvjXJz9d
location: /home/kubeadmin00/kargo/inventory/group_vars/all.yml
kubeadmin00@kube-control:~$
```
<!-- .slide: style="color:white; text-align:center;"> -->
Note: Now we're going to move on to our Kubernetes deployment. We're using Kubespray, and tell users we will provide this information at the end of our demonstration. We also have everything included on Github.


### Kubernetes: Inventory <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
```sh
kube-control:~$ cd kargo/
kube-control:~/kargo$ openstack server list
+--------------------------------------+--------------+--------+----------------------+
| ID                                   | Name         | Status | Networks             |
+--------------------------------------+--------------+--------+----------------------+
| 2e46fe05-4bf9-436d-90ec-2fc86e5c4ca6 | kube-node03  | ACTIVE | public=172.29.248.78 |
| fd7fee61-1599-4848-8e21-2dd3976eaed3 | kube-node02  | ACTIVE | public=172.29.248.77 |
| b2ebd89b-af74-440a-8644-a898676ef561 | kube-node01  | ACTIVE | public=172.29.248.76 |
+--------------------------------------+--------------+--------+----------------------+
kube-control:~/kargo$ vi inventory/inventory.cfg
...
[kube-master]
kube-node01 ansible_ssh_host=172.29.248.76
kube-node02 ansible_ssh_host=172.29.248.77
kube-node03 ansible_ssh_host=172.29.248.78
...
```
<!-- .slide: style="color:white; text-align:center;"> -->
Note: Have them perform an "openstack server list" to view the instances they've created. Have them add these ip addresses in the inventory.cfg file.


### Kubernetes: Deployment <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
*<span style="color:#464646">Suggestion:</span> Use "screen" command prior to deployment.*
```sh
kube-control:~/kargo$ screen
kube-control:~/kargo$ ansible-playbook -u core \
    -e ansible_ssh_user=core -b --become-user=root \
    -i inventory/inventory.cfg coreos-bootstrap.yml

kube-control:~/kargo$ ansible-playbook -u core \
    -e ansible_ssh_user=core -b --become-user=root \
    -i inventory/inventory.cfg cluster.yml
```
<!-- .slide: style="color:white; text-align:center;"> -->
Note: Lastly (for part 1 of the lab), have users deploy Kubernetes by first bootstrapping CoreOS, and then by running the cluster.yml declaration.



<!-- Element attributes -->
### Kubernetes Concepts <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- Containers <!-- .element: class="fragment" data-fragment-index="1" -->
- Pods <!-- .element: class="fragment" data-fragment-index="2" -->
- Replication Controller <!-- .element: class="fragment" data-fragment-index="3" -->
- Labels <!-- .element: class="fragment" data-fragment-index="4" -->
- Services <!-- .element: class="fragment" data-fragment-index="5" -->
<!-- .slide: style="color:white; text-align:left;"> -->



### The Container <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- VM vs. Application <!-- .element: class="fragment" data-fragment-index="1" -->
- Control Groups and Namespaces for Isolation <!-- .element: class="fragment" data-fragment-index="2" -->
- Images are Applications w/Bundled Dependancies <!-- .element: class="fragment" data-fragment-index="3" -->
- "Base Images" Offer Developers Familiar Tools <!-- .element: class="fragment" data-fragment-index="4" -->
<!-- .slide: style="color:white; text-align:left;"> -->


### Package Managers <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
![Package Timeline](./img/package_timeline.png)
<!-- .slide: style="color:white; text-align:center;"> -->
Note: We've had package managers for years. Docker allows developers to use the same tools that they're familiar with (apt, yum) to pull in the dependancies they need to run their application. The developer can then publish their Docker file in a registry, and they can store their Dockerfile in a git repository.


### Container: Declaration <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
```sh
FROM alpine:latest
MAINTAINER Brandon B. Jozsa <bjozsa@jinkit.com>

ENV LC_ALL=C \
    CINDER_ENDPOINT_TYPE=internalURL \
    NOVA_ENDPOINT_TYPE=internalURL \
    OS_ENDPOINT_TYPE=internalURL \
    OS_USERNAME=admin \
    OS_PASSWORD=password \
    OS_PROJECT_NAME=admin \
    OS_TENANT_NAME=admin \
    OS_AUTH_URL=http://10.1.1.1:5000/v3 \
    OS_NO_CACHE=1 \
    OS_USER_DOMAIN_NAME=Default \
    OS_PROJECT_DOMAIN_NAME=Default \
    OS_IDENTITY_API_VERSION=3 \
    OS_AUTH_VERSION=3

# Update, Upgrade and Install Prerequisites
RUN apk add --update --no-cache \
    python py-pip git python-dev libffi libffi-dev \
    openssl openssl-dev build-base iputils bash curl linux-headers \
    && rm -rf /var/cache/apk/*

# Install Openstack CLI Tools
RUN pip install python-openstackclient

# Install stack Helper Script. Details: https://github.com/larsks/openstack-tools
RUN curl -sSL https://raw.githubusercontent.com/larsks/openstack-tools/master/stack -o /sbin/stack
RUN chmod 0755 /sbin/stack

# Set the Workdir
RUN mkdir /openstack-rc
WORKDIR /openstack-rc
```
<!-- .slide: style="color:white; text-align:center;"> -->



### Kubernetes Pods <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- Unit of Deployment <!-- .element: class="fragment" data-fragment-index="1" -->
- Resource Sharing and Communication <!-- .element: class="fragment" data-fragment-index="2" -->
<!-- .slide: style="color:white; text-align:left;"> -->
Note: Kubernetes pods are a unit of deployment. They can be a single container or a collection of containers that act as a single application (such as a LAMP stack).


### Pod Examples <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
![Package Timeline](./img/kubernetes_pod.png)
<!-- .slide: style="color:white; text-align:center;"> -->
Note: We've had package managers for years. Docker allows developers to use the same tools that they're familiar with (apt, yum) to pull in the dependancies they need to run their application. The developer can then publish their Docker file in a registry, and they can store their Dockerfile in a git repository.



### Kubernetes RC <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- Ensures that "x" Number of Pods Exist <!-- .element: class="fragment" data-fragment-index="1" -->
- Process Supervisor <!-- .element: class="fragment" data-fragment-index="2" -->
- Allows for Auto Horizontal Pod Scaling <!-- .element: class="fragment" data-fragment-index="3" -->
<!-- .slide: style="color:white; text-align:left;"> -->
Note:


### RC Examples <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
![Package Timeline](./img/kubernetes_rc01.png)
<!-- .slide: style="color:white; text-align:center;"> -->
Note: We've had package managers for years. Docker allows developers to use the same tools that they're familiar with (apt, yum) to pull in the dependancies they need to run their application. The developer can then publish their Docker file in a registry, and they can store their Dockerfile in a git repository.


### RC Examples <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
![Package Timeline](./img/kubernetes_rc02.png)
<!-- .slide: style="color:white; text-align:center;"> -->
Note: We've had package managers for years. Docker allows developers to use the same tools that they're familiar with (apt, yum) to pull in the dependancies they need to run their application. The developer can then publish their Docker file in a registry, and they can store their Dockerfile in a git repository.



### Kubernetes Labels <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- Organization Structure <!-- .element: class="fragment" data-fragment-index="1" -->
- Custom, Meaningful Attributes <!-- .element: class="fragment" data-fragment-index="2" -->
<!-- .slide: style="color:white; text-align:left;"> -->


### Labels Examples <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
![Package Timeline](./img/kubernetes_labels.png)
<!-- .slide: style="color:white; text-align:center;"> -->
Note: We've had package managers for years. Docker allows developers to use the same tools that they're familiar with (apt, yum) to pull in the dependancies they need to run their application. The developer can then publish their Docker file in a registry, and they can store their Dockerfile in a git repository.



### Kubernetes Services <!-- .element: class="title" style="color:black; text-align:left; font-size:2.0em;" -->
- Services are an abstraction of the POD/RC <!-- .element: class="fragment" data-fragment-index="1" -->
- Types Include NodePort or LoadBalancer <!-- .element: class="fragment" data-fragment-index="2" -->
<!-- .slide: style="color:white; text-align:left;"> -->


### Services Examples <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
![Package Timeline](./img/kubernetes_services.png)
<!-- .slide: style="color:white; text-align:center;"> -->




## Labwork <!-- .element: class="title" style="color:black; text-align:center; font-size:2.0em;" -->
(Part II: Exploring Kubernetes)
<!-- .slide: style="color:white; text-align:center;"> -->
