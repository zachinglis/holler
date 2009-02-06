require 'fileutils'

namespace :setup do
  desc "Setup the application"
  task :app do
    Rake::Task['setup:database_yml'].invoke
    Rake::Task['setup:generate_site_key'].invoke
  end
  
  desc "Copies database.yml.example to database.yml"
  task :database_yml do
    source = RAILS_ROOT + '/config/database.yml.example'
    destination = RAILS_ROOT + '/config/database.yml'    
    FileUtils.cp source, destination
  end
  
  desc "Generates a random REST_AUTH_SITE_KEY"
  task :generate_site_key do
    range = ("a".."z").to_a + ("A".."Z").to_a
    key_length = 50
    site_key = (0..key_length).collect { range[rand(range.length)] }.join
    source = RAILS_ROOT + '/config/initializers/site_keys.rb.example'
    destination = RAILS_ROOT + '/config/initializers/site_keys.rb'    
    site_keys = File.open(source, 'r').read
    site_keys.gsub!(/your_super_secret_site_key/, site_key)
    File.open(destination, 'w') { |f| f.puts site_keys }
  end
end