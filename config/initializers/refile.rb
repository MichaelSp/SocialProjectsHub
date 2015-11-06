
Refile.store ||= Refile::Backend::FileSystem.new(Rails.root.join("uploads/store").to_s)
Refile.cache ||= Refile::Backend::FileSystem.new(Rails.root.join("uploads/cache").to_s)
