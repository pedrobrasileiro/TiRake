namespace :all do
  desc "Send to UberTesters all devices (iOS and Android)"
  task :ubertesters do
    puts "Sending Android App..."
    Rake::Task["android:ubertesters"].invoke
    Rake::Task["android:ubertesters"].reenable
        
    puts "Sending iOS App..."
    Rake::Task["ios:ubertesters"].invoke
    Rake::Task["ios:ubertesters"].reenable
  end
end