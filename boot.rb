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

$LOAD_PATH.unshift( Mono.real_path( "yorobot/sport.db.more/sportdb-exporters/lib" ))
require "sportdb/exporters"

## use (switch to) latest "external" datasets
SportDb::Import.config.leagues_dir = Mono.real_path( "openfootball/leagues" )
SportDb::Import.config.clubs_dir   = Mono.real_path( "openfootball/clubs" )



#####################
## note: for now setup lint machinery "on demand"
$LOAD_PATH.unshift( Mono.real_path( "yorobot/sport.db.more/sportdb-linters/lib" ))
require 'sportdb/linters'


## require_relative './config'

## require_relative './mirror'
require_relative './lint'


