require "sportdb/readers"
require "sportdb/exporters"

## use (switch to) latest "external" datasets
SportDb::Import.config.leagues_dir = "./leagues"
SportDb::Import.config.clubs_dir   = "./clubs"



#####################
### note: for now setup lint machinery "on demand"
###
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


task :lint do
  lint
end


task :mirror => :config do
  mirror( league: 'eng', reponame: 'england' )
  mirror( league: 'de',  reponame: 'deutschland' )
  mirror( league: 'es',  reponame: 'espana' )

  ## mirror( league: 'at', reponame: 'austria' )

  puts "mirror done"
end


##  used by json export/generate task
# FOOTBALL_JSON_DIR = "./workflow.json"
# FOOTBALL_JSON_DIR =  "./football.json"

task :json => :config  do       ## for in-memory depends on all for now - ok??
  [
    'at.1',
    'at.2',
    'at.cup',

    'de.1',
    'de.2',
    'de.3',
    'de.cup',

    'eng.1',
    'eng.2',
    'eng.3',
    'eng.4',

    'es.1',
    'es.2',

    'it.1',
    'it.2',

    'fr.1',
    'fr.2',

    'ru.1',
    'ru.2',

    ## from world/ datasets
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

    'sco.1', # Scotland
    'ar.1',  # Argentina
    'cn.1',  # China
    'jp.1',  # Japan
    'au.1',  # Australia

    ###################
    ## more
    'mx.1',
    'br.1',

    #########
    ## clubs int'l  (incl. group/group phase)
    'uefa.cl.quali',
    'uefa.cl',
  ].each do |league|
    SportDb::JsonExporter.export( league, out_root: './football.json' )
  end
end








