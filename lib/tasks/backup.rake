namespace :db do
  desc "Backup the database to a specific folder"
  task backup: :environment do
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    backup_path = "/Users/anthonyamar/Documents/Code/dive-sites-finder-pg-backups"
    backup_file = "#{backup_path}/#{timestamp}_dive_sites_finder_development.sql"

    command = "pg_dump -h localhost dive_sites_finder_development > #{backup_file}"
    `#{command}`

    puts "Backup created at #{backup_file}"
  end
end