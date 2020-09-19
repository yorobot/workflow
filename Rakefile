require "gitti"
require "sportdb/readers"


task default: %w[hello]

task :hello do
  puts Git.version
  puts Git.status
  puts Git.changes
end

task :clone do
  Git.clone( 'https://github.com/openfootball/mexico.git' )
  Git.clone( 'https://github.com/openfootball/france.git' )
  puts "Dir.pwd: >#{Dir.pwd}<"

  GitProject.open( './mexico' ) do |proj|
    proj.status
    proj.changes
    proj.files
  end

  puts "Dir.pwd: >#{Dir.pwd}<"
end



################
# club country repos
AT_DIR        = "./austria"
DE_DIR        = "./deutschland"
EN_DIR        = "./england"
ES_DIR        = "./espana"
IT_DIR        = "./italy"
FR_DIR        = "./france"
WORLD_DIR     = "./world"   # incl. netherlands, portugal, switzerland, turkey, etc.

BR_DIR        = "./brazil"
MX_DIR        = "./mexico"
EUROPE_CL_DIR = "./europe-champions-league"

DATASETS = {
#             at:    { path: AT_DIR }, ## domestic clubs
#             de:    { path: DE_DIR },
#             en:    { path: EN_DIR },
#             es:    { path: ES_DIR },
#             it:    { path: IT_DIR },
             fr:    { path: FR_DIR },
#             world: { path: WORLD_DIR },

             mx:    { path: MX_DIR },
#             br:    { path: BR_DIR },
            ## note: reserve cl for country code for Chile!! - why? why not?
#             europe_cl:  { path: EUROPE_CL_DIR },
}

##  used by json export/generate task
## FOOTBALL_JSON_DIR = "./football.json"



BUILD_DIR = "./build"
OUT_DIR   = "./o"        ## output dir for testing/debugging - note: NOT used for release only for debug (rename to DEBUG_OUT_DIR or such - why? why not?)
TMP_DIR   = "./tmp"


DB_CONFIG = {
  adapter:   'sqlite3',
  database:  "#{BUILD_DIR}/all.db"
}

directory BUILD_DIR

task :build => BUILD_DIR  do
  SportDb.connect( DB_CONFIG )

  logger = LogUtils::Logger.root

  ## log all warns, errors, fatals to db
  LogDb.setup
  logger.warn "Rakefile - #{Time.now}"  # say hello; log to db (warn level min)

  ## use DEBUG=t or DEBUG=f
  logger.level =  :debug     # :info

  SportDb.create_all

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

  SportDb.tables   ## print some stats

  ## dump logs if any
  puts "db logs (#{LogDb::Models::Log.count})"
  LogDb::Models::Log.order(:id).each do |log|
    puts "  [#{log.level}] #{log.ts}  - #{log.msg}"
  end
end
