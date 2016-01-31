
namespace :backup_to_seafile do


  desc 'Create accountinfo.yml for seafile backup'
  task :config do 
  require './lib/SeafileBackup.rb'  
  seafile_account = SeafileBackup.new
  seafile_account.save_account_details
  end  

  desc 'Backup file to seafile'
  task :backup do 
  require './lib/SeafileBackup.rb'  
  seafile_account = SeafileBackup.new
  seafile_account.load_account_details
  seafile_account.make_backup
  end  


end
