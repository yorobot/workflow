require "sportdb/readers"

$LOAD_PATH.unshift( File.expand_path( "./sport.db.more/sportdb-exporters/lib" ))
require "sportdb/exporters"

## use (switch to) latest "external" datasets
SportDb::Import.config.leagues_dir = "./leagues"
SportDb::Import.config.clubs_dir   = "./clubs"



#####################
## note: for now setup lint machinery "on demand"
$LOAD_PATH.unshift( File.expand_path( "./sport.db.more/sportdb-linters/lib" ))
require 'sportdb/linters'


require_relative "./config"

require_relative "./mirror"
require_relative './lint'




BUILD_DIR = "./build"
OUT_DIR   = "./o"        ## output dir for testing/debugging - note: NOT used for release only for debug (rename to DEBUG_OUT_DIR or such - why? why not?)
TMP_DIR   = "./tmp"


DB_CONFIG = {
  adapter:   'sqlite3',
  database:  "#{BUILD_DIR}/all.db"
}


directory BUILD_DIR

task :env => BUILD_DIR do
  SportDb.connect( DB_CONFIG )
end

task :create => :env do
  SportDb.create_all
end

task :config => :env do
  logger = LogUtils::Logger.root

  ## log all warns, errors, fatals to db
  LogDb.setup
  logger.warn "Rakefile - #{Time.now}"  # say hello; log to db (warn level min)

  ## use DEBUG=t or DEBUG=f
  logger.level =  :debug     # :info
end




task :build => [:create, :config] do
  DATASETS.each do |key,h|
       start_time = Time.now   ## todo: use Timer? t = Timer.start / stop / diff etc. - why? why not?

       ## SportDb.read( h[:path] )
       ## note: only incl. latest season for now
       SportDb.read( h[:path], season: SEASON_LATEST )

       end_time = Time.now
       diff_time = end_time - start_time
       puts "read_#{key}: done in #{diff_time} sec(s)"
  end
end


task :stats => :config do
  SportDb.tables   ## print some stats

  SportDb::Model::Event.order( :id ).each do |event|
     puts "    #{event.key} | #{event.league.key} - #{event.league.name} | #{event.season.key}"
  end

  ## dump logs if any
  puts "db logs (#{LogDb::Models::Log.count})"
  LogDb::Models::Log.order(:id).each do |log|
    puts "  [#{log.level}] #{log.ts}  - #{log.msg}"
  end
end






##  used by json export/generate task
# FOOTBALL_JSON_DIR =  "./football.json"

task :json => :config  do       ## for in-memory depends on all for now - ok??
  [
    'at.1',  # Austria
    'at.2',
    'at.cup',

    'de.1',  # Germany • Deutschland
    'de.2',
    'de.3',
    'de.cup',

    'eng.1',  # England
    'eng.2',
    'eng.3',
    'eng.4',

    'es.1',  # Spain • España
    'es.2',

    'it.1',  # Italy
    'it.2',

    ## from europe/ datasets
    'fr.1',  # France
    'fr.2',

    'sco.1', # Scotland

    'nl.1',  # Netherlands
    'be.1',  # Belgium
    'pt.1',  # Portugal

    'ch.1',  # Switzerland
    'ch.2',

    'cz.1',  # Czech Republic
    'hu.1',  # Hungary

    'gr.1',  # Greece
    'tr.1',  # Turkey
    'tr.2',

    'ru.1',  # Russia
    'ru.2',

    ## from south-america/ datasets
    'ar.1',  # Argentina
    'br.1',  # Brazil

    ## from world/ datasets
    'cn.1',  # China
    'jp.1',  # Japan
    'au.1',  # Australia

    ###################
    ## more
    'mx.1',  # Mexico

    #########
    ## clubs int'l  (incl. group/group phase)
    'uefa.cl.quali',   # Champions League Quali(fications)
    'uefa.cl',         # Champions League
  ].each do |league|
    SportDb::JsonExporter.export( league, out_root: './football.json' )
  end
end








