namespace :android do
    task :build => [:clean] do 
        environment = select_environment ENV['env']
        puts "Build for #{environment} environment..."
        
        system "ti build -p android -T device -b #{$ti_option} -D #{environment}"
    end
    
    desc "Execute in Android Emulator"
    task :emulator => [:clean] do 
        environment = select_environment ENV['env']
        puts "Run simulator in #{environment} environment..."
        
        system "ti build -p android -T emulator #{$ti_option} -D #{environment} && adb logcat | egrep ^.\/Ti"
    end
        
    desc "Execute in Android Device, if connected"
    task :device => [:clean] do 
        environment = select_environment ENV['env']
        puts "Run simulator in #{environment} environment..."
        
        system "ti build -p android -T device #{$ti_option} -D #{environment} && adb logcat | egrep ^.\/Ti"
    end
    
    desc "Deploy Android App to Testflight"
    task :testflight => [:build] do
        notes = ENV['notes'] || $tf_android_file
        count = 0
        build_file_path = File.join FileUtils.pwd, "build", "android", "bin", $tf_android_file
        
        android_to_testflight build_file_path, count, "#{notes} - Sent from TiRake"
    end
end
