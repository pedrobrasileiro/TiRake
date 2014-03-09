namespace :android do
  task :build => [:clean] do 
    environment = select_environment ENV['env']
    puts "Build for #{environment} environment..."
    
    command = "ti build -p android -T device -b #{$ti_option} -D #{environment}"
    puts "Command : #{command}"
    system command
  end
    
  desc "Execute in Android Emulator"
  task :emulator => [:clean] do 
    environment = select_environment ENV['env']
    puts "Run simulator in #{environment} environment..."
    
    log = get_log_android
    if (log.nil?)
      log = ""
    else
      log = " && #{log}"
    end
    
    command = "ti build -p android -T emulator #{$ti_option} -D #{environment} #{log}"
    puts "Command : #{command}"
    system command
  end
        
  desc "Execute in Android Device, if connected"
  task :device => [:clean] do 
    environment = select_environment ENV['env']
    puts "Run simulator in #{environment} environment..."
    
    log = get_log_android
    if (log.nil?)
      log = ""
    else
      log = " && #{log}"
    end
    
    command = "ti build -p android -T device #{$ti_option} -D #{environment} #{log}"
    puts "Command : #{command}"
    system command
  end
    
  desc "Deploy Android App to Testflight"
  task :testflight => [:build] do
    notes = ENV['notes'] || $tf_android_file
    count = 0
    build_file_path = File.join FileUtils.pwd, "build", "android", "bin", $tf_android_file
        
    android_to_testflight build_file_path, count, "#{notes} - Sent from TiRake"
  end
  
  desc "Deploy Android App to UberTesters"
  task :ubertesters => [:build] do
    notes = ENV['notes'] || $tf_android_file
    count = 0
    build_file_path = File.join FileUtils.pwd, "build", "android", "bin", $tf_android_file
        
    android_to_ubertesters build_file_path, count, "#{notes} - Sent from TiRake"
  end
    
  desc "Install app on Genymotion Emulator"
  task :genymotion => [:build] do
    build_file_path = File.join FileUtils.pwd, "build", "android", "bin", $tf_android_file
    
    log = get_log_android
    if (log.nil?)
      log = ""
    else
      log = " && #{log}"
    end
    
    command = "adb install -r #{build_file_path} #{log}"
    puts "Command : #{command}"
    system command
  end
end
