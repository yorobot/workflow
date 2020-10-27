unless defined?( Mono )
  ## for testing - setup Mono with root in /tmp
  require 'mono'
  puts "pwd: #{Dir.pwd}"
  ## use working dir as root? or change to home dir ~/ or ~/mono - why? why not?
  ## Mono.root = "#{Dir.pwd}/tmp"
  puts "Mono.root: #{Mono.root}"

  ## Mono.walk  ## for debugging print / walk mono (source) tree
end



require "sportdb/readers"

$LOAD_PATH.unshift( Mono.real_path( "sportdb-exporters/lib@yorobot/sport.db.more" ))
require "sportdb/exporters"

## use (switch to) latest "external" datasets
SportDb::Import.config.leagues_dir = Mono.real_path( "leagues@openfootball" )
SportDb::Import.config.clubs_dir   = Mono.real_path( "clubs@openfootball" )



#####################
## note: for now setup lint machinery "on demand"
$LOAD_PATH.unshift( Mono.real_path( "sportdb-linters/lib@yorobot/sport.db.more" ))
require 'sportdb/linters'



require './mirror'
require './lint'

