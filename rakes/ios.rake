namespace :ios do
    task :build => [:clean] do
        system "ti build -T device -f -F universal -p ios -V '#{$ios_developer_name}' -P '#{$ios_uuid}'" 
    end
    
    desc "Execute in iOS Simulator"
    task :simulator => [:clean] do
        system "ti build -p ios #{$ti_option}"
    end
    
    desc "Deploy iOS App to Testflight"
    task :deploy => [:build] do
        count = 0
        file_path = File.join(ENV['HOME'], "Music", "iTunes", "iTunes Media", "Mobile Applications", $tf_file)
        copy_to_testflight file_path, count
    end
end

def copy_to_testflight file, count
    return nil if count >= 5 
    
    unless (`git --version`).nil?
        notes = `git log --pretty=oneline --abbrev-commit -n 5`
        $tf_notes = "5 ultimos logs - :\n#{notes}"
    else
        $tf_notes = "Send by TiRake."
    end
            
    if (!File.exists?(file))
        puts "#{file} do not exist. Trying again in 5 seconds..."
        sleep 5
        count += 1
        copy_to_testflight file, count
    elsif File.mtime(file) <= Time.now-60*60 # 1 hours
        puts "File #{file} is very old or iTunes do not copy this file. Trying again in 5 seconds..."
        sleep 5
        count += 1
        copy_to_testflight file, count
    else
        # Copy file to actual directory
        FileUtils.cp file, "."

        puts "Sending #{$tf_file} to TestFlight.."
        `curl -F file=@#{$tf_file} -F api_token='#{$tf_api_token}' -F team_token='#{$tf_team_token}' -F notes='#{$tf_notes}' -F distribution_lists='#{$tf_distribution_lists}' -F notify=True --progress-bar -o tirake_testflight_upload.log http://testflightapp.com/api/builds.json`

        FileUtils.rm $tf_file, force: true
    end
end