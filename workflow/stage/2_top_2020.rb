$LOAD_PATH.unshift( File.expand_path( "./cache.csv/cache.weltfussball/lib" ))
require 'convert'



## top-level countries / leagues

LEAGUES_YEAR = [
  'br.1',    # starts Sun Aug 9  - note: now runs into 2021!!!
]


###
## check / use uefa country league ranking - 1. eng, 2. de, etc. ????

LEAGUES = [    ## regular academic / season e.g. 2020/21
'eng.1',        # starts Sat Sep 12
'eng.2',        # starts Sat Sep 12
'eng.3',        # starts Sat Sep 12
'eng.4',        # starts Sat Sep 12
'eng.5',        # starts Sat Oct 3
## todo/fix: add league cup and ...

'de.1',         # starts Fri Sep 18
'de.2',         # starts Fri Sep 18
'de.3',         # starts Fri Sep 18
'de.cup',

'es.1',         # starts Fri Sep 11
'es.2',         # starts Fri Sep 11

'fr.1',         # starts Fri Aug 21
'fr.2',         # starts Sat Aug 22

'it.1',         # starts Sun Sep 20
'it.2',         # starts Fri Sep 25


'at.1',         # starts Fri Sep 11
'at.2',         # starts Fri Sep 11
'at.3.o',       # starts Fri Aug 21
'at.cup',       # starts Fri Aug 28

'mx.1',         # starts Fri Jul 24
]

LEAGUES_BY_SEASON = [
  ['2020/21', LEAGUES],
  ['2020',    LEAGUES_YEAR]
]

pp LEAGUES_BY_SEASON




Worldfootball.config.sleep = 3

Worldfootball.config.cache.schedules_dir = './cache.weltfussball/dl'
Worldfootball.config.cache.reports_dir   = './cache.weltfussball/dl2'

Worldfootball.config.convert.out_dir     = './stage/two'




def download
  tool = Worldfootball::Tool.new
  tool.download( LEAGUES_BY_SEASON )
end

def convert
  tool = Worldfootball::Tool.new
  tool.convert( LEAGUES_BY_SEASON )
end



if $PROGRAM_NAME == __FILE__
  if ARGV.size == 0
    convert()
  else
    ARGV.each do |arg|
      case arg
      when 'dl', 'download'  then download()
      when 'convert'         then convert()
      else
        puts "[top script] unknown argument >#{arg}<"
        exit 1
      end
    end
  end
end


puts "bye"
