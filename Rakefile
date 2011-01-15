require 'rubygems'
require 'rake'
require 'echoe'
require 'rspec/core/rake_task'

Echoe.new('dnsapp', '0.0.1') do |p|
  p.description    = "Gem to interact with DNSapp.net Managed DNS service"
  p.url            = "https://dnsapp.net"
  p.author         = "Morten Møller Riis"
  p.email          = "m _AT_ justabout.it"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = ["httparty"]
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end
