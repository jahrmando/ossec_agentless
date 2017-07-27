# ossec_agentless

This recipe will install and configure **OSSEC** (Local mode) and **Postfix** as 
smarthost to send you emails.

Tested with [kitchen.ci](http://kitchen.ci):

- CentOS 7.2
- CentOS 7.3

## Install chef

You need to install chef to run this recipe.

	$ curl -L https://www.opscode.com/chef/install.sh | bash

> Login as __root__ user

## How to deploy the CHEF recipe

Firstly move to **/var** directory and clone the chef project

	$ mkdir -p /var/chef/cookbooks
	$ cd /var/chef/cookbooks
	$ git clone https://github.com/jahrmando/ossec_agentless.git

> You will should have root privilage to clone in **/var** directory

Run ossec_agentless cookbook

	$ chef-solo -o 'recipe[ossec_agentless::default]'

> Before, check the `attributes/default` file to see what attributes to override if needed
