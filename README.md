## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![ELK Project Diagram](https://github.com/plottsguitar/ELK-Project/blob/main/Images/ELK%20Project%20Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the filebeat_metricbeat-playbook.yml file may be used to install only certain pieces of it, such as Filebeat.

  - Configure Elk Server playbook: install_elk.yml
  - Configure Web Servers Playbook: playbook1.yml
  - Configure Filebeat/Metricbeat on Web Servers Playbook: filebeat_metricbeat-playbook.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly avalable, in addition to restricting access to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the log files and system metrics/statistics.

The configuration details of each machine may be found below.

| Name     | Function   | IP Address | Operating System |
|----------|------------|------------|------------------|
| Jump Box | Gateway    | 10.0.0.4   | Ubuntu           |
| Web-1    | Web Server | 10.0.0.5   | Ubuntu           |
| Web-2    | Web Server | 10.0.0.6   | Ubuntu           |
| ELK      | ELK Server | 10.1.0.4   | Ubuntu           |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 97.92.94.206

Machines within the network can only be accessed by 10.0.0.4 (this is the private IP address of Jump-Box-Provisioner).

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses                                                     |
|----------|---------------------|--------------------------------------------------------------------------|
| Jump Box | Yes                 | 97.92.94.206 (ssh)                                                       |
| Web-1    | No                  | 10.0.0.4 (ssh)                                                           |
| Web-2    | No                  | 10.0.0.4 (ssh)                                                           |
| ELK      | Yes                 | 97.92.94.206 (port 5601), 10.0.0.4 (ssh), 10.0.0.5 (ssh), 10.0.0.6 (ssh) |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because this ensures that the server can be recreated or scaled if necessary. For instance, if the ELK server is destroyed, it can be recreated with the same configuration within minutes.  It can also ensure that any additional ELK servers that are created are all running with identical configurations/settings.

The playbook implements the following tasks:
- Installs Docker - Required as the ELK image is a docker image.
- Installs Python 3 - Ansible works by running its "modules" as script on the target machine.  Since we want these scripts to be run using Python, we need to install the python language onto our target ELK server.
- Installs Docker PIP (Python) module - Installs the python library for use in docker.
- Installs ELK Docker Container - Installs the docker image that allows us to run ELK on the server.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker PS Output](https://github.com/plottsguitar/ELK-Project/blob/main/Images/docker_ps_output.png)

### Target Machines & Beats

This ELK server is configured to monitor the following machines: 
- 10.0.0.5 (Web-1)
- 10.0.0.6 (Web-2)

We have installed the following Beats on these machines: 
- Filebeats
- Metricbeats

These Beats allow us to collect the following information from each machine:
- Filebeat: This beat allows us to monitor log files and events from the web servers.  This includes events like failed login attempts.
- Metricbeat: This beat allows for monitoring of system metrics from the web servers.  This includes metrics like CPU and memory usage.

### Using the Playbook

In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the install_elk.yml and playbook1.yml files to /etc/ansible/
- Create an /etc/ansible/files directory
- Copy the filebeat_metricbeat-playbook.yml to /etc/ansible/roles/
- Update the hosts file to include your Web and ELK server private IP addresses (10.0.0.5, 10.0.0.6, and 10.1.0.4).  You will need to create a separate hosts group labelled "[elk]" for the ELK server.  Be sure to also specify the python interpreter for each with "ansible_python_interpreter=/usr/bin/python3"
- Run the playbook1.yml playbook to setup the webservers
- Run the install_elk.yml playbook to setup ELK
- Run the filebeat_metricbeat-playbook.yml playbook, and navigate to port 5601 on your ELK server's PUBLIC IP address (http://40.77.60.156:5601/app/kibana) to check that the installation worked as expected.

### Bonus

Below is a list of commands that will need to be run to effectively utilize this setup of ELK.

 - curl (yml files from Github)
 - mkdir /etc/ansible/files
 - nano /etc/ansible/hosts (edit IP addresses for "webservers" and "elk" groups, include ansible_python_interpreter=/ussr/bin/python3 for each IP address)
 - ansible-playbook /etc/ansible/playbook1.yml
 - ansible-playbook /etc/ansible/install_elk.yml
 - ansible-playbook /etc/ansible/filebeat_metricbeat-playbook.yml
 - curl http://10.1.0.4:5601/app/kibana (private IP used to display curl output onto Jump-Box-Provisioner machine)
 - http://40.77.60.156:5601/app/kibana (from web browser)
