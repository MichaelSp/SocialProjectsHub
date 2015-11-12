namespace :db do
  task backup: :environment do
    Backup::Runner.run!
  end
end