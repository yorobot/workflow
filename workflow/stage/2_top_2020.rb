$LOAD_PATH.unshift( File.expand_path( "./cache.csv/cache.weltfussball/lib" ))
require 'convert'


Webget.config.sleep = 3



## top-level countries / leagues
##
## check / use uefa country league ranking - 1. eng, 2. de, etc. ????

DATASETS = [
  ['br.1',  %w[2020]],    # starts Sun Aug 9  - note: now runs into 2021!!!


  ['eng.1',  %w[2020/21]],        # starts Sat Sep 12
  ['eng.2',  %w[2020/21]],       # starts Sat Sep 12
  ['eng.3',  %w[2020/21]],       # starts Sat Sep 12
  ['eng.4',  %w[2020/21]],       # starts Sat Sep 12
  ['eng.5',  %w[2020/21]],       # starts Sat Oct 3
    ## todo/fix: add league cup and ...

  ['de.1',   %w[2020/21]],       # starts Fri Sep 18
  ['de.2',   %w[2020/21]],       # starts Fri Sep 18
  ['de.3',   %w[2020/21]],       # starts Fri Sep 18
  ['de.cup', %w[2020/21]],

  ['es.1',   %w[2020/21]],         # starts Fri Sep 11
  ['es.2',   %w[2020/21]],      # starts Fri Sep 11

  ['fr.1',   %w[2020/21]],      # starts Fri Aug 21
  ['fr.2',   %w[2020/21]],      # starts Sat Aug 22

  ['it.1',   %w[2020/21]],      # starts Sun Sep 20
  ['it.2',   %w[2020/21]],      # starts Fri Sep 25


  ['at.1',   %w[2020/21]],      # starts Fri Sep 11
  ['at.2',   %w[2020/21]],      # starts Fri Sep 11
  ['at.3.o', %w[2020/21]],      # starts Fri Aug 21
  ['at.cup', %w[2020/21]],      # starts Fri Aug 28

  ['mx.1',   %w[2020/21]],      # starts Fri Jul 24
]


pp DATASETS



def download( datasets )
  datasets.each do |dataset|
    league  = dataset[0]
    seasons = dataset[1]
    seasons.each do |season|
      Worldfootball.schedule( league: league,
                              season: season )
    end
  end
end


Worldfootball.config.convert.out_dir     = './stage/two'

def convert( datasets )
  datasets.each do |dataset|
    league  = dataset[0]
    seasons = dataset[1]
    seasons.each do |season|
      Worldfootball.convert( league: league,
                            season: season )
    end
  end
end



if $PROGRAM_NAME == __FILE__
  if ARGV.size == 0
    convert( DATASETS )
  else
    ARGV.each do |arg|
      case arg
      when 'dl', 'download'  then download( DATASETS )
      when 'convert'         then convert( DATASETS )
      else
        puts "[top script] unknown argument >#{arg}<"
        exit 1
      end
    end
  end
end


puts "bye"
