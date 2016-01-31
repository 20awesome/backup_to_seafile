require "yaml"
require 'seafile-api'
require 'time'

      $gem_name='backup_to_seafile'
      $path = ENV["GEM_HOME"]
      $version= Gem.loaded_specs[$gem_name].version
      $config_file = "#$path/gems/#$gem_name-#$version/lib/accountinfo.yml"
class SeafileBackup
    def initialize
      @your_account = []
      load_account_details
    end

    def load_account_details
      unless File.exists?("#$config_file")
        File.new("#$config_file", "w+")
      end
      @your_account = YAML.load_file("#$config_file")
      #puts @your_account
    end


    def read_config
      config = YAML.load_file("#$config_file")
      @user_name = config["user_name"]
      @password = config["password"]
      @host = config["host"]
      @default_repo = config["default_repo"]
      #convert str to array
      @path_to_upload = config["path_to_upload"].split(",")
      #puts @path_to_upload
      #puts @path_to_upload.class
    end

    def save_account_details
      puts "Enter seafile username, please "
      print "for example - mister_jones@company.com : "
      user_name = $stdin.gets.chomp

      puts "Enter seafile password, please "
      print "for example - password123 :" 
      password = $stdin.gets.chomp

      puts "Enter seafile host, please "
      print "for example - http://seafile.company.com :"
      host = $stdin.gets.chomp

      puts "Enter seafile default repo id, please "
      print "for example - 472f5c4a-70a1-4b52-83f9-9d15ec842150 :"
      default_repo = $stdin.gets.chomp

      puts "Enter local path(s) or file(s), please "
      print 'for example - /var/log,/home/deployer/database.sql :'
      path_to_upload = $stdin.gets.chomp

      d = YAML::load_file("#$config_file") #Load
      d['user_name']= user_name
      d['password']= password
      d['host']= host
      d['default_repo'] = default_repo
      d['path_to_upload'] = path_to_upload
      File.open("#$config_file", 'w') {|f| f.write d.to_yaml } #Store
    end

    def make_backup
      read_config
      time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      sf = SeafileApi::Connect.new(@user_name,@password,@host,@default_repo)

      @path_to_upload.each do |path_to_upload|
        if File.directory?(path_to_upload)
          `tar -czf #{path_to_upload}.#{time}.tar.gz #{path_to_upload}`
          sf.upload_file("#{path_to_upload}.#{time}.tar.gz",path="/",@default_repo)
          
        else
          sf.upload_file(path_to_upload,path="/",@default_repo)
        end
      end

    end
end
#seafile_account = SeafileBackup.new
#seafile_account.save_account_details
#seafile_account.load_account_details
#seafile_account.make_backup

