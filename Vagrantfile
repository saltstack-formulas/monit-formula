# -*- mode: ruby -*-
# vi: set ft=ruby :
$script = <<SCRIPT
test -d /srv/pillar || mkdir /srv/pillar
test -f /tmp/travis/top.sls && cp /{tmp/travis,srv/salt}/top.sls
cp {/tmp/travis,/srv/salt}/top.sls
cp /tmp/travis/top_pillar.sls /srv/pillar/top.sls
ln -s /srv/salt/pillar.example /srv/pillar/monit.sls
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.provider 'virtualbox' do |v|
    v.linked_clone = true if Vagrant::VERSION =~ /^1.8/
  end

  config.vm.define "monit" do |monit|
    monit.vm.box = "ubuntu/xenial64"
    
    monit.vm.synced_folder ".", "/vagrant", disabled: true
    monit.vm.synced_folder ".", "/srv/salt"
    monit.vm.synced_folder ".travis", "/tmp/travis"

    monit.vm.provision "shell", inline: $script
    monit.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = ".travis/minion"
      salt.run_highstate = false
      salt.colorize = true
      salt.verbose = true
      salt.log_level = "warning" 
    end
  end
end
