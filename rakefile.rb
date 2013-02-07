$ti_option      = "--no-banner --log-level debug"
$default_theme  = "default_theme"
$call_clean     = true
$path_tirake    = "TiRake"

Dir.glob("#{$path_tirake}/rakes/*.rake").each { |r| import r }