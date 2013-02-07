namespace :ios do
    task :build => [:clean] do
        puts "Build not implemented yet..."
        # system "ti build -T device -f -F universal -p ios -V 'Walter Bertot' -P 'C33CE748-4984-461F-9A2D-B656030CEAD7'" 
    end
    
    desc "Execute in iOS Simulator"
    task :simulator => [:clean] do
        system "ti build -p ios #{$ti_option}"
    end
    
    desc "Deploy iOS App to Testflight"
    task :deploy => [:build] do
        puts "Deploy not implementet yet..."
        # system './testflight_send'
    end
end