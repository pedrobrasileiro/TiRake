namespace :ios do
    task :build => [:clean] do
        system "ti build -T device -f -F universal -p ios -V '#{$ios_developer_name}' -P '#{$ios_uuid}'" 
    end
    
    desc "Execute in iOS Simulator"
    task :simulator => [:clean] do
        system "ti build -p ios #{$ti_option}"
    end
    
    desc "Deploy iOS App to Testflight"
    task :testflight => [:build] do
        count = 0
        build_file_path = File.join(ENV['HOME'], "Music", "iTunes", "iTunes Media", "Mobile Applications", $tf_ios_file)
        ios_to_testfligth build_file_path, count
    end
    
    desc "Deploy iOS App to Device via iTunes"
    task :deploy => [:build] do
    end
end