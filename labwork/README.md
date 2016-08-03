# Kubernetes on Openstack
Welcome to the Kubernetes on Openstack Training! Below are some steps you will perform to build your own clusters during the walkthrough.

# LAB PART I: Openstack Preparation

First log into the Kubernetes control host using the credentials provided.

```
$ ssh kubeadmin{{xx}}@172.29.248.40
```

Look around, and you will find two directories used throughout the lab.

```
kubeadmin00@kube-control:~$ ls -ls
total 12
4 -rwxrw-rw-  1 kubeadmin00 users  936 Jul 31 21:52 changepass.sh
4 drwxr-xr-x 10 kubeadmin00 users 4096 Aug  3 11:24 kargo
4 drwxr-xr-x  2 kubeadmin00 users 4096 Aug  3 11:26 openstack
kubeadmin00@kube-control:~$
```

Navigate the the `openstack` directory and source the `openrc` file.

```
kubeadmin00@kube-control:~$ source openrc
-bash: openrc: No such file or directory
kubeadmin00@kube-control:~$ cd openstack/
kubeadmin00@kube-control:~/openstack$ source openrc
Please enter your OpenStack Password:
kubeadmin00@kube-control:~/openstack$ openstack image list
+--------------------------------------+---------------------------------+--------+
| ID                                   | Name                            | Status |
+--------------------------------------+---------------------------------+--------+
| 8f738d67-4884-4c2f-bde3-98246ad05c9d | coreos-alpha-1097.0.0           | active |
| 9d61c1d8-e9bb-4174-b1dc-be574dcb1f33 | coreos-beta-1068.3.0            | active |
| 1a4f5b8e-85fc-4abb-977a-9bf805242851 | coreos-stable-1010.6.0          | active |
+--------------------------------------+---------------------------------+--------+
kubeadmin00@kube-control:~/openstack$
```

Run the environment and server setup scripts.

```
kubeadmin00@kube-control:~/openstack$ ./deploy-environment.sh
+--------------------------------------+---------------+-------------------------------+
| Id                                   | Name          | Description                   |
+--------------------------------------+---------------+-------------------------------+
| ba0e2c9d-0717-4e48-8508-363625012ff8 | k8s-sec-group | Kubernetes Lab Security Group |
+--------------------------------------+---------------+-------------------------------+
+-------------+-----------+---------+----------------+--------------+
| IP Protocol | From Port | To Port | IP Range       | Source Group |
+-------------+-----------+---------+----------------+--------------+
| tcp         | 1         | 65535   | 192.168.0.0/16 |              |
+-------------+-----------+---------+----------------+--------------+
+-------------+-----------+---------+-----------------+--------------+
| IP Protocol | From Port | To Port | IP Range        | Source Group |
+-------------+-----------+---------+-----------------+--------------+
| tcp         | 1         | 65535   | 172.29.248.0/22 |              |
+-------------+-----------+---------+-----------------+--------------+
+-------------+-----------+---------+----------------+--------------+
| IP Protocol | From Port | To Port | IP Range       | Source Group |
+-------------+-----------+---------+----------------+--------------+
| icmp        | -1        | -1      | 192.168.0.0/16 |              |
+-------------+-----------+---------+----------------+--------------+
+-------------+-----------+---------+-----------------+--------------+
| IP Protocol | From Port | To Port | IP Range        | Source Group |
+-------------+-----------+---------+-----------------+--------------+
| icmp        | -1        | -1      | 172.29.248.0/22 |              |
+-------------+-----------+---------+-----------------+--------------+
kubeadmin00@kube-control:~/openstack$
kubeadmin00@kube-control:~/openstack$ ./deploy-servers.sh
kubeadmin00@kube-control:~/openstack$
kubeadmin00@kube-control:~/openstack$
+--------------------------------------+------------------------------------------------------------+
| Field                                | Value                                                      |
+--------------------------------------+------------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                     |
| OS-EXT-AZ:availability_zone          | nova                                                       |
| OS-EXT-STS:power_state               | NOSTATE                                                    |
| OS-EXT-STS:task_state                | scheduling                                                 |
| OS-EXT-STS:vm_state                  | building                                                   |
| OS-SRV-USG:launched_at               | None                                                       |
| OS-SRV-USG:terminated_at             | None                                                       |
| accessIPv4                           |                                                            |
| accessIPv6                           |                                                            |
| addresses                            |                                                            |
| adminPass                            | zikqvL7zb87i                                               |
| config_drive                         |                                                            |
| created                              | 2016-08-03T15:23:16Z                                       |
| flavor                               | J4.MAC.2G.20XG (20)                                        |
| hostId                               |                                                            |
| id                                   | e36e8d24-10bd-44cd-851d-3d8d0a0736fc                       |
| image                                | ubuntu-trusty-14.04 (d49581bb-b049-4a81-bb5f-640979a09d39) |
| key_name                             | k8s-pub-key                                                |
| name                                 | kube-node01                                                |
| os-extended-volumes:volumes_attached | []                                                         |
| progress                             | 0                                                          |
| project_id                           | c8255443da8c40769a763413ad0beb22                           |
| properties                           |                                                            |
| security_groups                      | [{u'name': u'k8s-sec-group'}]                              |
| status                               | BUILD                                                      |
| updated                              | 2016-08-03T15:23:16Z                                       |
| user_id                              | 131dc3e2bee14f1ba1410846b1b39924                           |
+--------------------------------------+------------------------------------------------------------+
+--------------------------------------+------------------------------------------------------------+
| Field                                | Value                                                      |
+--------------------------------------+------------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                     |
| OS-EXT-AZ:availability_zone          | nova                                                       |
| OS-EXT-STS:power_state               | NOSTATE                                                    |
| OS-EXT-STS:task_state                | scheduling                                                 |
| OS-EXT-STS:vm_state                  | building                                                   |
| OS-SRV-USG:launched_at               | None                                                       |
| OS-SRV-USG:terminated_at             | None                                                       |
| accessIPv4                           |                                                            |
| accessIPv6                           |                                                            |
| addresses                            |                                                            |
| adminPass                            | vrRtXcS5iTK2                                               |
| config_drive                         |                                                            |
| created                              | 2016-08-03T15:23:18Z                                       |
| flavor                               | J4.MAC.2G.20XG (20)                                        |
| hostId                               |                                                            |
| id                                   | 3ee7ef74-bb47-4c06-ab01-578a14e3b5dc                       |
| image                                | ubuntu-trusty-14.04 (d49581bb-b049-4a81-bb5f-640979a09d39) |
| key_name                             | k8s-pub-key                                                |
| name                                 | kube-node02                                                |
| os-extended-volumes:volumes_attached | []                                                         |
| progress                             | 0                                                          |
| project_id                           | c8255443da8c40769a763413ad0beb22                           |
| properties                           |                                                            |
| security_groups                      | [{u'name': u'k8s-sec-group'}]                              |
| status                               | BUILD                                                      |
| updated                              | 2016-08-03T15:23:18Z                                       |
| user_id                              | 131dc3e2bee14f1ba1410846b1b39924                           |
+--------------------------------------+------------------------------------------------------------+
+--------------------------------------+------------------------------------------------------------+
| Field                                | Value                                                      |
+--------------------------------------+------------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                     |
| OS-EXT-AZ:availability_zone          | nova                                                       |
| OS-EXT-STS:power_state               | NOSTATE                                                    |
| OS-EXT-STS:task_state                | scheduling                                                 |
| OS-EXT-STS:vm_state                  | building                                                   |
| OS-SRV-USG:launched_at               | None                                                       |
| OS-SRV-USG:terminated_at             | None                                                       |
| accessIPv4                           |                                                            |
| accessIPv6                           |                                                            |
| addresses                            |                                                            |
| adminPass                            | UPMCScLSqv7H                                               |
| config_drive                         |                                                            |
| created                              | 2016-08-03T15:23:20Z                                       |
| flavor                               | J4.MAC.2G.20XG (20)                                        |
| hostId                               |                                                            |
| id                                   | 40fc13f5-0697-4c69-bddb-47fcb414d767                       |
| image                                | ubuntu-trusty-14.04 (d49581bb-b049-4a81-bb5f-640979a09d39) |
| key_name                             | k8s-pub-key                                                |
| name                                 | kube-node03                                                |
| os-extended-volumes:volumes_attached | []                                                         |
| progress                             | 0                                                          |
| project_id                           | c8255443da8c40769a763413ad0beb22                           |
| properties                           |                                                            |
| security_groups                      | [{u'name': u'k8s-sec-group'}]                              |
| status                               | BUILD                                                      |
| updated                              | 2016-08-03T15:23:20Z                                       |
| user_id                              | 131dc3e2bee14f1ba1410846b1b39924                           |
+--------------------------------------+------------------------------------------------------------+
```

Use the following command to see your Openstack-deployed instances.

```
kubeadmin00@kube-control:~/openstack$ openstack server list
+--------------------------------------+--------------+--------+----------------------+
| ID                                   | Name         | Status | Networks             |
+--------------------------------------+--------------+--------+----------------------+
| 7eb5aff3-5c3e-4a8d-96da-c67d8fa7bb40 | kube-node03  | ACTIVE | public=172.29.248.93 |
| 52d36c40-3ccc-4203-8a40-83a55f73d3fb | kube-node02  | ACTIVE | public=172.29.248.92 |
| 95dc8a37-f7bf-40bd-af08-c37f008ea1be | kube-node01  | ACTIVE | public=172.29.248.91 |
+--------------------------------------+--------------+--------+----------------------+
kubeadmin00@kube-control:~/openstack$
```

Next, navigate to the `~./kargo directory`, and change the inventory file for your Kubernetes Ansible deployment. Change the first 3 Ansible hosts to match your server list above.

```
kubeadmin00@kube-control:~/kargo$ vi inventory/inventory.cfg
[kube-master]
kube-node01 ansible_ssh_host=172.29.248.91
kube-node02 ansible_ssh_host=172.29.248.92
kube-node03 ansible_ssh_host=172.29.248.93
```

Finally, run the following playbooks to build your Kubernetes cluster.

```
kube-control:~/kargo$ screen
kube-control:~/kargo$ ansible-playbook -u core \
    -e ansible_ssh_user=core -b --become-user=root \
    -i inventory/inventory.cfg coreos-bootstrap.yml

kube-control:~/kargo$ ansible-playbook -u core \
    -e ansible_ssh_user=core -b --become-user=root \
    -i inventory/inventory.cfg cluster.yml
```

# LAB PART II: Exploring Kubernetes

After the Kubernetes overview is complete, the lab will pick up again with a successful deployment.

```
..
..
TASK [kubernetes-apps : manage kubernetes applications] ************************
changed: [kube-node01] => (item={u'variables': {u'cluster_ip': u'10.233.0.3'}, u'namespace': u'kube-system', u'name': u'kube-system/kubedns'})
changed: [kube-node01] => (item={u'namespace': u'kube-system', u'name': u'kube-system/kubernetes-dashboard'})

PLAY RECAP *********************************************************************
kube-node01                : ok=352  changed=83   unreachable=0    failed=0
kube-node02                : ok=330  changed=74   unreachable=0    failed=0
kube-node03                : ok=330  changed=74   unreachable=0    failed=0

kubeadmin00@kube-control:~/kargo$
```

SSH to your first Kubernetes node (in the example above, this is 172.29.248.91). The username is `core`, and your key has already been provided to the cluster.

```
kube-control:~/kargo$ ssh core@172.29.248.91
```

Run your first Kubernetes deployed container in the lab.

```
kubectl run ghost --image=ghost --port=2368
```



Now we're going to explore the pod that we created.

```
core@kube-node01 ~ $ kubectl get pods -o wide
NAME                     READY     STATUS    RESTARTS   AGE       IP              NODE
ghost-2728768143-t0svq   1/1       Running   0          3m        10.233.100.4    kube-node03
core@kube-node01 ~ $
```

Next, let's look deeper at the `ghost` pod.

```
core@kube-node01 ~ $ kubectl describe pod ghost-2728768143-t0svq
Name:		ghost-2728768143-t0svq
Namespace:	default
Node:		kube-node03/172.29.248.93
Start Time:	Wed, 03 Aug 2016 19:57:23 +0000
Labels:		pod-template-hash=2728768143
		run=ghost
Status:		Running
IP:		10.233.100.4
Controllers:	ReplicaSet/ghost-2728768143
Containers:
  ghost:
    Container ID:		docker://1024123e95eb5549a6c456a7f3cc6744ef0c84dd18a34f38e1eb39e685b16c16
    Image:			ghost
    Image ID:			docker://sha256:cbee6050d83ce3feadd9b20eed6106c7ad80762a48681286212cfdbc491ca6cf
    Port:			2368/TCP
    State:			Running
      Started:			Wed, 03 Aug 2016 19:58:02 +0000
    Ready:			True
    Restart Count:		0
    Environment Variables:	<none>
Conditions:
  Type		Status
  Initialized 	True
  Ready 	True
  PodScheduled 	True
Volumes:
  default-token-n32yo:
    Type:	Secret (a volume populated by a Secret)
    SecretName:	default-token-n32yo
QoS Tier:	BestEffort
Events:
  FirstSeen	LastSeen	Count	From			SubobjectPath		Type		Reason		Message
  ---------	--------	-----	----			-------------		--------	------		-------
  4m		4m		1	{default-scheduler }				Normal		Scheduled	Successfully assigned ghost-2728768143-t0svq to kube-node03
  4m		4m		1	{kubelet kube-node03}	spec.containers{ghost}	Normal		Pulling		pulling image "ghost"
  3m		3m		1	{kubelet kube-node03}	spec.containers{ghost}	Normal		Pulled		Successfully pulled image "ghost"
  3m		3m		1	{kubelet kube-node03}	spec.containers{ghost}	Normal		Created		Created container with docker id 1024123e95eb
  3m		3m		1	{kubelet kube-node03}	spec.containers{ghost}	Normal		Started		Started container with docker id 1024123e95eb


core@kube-node01 ~ $
```

What can we learn about this pod? Let's look deeper...

```
core@kube-node01 ~ $ kubectl log ghost-2728768143-t0svq
W0803 20:02:05.156117    4848 cmd.go:258] log is DEPRECATED and will be removed in a future version. Use logs instead.
npm info it worked if it ends with ok
npm info using npm@2.15.8
npm info using node@v4.4.7
npm info prestart ghost@0.9.0
npm info start ghost@0.9.0

> ghost@0.9.0 start /usr/src/ghost
> node index

WARNING: Ghost is attempting to use a direct method to send email.
It is recommended that you explicitly configure an email service.
Help and documentation can be found at http://support.ghost.org/mail.

Migrations: Creating tables...
Migrations: Creating table: posts
Migrations: Creating table: users
Migrations: Creating table: roles
Migrations: Creating table: roles_users
Migrations: Creating table: permissions
Migrations: Creating table: permissions_users
Migrations: Creating table: permissions_roles
Migrations: Creating table: permissions_apps
Migrations: Creating table: settings
Migrations: Creating table: tags
Migrations: Creating table: posts_tags
Migrations: Creating table: apps
Migrations: Creating table: app_settings
Migrations: Creating table: app_fields
Migrations: Creating table: clients
Migrations: Creating table: client_trusted_domains
Migrations: Creating table: accesstokens
Migrations: Creating table: refreshtokens
Migrations: Creating table: subscribers
Migrations: Running fixture populations
Migrations: Creating owner
Ghost is running in development...
Listening on 0.0.0.0:2368
Url configured as: http://localhost:2368
Ctrl+C to shut down
core@kube-node01 ~ $
```

Great, but now what? Let's expose the container so we can actually use it.

```
kubectl expose deployment ghost --type="NodePort"
```

Now let's see the port that this host resides on.

```
core@kube-node01 ~ $ kubectl describe service ghost
Name:			ghost
Namespace:		default
Labels:			run=ghost
Selector:		run=ghost
Type:			NodePort
IP:			10.233.17.236
Port:			<unset>	2368/TCP
NodePort:		<unset>	32111/TCP
Endpoints:		10.233.100.4:2368
Session Affinity:	None
No events.

core@kube-node01 ~ $
```
