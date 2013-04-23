namespace :ios do
    task :build => [:clean] do
        environment = select_environment ENV['env']
        puts "Build for #{environment} environment..."
        
        system "ti build -T device -f -F universal -p ios -V '#{$ios_developer_name}' -P '#{$ios_uuid}' -D #{environment}" 
    end
    
    desc "Execute in iOS Simulator"
    task :simulator => [:clean] do
        environment = select_environment ENV['env']
        v = parse_version((`ti -v`).strip) 

        if (v.major >= 3 && v.minor >= 1)
            # Setting default simulator
            if $default_simulator == "non_retina"
                retina = false
                iphone5 = false
            elsif $default_simulator == "iphone5"
                retina = false
                iphone5 = true
            else
                retina = true
                iphone5 = false
            end

            retina = ENV['retina'] || true
            iphone5 = ENV['iphone5'] || false
            
            if iphone5
                $ti_option = "#{$ti_option} --retina --tall"
            elsif retina
                $ti_option = "#{$ti_option} --retina"
            end
        end

        puts "Run simulator in #{environment} environment with #{v.to_s} sdk version..."

        command = "ti build -p ios #{$ti_option} -D #{environment}"

        puts "Command: #{command}"

        system command
    end
    
    desc "Deploy iOS App to Testflight"
    task :testflight => [:build] do
        notes = ENV['notes'] || $tf_ios_file
        
        count = 0
        build_file_path = File.join(ENV['HOME'], "Music", "iTunes", "iTunes Media", "Mobile Applications", $tf_ios_file)
        
        ios_to_testflight build_file_path, count, "#{notes} - Sent from TiRake"
    end
    
    desc "Deploy iOS App to Device via iTunes"
    task :deploy => [:build] do
    end
end
