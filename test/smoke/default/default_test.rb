# # encoding: utf-8

# Inspec test for recipe ossec_agentless::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('postfix') do
  it { should be_installed }
end

describe package('mailx') do
  it { should be_installed }
end

describe package('cyrus-sasl') do
  it { should be_installed }
end

describe package('cyrus-sasl-plain') do
  it { should be_installed }
end

describe package('ossec-hids') do
  it { should be_installed }
end

describe package('ossec-hids-server') do
  it { should be_installed }
end
