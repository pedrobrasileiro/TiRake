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
        puts "Sending #{$tf_file} to TestFlight.."
        notes = `git log --pretty=oneline --abbrev-commit -n 5`
        $tf_notes = "5 ultimos logs - :\n#{notes}"
        
        # Copy file to actual directory
        `cp "#{ENV['HOME']}/Music/iTunes/iTunes Media/Mobile Applications/#{$tf_file}" .`

        `curl -F file=@#{$tf_file} -F api_token='#{$tf_api_token}' -F team_token='#{$tf_team_token}' -F notes='#{$tf_notes}' -F distribution_lists='#{$tf_distribution_lists}' -F notify=True --progress-bar -o tirake_testflight_upload.log http://testflightapp.com/api/builds.json`
        
        #`cat tirake_testflight_upload.log`
        #`rm - rf #{$tf_file} tirake_testflight_upload.log`
    end
end