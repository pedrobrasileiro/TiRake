namespace :all do
    desc "Send to Testflight all devices (iOS and Android)"
    task :testflight do
        puts "Sending Android App..."
        Rake::Task["android:testflight"].invoke
        Rake::Task["android:testflight"].reenable
        
        puts "Sending iOS App..."
        Rake::Task["ios:testflight"].invoke
        Rake::Task["ios:testflight"].reenable
    end
end