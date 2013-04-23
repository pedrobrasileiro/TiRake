desc "Clean Project"
task :clean do
    system "ti clean --no-banner" if $call_clean
end

namespace :theme do
    # Do not change this configurations
    task :change, [:old_theme, :new_theme] do |t, args|
        config_file = "app/config.json"
        text = File.read(config_file);
        replace = text.gsub("\"theme\" : \"#{args.old_theme}\"", "\"theme\" : \"#{args.new_theme}\"")
        
        if text != replace
            File.open(config_file, "w") { |file| file.puts replace }
            puts "Changed old theme #{args.old_theme} to new theme #{args.new_theme}"
        else
            puts "Nothing theme change : old=#{args.old_theme} new=#{args.new_theme}"
        end
    end
    
    task :default, [:old_theme] do |t, args|
        Rake::Task["theme:change"].invoke(args.old_theme, $default_theme)
        Rake::Task["theme:change"].reenable
    end
end

def android_to_testflight file, count, notes
    copy_to_testflight file, count, "android", notes
end

def ios_to_testflight file, count, notes
    copy_to_testflight file, count, "ios", notes
end


def copy_to_testflight file, count, os, notes
    if os.nil? || os.empty?
        puts "OS name required."
        return nil
    end
    
    return nil if count >= 5 
                
    if (!File.exists?(file))
        puts "#{file} do not exist. Trying again in 5 seconds..."
        sleep 5
        count += 1
        copy_to_testflight file, count, os, notes
    elsif File.mtime(file) <= Time.now-60*60 # 1 hours
        puts "File #{file} is very old or iTunes do not copy this file. Trying again in 5 seconds..."
        sleep 5
        count += 1
        copy_to_testflight file, count, os, notes
    else
        # Waiting 5 minutes to copy file
        sleep 5
        
        # Copy file to actual directory
        FileUtils.cp file, "."
        
        # Delete file to generate new
        FileUtils.rm file, force: true
        
        if os == "android"
            tf_file = $tf_android_file
        else # iOS default
            tf_file = $tf_ios_file
        end
        
        puts "Sending #{tf_file} to TestFlight with notes '#{notes}'"
        `curl -F file=@#{tf_file} -F api_token='#{$tf_api_token}' -F team_token='#{$tf_team_token}' -F notes='#{notes}' -F distribution_lists='#{$tf_distribution_lists}' -F notify=True --progress-bar -o tirake_testflight_upload.log http://testflightapp.com/api/builds.json`

        FileUtils.rm tf_file, force: true
    end
end

def select_environment env 
    environment = (env || "development").downcase
        
    if environment.empty?
        puts "Empty environment, setting to development..."
    elsif !environment.eql?("production") && !environment.eql?("test")
        environment = "development"
    end
    
    environment
end

def parse_version string_version
    version = nil

    if (`gem list | grep versionomy`).empty?
         logger.fatal "Please, install gem versionomy with: gem install versionomy"
    else
        puts "Versionomy installed"
        require 'versionomy'

        version = Versionomy.parse(string_version)
    end

    version
end
