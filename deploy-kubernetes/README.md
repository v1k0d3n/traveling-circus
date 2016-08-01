# Main Event

This folder includes the Kubernetes deployment used with the Traveling Circus.

## Main Event: Prerequisites

If you are using this lab for traveling instruction purposes, you should consider deploying the prerequisites first however it's not required if you BYO Openstack environment.

1. First deploy an Openstack environment (included in the `deploy-openstack` folder).
2. Next, make sure to run the `lab` portion of this project to set up the required tenants.

## Main Event: Preparation

These steps are typically performed by the Openstack administrator, or instructor covering Openstack/Kubernetes prior to demonstration or instruction.

The `kube-os-lab-00` project/tenant represents the "instructor" teant. Create a Ubuntu 14.04.x instance with 4GB RAM, 20GB Disk and 1vCPU. This process is not automated yet (see current issues list). Once this tenant has been created, modify the inventory to reflect the instance public IP address and run the following command:

```
./lab-up.sh
```

This will prepare the shared control host for your lab environments. Currently, this is using the [Kubespray Project](https://docs.kubespray.io/#run-deployment). This project may include other deployments for comparision in the future.

## Main Event: Deploy the Kubernetes Labs

Once the control host is ready, the intent is to have others deploy their own Kubernetes environments quickly and interactively. Below are the following steps you will have them perform.

1. Assign users a number (default 01-25). This number corresponds to their Project/Tenant and AdminID. Passwords are assigned during the control host buildout (see above).
2. Log into into Horizon (over TLS/browser) and the control host (SSH/terminal).
3. Use the `changepass.sh` script in the `/home/{{user}}` directory to change API endpoint passwords prior to deployment.
4. Change the the `~/openstack` directory, and source the `openrc` file.
5. Run `deploy-environment.sh` and `deploy-servers.sh`. (See notes in troubleshooting section for issues).
6. Now with the environment prepared, change into the `~/kargo` directory.
7. Run the command `openstack server list` and edit `~/kargo/inventory/inventory.cfg` to match the returned IP addresses.
8. Now run the Kubernetes deployment with the following commands:

  ```
  ansible-playbook -u core -e ansible_ssh_user=core -b --become-user=root -i inventory/inventory.cfg coreos-bootstrap.yml
  ansible-playbook -u core -e ansible_ssh_user=core -b --become-user=root -i inventory/inventory.cfg cluster.yml
  ```

**NOTE:** The control host is deployed with the `screen` command, so you can deploy over slow links. Use `CTL+a`, then `d` to detached and `screen -r` to reconnect.

## Main Event: Presentation

While the CoreOS/Kubernetes clusters are being deployed, continue wtih your presentation (suggested 15+ minutes). Follow up with a detailed review and walkthrough of the Kubernetes environment. Keep in mind that this Kubernetes deployment is containerized (hyperkube).

### When Issues Occur

Occasionally, you're going to have an issue with with one of the labs. When you want to "reset" a problematic lab you can simply use one of the following examples.

**Rebuild:**

```
./lab-repull.sh --tags=lab-control-fetch
```

...more to come...
