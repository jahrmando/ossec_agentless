# ossec_agentless

This recipe will install and configure **OSSEC** (Local mode) and **Postfix** (smarthost).

Tested in:

- CentOS 7.2
- CentOS 7.3

## Install chef

You need to install chef to run this recipe. Login as ROOT user

	$ curl -L https://www.opscode.com/chef/install.sh | bash

## How to deploy the CHEF recipe

Firstly move to **/var** directory and clone the chef project

	$ cd /var/
	$ git clone git@github.com:Chucheen/chef_homie.git chef

> You will should have root privilage to clone in **/var** directory

Run ossec_agentless cookbook

	$ chef-solo -o 'recipe[ossec_agentless::default]'

> Before, check the `attributes/default` file to see what attributes to override if needed
