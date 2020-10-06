$LOAD_PATH.unshift( File.expand_path( "./cache.csv/apis/lib" ))
require 'convert'


#############
## up (ongoing) 2020 or 2020/21 seasons

### note: free trier has a 10 request/minute limit
##  sleep/wait 8secs after every request (should result in ~7-8 requests/minute)
Webget.config.sleep = 8


DATASETS = [
  ['eng.1', %w[2020/21]],
  ['eng.2', %w[2020/21]],

  ['de.1',  %w[2020/21]],
  ['es.1',  %w[2020/21]],
  ['fr.1',  %w[2020/21]],
  ['it.1',  %w[2020/21]],

  ['nl.1',  %w[2020/21]],
  ['pt.1',  %w[2020/21]],

  ['br.1',  %w[2020]],

  ['cl.1',  %w[2020/21]],
]


pp DATASETS



###
## todo/fix: (re)use / move into
##     Footballdata::Tool.download( DATASETS ) !!!!
##    or Footballdata::Batch.download  or Job.download or ?????
def download( datasets )
  datasets.each do |dataset|
    league  = dataset[0]
    seasons = dataset[1]
    seasons.each do |season|
      Footballdata.schedule( league: league,
                             season: season )
    end
  end
end


Footballdata.config.convert.out_dir = './stage/one'

def convert( datasets )
  datasets.each do |dataset|
    league  = dataset[0]
    seasons = dataset[1]
    seasons.each do |season|
      Footballdata.convert( league: league,
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
