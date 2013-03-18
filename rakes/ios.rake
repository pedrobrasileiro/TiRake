namespace :ios do
    task :build => [:clean] do
        system "ti build -T device -f -F universal -p ios -V '#{$ios_developer_name}' -P '#{$ios_uuid}'" 
    end
    
    desc "Execute in iOS Simulator"
    task :simulator => [:clean] do
        environment = (ENV['env'] || "development").downcase
        
        if environment.empty?
            puts "Empty environment, setting to development..."
        elsif !environment.eql?("production") && !environment.eql?("test")
            environment = "development"
        end

        puts "Run simulator in #{environment} environment..."
        system "ti build -p ios #{$ti_option} -D #{environment}"
    end
    
    desc "Deploy iOS App to Testflight"
    task :testflight => [:build] do
        notes = ENV['notes'] || $tf_ios_file
        count = 0
        build_file_path = File.join(ENV['HOME'], "Music", "iTunes", "iTunes Media", "Mobile Applications", $tf_ios_file)
        
        ios_to_testflight build_file_path, count, "#{notes} - Send from TiRake"
    end
    
    desc "Deploy iOS App to Device via iTunes"
    task :deploy => [:build] do
    end
end