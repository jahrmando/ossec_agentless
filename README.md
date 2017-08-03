# ossec_agentless

TODO: This recipe will install and configure **OSSEC** (Local mode) and
**Postfix** as smarthost to send you emails.

- Only tested on Centos 7.x and RHEL
- Fully tested on SELinux. ___Your welcome ;)___
- Postfix Smarthost only tested on ___GoogleGmail___ accounts

## Install chef

You need to install chef to run this recipe.

	$ curl -L https://www.opscode.com/chef/install.sh | bash

> Login as __root__ user

## How to deploy the CHEF recipe

Firstly move to **/var** directory and clone the chef project

	$ mkdir -p /var/chef/cookbooks
	$ cd /var/chef/cookbooks
	$ git clone https://github.com/jahrmando/ossec_agentless.git

> You will should have root privilege to clone in **/var** directory

Run ossec_agentless cookbook

	$ chef-solo -o 'recipe[ossec_agentless::default]'

> Before, check the `attributes/default` file to see what attributes to override if needed

Atributes:

	default['ossec']['email_to'] = 'myemail@gmail.com'
	default['ossec']['email_alerts'] = ['myemail@gmail.com']
	default['ossec']['smtp_server'] = 'localhost'
	default['ossec']['email_from'] = 'my-no-reply-email@gmail.com'

	default['postfix']['gmail_account'] = 'my-no-reply-email@gmail.com'
	default['postfix']['gmail_password'] = 'Sup3rP@ssW0rd'

	default['ossec']['white_list'] = ['192.168.1.1', '192.168.10.0/24']
	default['ossec']['directories_to_check'] = ['/etc/other/conf']

# Test with Kitchen

Yep, You can test it with [kitchen](http://kitchen.ci/).

	$ kitchen test default-centos-73

Tested on:

- CentOS 7.2
- CentOS 7.3
