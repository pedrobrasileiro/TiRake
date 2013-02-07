namespace :android do
    task :build => [:clean] do 
        system "ti build -p android -b #{$ti_option}"
    end
    
    desc "Execute in Android Emulator"
    task :emulator => [:clean] do 
        system "ti build -p android -T emulator #{$ti_option}"
    end
        
    desc "Execute in Android Device, if connected"
    task :device => [:clean] do 
        system "ti build -p android -T device #{$ti_option}"
    end
    
    desc "Deploy Android App to Dropbox"
    task :deploy => [:build] do
        puts "Not implemented yet..."
    end 
end