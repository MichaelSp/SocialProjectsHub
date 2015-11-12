class Backup::Runner

  def self.run!
    Backup::Logger.configure do
      console.quiet = false
    end
    Backup::Logger.start!
    Backup::DbBackup.model.perform!
  end
end