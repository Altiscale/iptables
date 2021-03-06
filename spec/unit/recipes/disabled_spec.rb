require 'spec_helper'

describe 'iptables::disabled' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'installs package iptables' do
    expect(chef_run).to install_package('iptables')
  end

  it 'deletes /etc/iptables.d directory' do
    expect(chef_run).to delete_directory('/etc/iptables.d')
  end

  context 'rhel 7' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'redhat', version: '7.0').converge(described_recipe)
    end

    it 'disables and stops iptables service' do
      expect(chef_run).to disable_service('iptables')
      expect(chef_run).to stop_service('iptables')
    end
  end
end
