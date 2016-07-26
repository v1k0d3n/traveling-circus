# Introduction to the OSAD Deployment Preparation Guide

These set of playbooks simplify (in an opinionated way), the deployment of the [Openstack-Ansible](https://github.com/openstack/openstack-ansible) for what I call "The Traveling Circus".

## The Traveling Circus: Hardware Requirements

The Traveling Circus can be modified, however this is an extremely powerful setup with a very small footprint: perfect for traveling deomstrations and labs.

The Traveling Circus consists of the following hardware (which can be modfied to your liking, where needed):

1. 1 x Mobile Phone w/USB Charging Cable (for hotspot connectivity)
2. 1 x [Raspberry Pi (Gen 3 Model B)](http://amzn.to/29QOIuq)
3. 1 x [SanDisk Ultra 32GB microSDHC: SDSQUNC-032G-GN6MA](http://amzn.to/29Pfnc1)
4. 1 x [Pack of 3 (1 to 2 required) 1' USB to MicroUSB Connectors](http://amzn.to/29KUJeA)
5. 1 x [NetGear ProSAFE Plus 8-Port Gb Switch](http://amzn.to/29Yajka)
6. 5 x [Intel NUC NUC6I7KYK](http://amzn.to/29Pf8NW)
7. 5 x [Samsung 950 PRO Series: 512GB PCIe NVMe M.2 Internal SSD](http://amzn.to/2aiHEoH)
8. 5 x [Crucial 32GB Kit (16GBx2) DDR4 2133 (PC4-17000): CT2K16G4SFD8213](http://amzn.to/29Pfd4r)
9. 1 x [Sonicwall TZ-215W Wireless Firewall/Router: 01-SSC-4984](http://amzn.to/29Ybeki)
10. 5 x [Anker 10/100/1000 USB 3.0 to RJ-45 Ethernet Adapter](http://amzn.to/29Pg0Cl)
11. 1 Pack (5 Total) [Ethernet Cables - Blue](http://amzn.to/29QQJH1)
12. 1 Pack (5 Total) [Ethernet Cables - Green](http://amzn.to/29QReRC)
13. 1 Pack (5 Total, 2 Required) [Ethernet Cables - Orange](http://amzn.to/29Kohmr)
14. 1 [Electrical Surge Protector (7+ ports)](http://amzn.to/29MmOiM)

## The Traveling Circus: Getting Started

You will want to get started in the `deploy-openstack` folder, where you will find a set of Ansible playbooks which will prepare your host for an OSAD. The current version of OSAD is: ##############.

### Getting Started: Assumptions

The only assumption made is that you have the following requirements:

1. Default build of Ubuntu Server 14.04.x
2. Volume Groups are required. Use guided LVM partitioning for your deployment (default).
3. OpenSSH services need to be installed and running on your hosts.
4. You must have a user installed on the system who can `sudo` and elevate to `root` as needed (default).

**NOTE:** The `deploy-openstack` project will change modify the IP addresses of each of your inventory hosts (look in the included `inventory.yml` file.). My examples below will start with the following hostnames and corresponding DHCP IP addresses (which can be modified afterwards):

```
os-node01     ansible_ssh_host=192.168.3.135
os-node02     ansible_ssh_host=192.168.3.185
os-node03     ansible_ssh_host=192.168.3.196
os-node04     ansible_ssh_host=192.168.3.178
os-node05     ansible_ssh_host=192.168.3.106
```

The default domain for the deployment is `kubelab.io`.

### Getting Started: Order of Operations

Below are the following ordered steps that the Ansible playbooks will follow (listed in the `osad-install.yml` file):

Order | Playbook         | Group  | Gather Facts | Remote User      | Root Required | Details
----- | ---------------- | ------ | ------------ | ---------------- | ------------- | -------
1.    | hosts-hostname   | all    | true         | {{ansible_user}} | true          | Enabled
2.    | hosts-groups     | all    | true         | {{ansible_user}} | true          | Enabled
3.    | hosts-users      | deploy | true         | {{ansible_user}} | true          | Enabled
4.    | hosts-tools      | target | true         | {{ansible_user}} | true          | Enabled
5.    | hosts-keys       | deploy | true         | {{ansible_user}} | true          | Enabled
6.    | hosts-apt        | all    | true         | {{ansible_user}} | true          | Enabled
7.    | hosts-timezone   | deploy | true         | {{ansible_user}} | true          | Enabled
8.    | hosts-modules    | deploy | true         | {{ansible_user}} | true          | Enabled
9.    | hosts-networking | deploy | true         | {{ansible_user}} | true          | Enabled
10.   | hosts-routes     | deploy | true         | {{ansible_user}} | true          | Future
11.   | hosts-key-deploy | deploy | true         | {{ansible_user}} | true          | Future
12.   | hosts-reboot     | deploy | true         | {{ansible_user}} | true          | Enabled

This basically removes a large preparation process required by the OSAD project (shown below):

- Prepare Deployment Host
- Prepare Target Host(s)
- Partial Configure Deployment (See Notes)

<br>
![OSAD Deployment Cycle](images/workflow-foundationplaybooks.png)<br>

**NOTE:** The Traveling Circus prepares a base deployment of the OSAD. If you need modifications to this base, please either send a pull request (please squash all commits) and or make your own required modifications. I will try to make the project modular, but I am still learning deeper aspects of Ansible myself. I will try my best to make this useable by _most_.

### Getting Started: Preparations

There are still some requirements nessisary in order to be successful with this deployment. Know thy environment! Look over the variables used in both the `group_vars` and `host_vars` directories. You will also want to ensure that your ssh public keys are loaded correctly in the `includes/ssh_keys` directory.

1. Clone this repository: `git clone http://github.com/v1k0d3n/kube-on-os && cd kube-on-os`
2. Modify the inventory file to match your hosts (prior to network changes). This file is `inventory.yml`
3. Copy the examples files into their correct directories:

  ```
  you@yourmachine: # cp host_vars/example/example-o1.yml host_vars/servername01.yml # create one for each server in your cluster
  ```

4. Next place your public ssh key into the `includes/ssh_keys` directory.

  ```
  you@yourmachine: # cat ~/.ssh/id_rsa.pub >> includes/ssh_keys/yourusername
  ```

5. Modify the contents of `group_vars` and servers included in `host_vars` to match your environment.

6. Run the playbooks against your environment.

  ```
  you@yourmachine: # ./osad-install.sh -K
  ```

7. Reboot your environment manually after checking your networking configuration (this is obviously a dramatic change), or if you are so-inclined you can have the playbooks reboot your enviroment for you by issuing the following boolean tag: `./osad-install.sh -K -e os_reboot=true`

#### Preparations: Helpful Suggestions

The playbooks are heavily tagged, and can be limited according to your needs. I will document this section more heavily later.

## Main Event: Deploy Openstack-Ansible

1. First, check the syntax in your configuration files. If you've followed all instructions, this _should_ be successful.

  ```
  root@os-node01: # cd /opt/openstack-ansible/playbooks
  root@os-node01: # openstack-ansible setup-infrastructure.yml --syntax-check
  ```

2. If that is successful, than go back to the root openstack-ansible directory and bootstrap ansible.

  ```
  root@os-node01: # cd /opt/openstack-ansible/
  root@os-node01: # scripts/bootstrap-ansible.sh
  ```

3. Move into the /opt/openstack-ansible/playbooks directory for the rest of your work, and run the setup-hosts.yml playbook.

  ```
  root@os-node01: # cd /opt/openstack-ansible/playbooks
  root@os-node01: # openstack-ansible setup-hosts.yml
  ```

4. _Optional:_ The HAPoxy playbooks should have been pulled in during the bootstrap-ansible run, but if you need to pull them in manually you can do the following.

  ```
  root@os-node01: # ansible-galaxy install -r ../ansible-role-requirements.yml
  ```

5. Deploy HAProxy using the following playbook.

  ```
  root@os-node01: # openstack-ansible haproxy-install.yml
  ```

6. Setup the infrastructure (in this case, the LXC containers).

  ```
  root@os-node01: # openstack-ansible setup-infrastructure.yml
  ```

7. _Optional:_ At this point you may want to ensure that the Galera Database is working correctly with the following command.

  ```
  root@os-node01: # ansible galera_container -m shell -a "mysql \
  -h localhost -e 'show status like \"%wsrep_cluster_%\";'"
  ```

8. Run your final playbook to install and configure your Openstack deployment with the following command.

  ```
  root@os-node01: # openstack-ansible setup-openstack.yml
  ```

## Step right up, step right up (because there's more work to be done)

1. Stat and Copy the contents of /opt/openstack-ansible/etc/openstack_deploy to /etc/openstack_deploy for first time installations.
2. Run the scripts/bootstrap-ansible.sh script to prepare the installation (when running remotely).
3. Copy contents of a working openstack_user_config.yml and user_variables.yml to /etc/openstack_deploy. 4.
