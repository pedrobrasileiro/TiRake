desc "Clean Project"
task :clean do
    if $call_clean 
        system "ti clean --no-banner"
    end
end

namespace :theme do
    # Do not change this configurations
    task :change, [:old_theme, :new_theme] do |t, args|
        config_file = "app/config.json"
        text = File.read(config_file);
        replace = text.gsub("\"theme\" : \"#{args.old_theme}\"", "\"theme\" : \"#{args.new_theme}\"")
        
        if text != replace
            File.open(config_file, "w") { |file| file.puts replace }
            puts "Changed old theme #{args.old_theme} to new theme #{args.new_theme}"
        else
            puts "Nothing theme change : old=#{args.old_theme} new=#{args.new_theme}"
        end
    end
    
    task :default, [:old_theme] do |t, args|
        Rake::Task["theme:change"].invoke(args.old_theme, $default_theme)
        Rake::Task["theme:change"].reenable
    end
end