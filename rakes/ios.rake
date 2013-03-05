namespace :ios do
    task :build => [:clean] do
        system "ti build -T device -f -b -F universal -p ios -V '#{$ios_developer_name}' -P '#{$ios_uuid}'" 
    end
    
    desc "Execute in iOS Simulator"
    task :simulator => [:clean] do
        system "ti build -p ios #{$ti_option}"
    end
    
    desc "Deploy iOS App to Testflight"
    task :deploy => [:build] do
        notes = `git log --pretty=oneline --abbrev-commit -n 5`
        $tf_notes = "5 ultimos logs - :\n#{notes}"
        
        file_path = File.join(ENV['HOME'], "Music", "iTunes", "iTunes Media", "Mobile Applications", $tf_file)
        
        unless (File.exists?(file_path))
            puts "#{file_path} do not exists."
        else 
            # Copy file to actual directory
            `cp #{file_path} .`

            puts "Sending #{$tf_file} to TestFlight.."
            `curl -F file=@#{$tf_file} -F api_token='#{$tf_api_token}' -F team_token='#{$tf_team_token}' -F notes='#{$tf_notes}' -F distribution_lists='#{$tf_distribution_lists}' -F notify=True --progress-bar -o tirake_testflight_upload.log http://testflightapp.com/api/builds.json`
        end
    end
end