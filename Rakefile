require 'yaml'
path_config_file = Dir.glob("**/config.yml").first 

if (path_config_file.nil? || path_config_file.empty?)
    # try load in symbolic dirs
    path_config_file = Dir.glob("**/*/**/config.yml").first
end

if (path_config_file.nil? || path_config_file.empty?)
    puts "Do not exists config file..."
else 
    load_vars()
    # Loads path rake files
    path_rakes = (Dir.glob("**/rakes/init.rake").collect{|path| File.dirname(path)}).first
    
    if (path_rakes.nil? || path_rakes.empty?)
        path_rakes = (Dir.glob("**/*/**/init.rake").collect{|path| File.dirname(path)}).first
    end
    
    if (path_rakes.nil? || path_rakes.empty?)
        puts "Do not exists rake files..."
    else
        Dir.glob("#{path_rakes}/*.rake").each { |r| import r }
    end
end

def load_vars()
    config = YAML.load_file(path_config_file)

    $ti_option              = config["build"]["ti_options"]
    $call_clean             = config["build"]["call_clean_every_build"]
    $default_theme          = config["theme"]["default"]
    $tf_api_token           = config["testflight"]["api_token"]
    $tf_team_token          = config["testflight"]["team_token"]
    $tf_distribution_lists  = config["testflight"]["distribution_lists"]
    $tf_file                = config["testflight"]["file"]
    $tf_notes               = config["testflight"]["notes"]
end