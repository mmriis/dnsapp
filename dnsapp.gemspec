# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dnsapp}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Morten M\303\270ller Riis"]
  s.cert_chain = ["/Users/mmr/gem-public_cert.pem"]
  s.date = %q{2011-01-15}
  s.description = %q{Gem to interact with DNSapp.net Managed DNS service}
  s.email = %q{m _AT_ justabout.it}
  s.extra_rdoc_files = ["README.rdoc", "lib/dnsapp.rb", "lib/dnsapp/auth_check_parser.rb", "lib/dnsapp/credentials.rb", "lib/dnsapp/domain.rb", "lib/dnsapp/object.rb", "lib/dnsapp/record.rb"]
  s.files = ["Manifest", "README.rdoc", "Rakefile", "dnsapp.gemspec", "lib/dnsapp.rb", "lib/dnsapp/auth_check_parser.rb", "lib/dnsapp/credentials.rb", "lib/dnsapp/domain.rb", "lib/dnsapp/object.rb", "lib/dnsapp/record.rb", "spec/domain_spec.rb", "spec/record_spec.rb"]
  s.homepage = %q{http://github.com/mmriis/dnsapp}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Dnsapp", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{dnsapp}
  s.rubygems_version = %q{1.3.7}
  s.signing_key = %q{/Users/mmr/gem-private_key.pem}
  s.summary = %q{Gem to interact with DNSapp.net Managed DNS service}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<httparty>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
  end
end
