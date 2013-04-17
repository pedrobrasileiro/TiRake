namespace :ios do
    task :build => [:clean] do
        environment = select_environment ENV['env']
        puts "Build for #{environment} environment..."
        
        system "ti build -T device -f -F universal -p ios -V '#{$ios_developer_name}' -P '#{$ios_uuid}' -D #{environment}" 
    end
    
    desc "Execute in iOS Simulator"
    task :simulator => [:clean] do
        environment = select_environment ENV['env']
        puts "Run simulator in #{environment} environment..."
        
        system "ti build -p ios #{$ti_option} -D #{environment}"
    end
    
    desc "Deploy iOS App to Testflight"
    task :testflight => [:build] do
        notes = ENV['notes'] || $tf_ios_file
        
        count = 0
        build_file_path = File.join(ENV['HOME'], "Music", "iTunes", "iTunes Media", "Mobile Applications", $tf_ios_file)
        
        ios_to_testflight build_file_path, count, "#{notes} - Sent: from TiRake"
    end
    
    desc "Deploy iOS App to Device via iTunes"
    task :deploy => [:build] do
    end
end
