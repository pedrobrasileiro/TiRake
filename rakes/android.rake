namespace :android do
    task :build => [:clean] do 
        system "ti build -p android -T emulator -b #{$ti_option}"
    end
    
    desc "Execute in Android Emulator"
    task :emulator => [:clean] do 
        system "ti build -p android -T emulator #{$ti_option}"
    end
        
    desc "Execute in Android Device, if connected"
    task :device => [:clean] do 
        system "ti build -p android -T device #{$ti_option}"
    end
    
    desc "Deploy Android App to Testflight"
    task :testflight => [:build] do
        count = 0
        build_file_path = File.join FileUtils.pwd, "build", "android", "bin", $tf_android_file
        android_to_testfligth build_file_path, count
    end
end