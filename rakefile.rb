$ti_option       = "--no-banner --log-level debug"
$default_theme   = "hanzo"
$call_clean      = true

Dir.glob('../TiRake/rakes/*.rake').each { |r| import r }