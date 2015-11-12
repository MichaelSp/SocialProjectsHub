# encoding: utf-8

##
# Backup Generated: db_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t db_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
module Backup::DbBackup
  def self.model
    Backup::Model.new(:db_backup, 'Backup the rails DB') do
      ##
      # PostgreSQL [Database]
      #
      database Backup::Database::PostgreSQL do |db|
        # To dump all databases, set `db.name = :all` (or leave blank)
        config = YAML.load(ERB.new(File.read("#{Rails.root}/config/database.yml")).result)[Rails.env]

        # To dump all databases,
        db.name = config['database']
        db.username = config['username']
        db.password = config['password']
        db.host = config['host']
        db.port = config['port']
        #db.socket             = "/tmp/pg.sock"
        #db.skip_tables        = ["skip", "these", "tables"]
        #db.only_tables        = ["only", "these", "tables"]
        db.additional_options = ["-xc", "-E=utf8"]
      end

      ##
      # Local (Copy) [Storage]
      #
      store_with Backup::Storage::Local do |local|
        local.path = "#{Rails.root}/tmp/uploads"
        #local.keep       = 5
        local.keep = Time.now - 1.month
      end

      ##
      # Gzip [Compressor]
      #
      compress_with Backup::Compressor::Gzip

    end
  end
end
