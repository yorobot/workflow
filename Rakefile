require "gitti"


require "sportdb/readers"
require "sportdb/exporters"


require_relative "./mirror"


require_relative "./config"



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
  latest = ['2018/19', '2019',
            '2019/20', '2020',
            '2020/21']
  ## for all start with 2010/11 season for now
  all    = ['2010/11',
            '2011/12',
            '2012/13',
            '2013/14',
            '2014/15',
            '2015/16',
            '2016/17',
            '2017/18',
            '2018/19', '2019',
            '2019/20', '2020']

  DATASETS.each do |key,h|
       start_time = Time.now   ## todo: use Timer? t = Timer.start / stop / diff etc. - why? why not?

       ## SportDb.read( h[:path] )
       ## note: only incl. latest season for now
       SportDb.read( h[:path], season: latest )

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
# FOOTBALL_JSON_DIR = "./workflow.json"
FOOTBALL_JSON_DIR = "./football.json"


task :ssh_push do
  msg  = "auto-update week #{Date.today.cweek}"

  GitProject.open( FOOTBALL_JSON_DIR ) do |proj|
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    end
  end

  [
    'england',
    'deutschland',
    'espana',
  ].each do |name|
    GitProject.open( "./#{name}.csv" ) do |proj|
      if proj.changes?
        proj.add( '.' )
        proj.commit( msg )
        proj.push
      end
    end
  end
end


task :ssh_clone do
  #############
  ### "deep" standard/ regular clone
  [
    # 'yorobot/workflow.json',
    'openfootball/football.json',
  ].each do |repo|
    Git.clone( "git@github.com:#{repo}.git" )
  end

  ###################
  ### shallow "fast" clone (no commit/push possible); use depth 1
  [
    'england',
    'deutschland',
    'espana',
    'italy',
    'france',
    'austria',
    'mexico',
  ].each do |name|
    Git.clone( "git@github.com:openfootball/#{name}.git", depth: 1 )
  end

  #############
  ### "deep" standard/ regular clone for csv datasets
  [
    'england',
    'deutschland',
    'espana',
  ].each do |name|
    Git.clone( "git@github.com:footballcsv/#{name}.git", "#{name}.csv" )
  end
end



task :mirror => :config do
  mirror( league: 'eng', reponame: 'england' )
  mirror( league: 'de',  reponame: 'deutschland' )
  mirror( league: 'es',  reponame: 'espana' )

  ## mirror( league: 'at', reponame: 'austria' )

  puts "mirror done"
end


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
    SportDb::JsonExporter.export( league, out_root: FOOTBALL_JSON_DIR )
  end
end








