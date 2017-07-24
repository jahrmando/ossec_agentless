#
# Cookbook:: ossec_agentless
# Recipe:: postfix
#
# Copyright:: 2017, Armando Uch, All Rights Reserved.

email = "#{node['postfix']['gmail_account']}"
password = "#{node['postfix']['gmail_password']}"

package %w(postfix mailx cyrus-sasl cyrus-sasl-plain)

bash 'config postfix as SMARTHOST' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
	echo "Configurando correo.."
	echo "smtp.gmail.com  #{email}:#{password}" > /etc/postfix/sasl_passwd && \
	postmap /etc/postfix/sasl_passwd && \
	echo "###################" >> /etc/postfix/main.cf && \
	echo "# SMARTHOST GMAIL #" >> /etc/postfix/main.cf && \
	echo "###################" >> /etc/postfix/main.cf && \
	echo "relayhost = [smtp.gmail.com]:587" >> /etc/postfix/main.cf && \
	echo "smtp_use_tls = yes" >> /etc/postfix/main.cf && \
	echo "smtp_sasl_auth_enable = yes" >> /etc/postfix/main.cf && \
	echo "smtp_sasl_security_options = noanonymous" >> /etc/postfix/main.cf && \
	echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" >> /etc/postfix/main.cf && \
	echo "smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt" >> /etc/postfix/main.cf
  EOH
  not_if { ::File.exist?('/etc/postfix/sasl_passwd') }
end

service 'postfix' do
  action [:restart]
end

bash 'testmail' do
  user 'root'
  cwd '/tmp'
  environment 'EMAIL' => "#{node['ossec']['email_to']}"
  code <<-EOH
  echo "Hello world!" | mail -s "Prueba de correo" $EMAIL
  EOH
  only_if { ::File.exist?('/etc/postfix/sasl_passwd') }
end
