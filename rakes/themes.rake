themes = (Dir.glob("app/themes/*/").collect{|path| File.basename(path)}).reject{|dir| dir == "CVS" || dir == $default_theme}

themes.each do |theme_name|
    namespace theme_name do
        task :set do
            puts "Change theme to #{theme_name}"
            Rake::Task["theme:change"].invoke($default_theme, theme_name)
            Rake::Task["theme:change"].reenable
        end
        
        task :unset do
            puts "Back the to default theme: #{$default_theme}, old: #{theme_name}"
            Rake::Task["theme:default"].invoke(theme_name, $default_theme)
        end
        
        namespace :ios do
            desc "Execute in iOS Simulator with #{theme_name} Theme"
            task :simulator => ["#{theme_name}:set"] do
                Rake::Task["ios:simulator"].invoke
                Rake::Task["#{theme_name}:unset"].invoke
            end
        end
       
        namespace :android do
            desc "Execute in Android Emulator with #{theme_name} Theme"
            task :emulator => ["#{theme_name}:set"] do 
                Rake::Task["android:emulator"].invoke
                Rake::Task["#{theme_name}:unset"].invoke
            end
        end
    end
end