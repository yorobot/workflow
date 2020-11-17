
$LOAD_PATH.unshift( Monopath.real_path( 'webget-football/lib@yorobot/sport.db.more' ))
$LOAD_PATH.unshift( Monopath.real_path( 'football-sources/lib@yorobot/sport.db.more' ))
require 'football/sources'

## todo/check:
## use a shortcut / something like - why? why not?
##  Mono.load_path << 'yorobot/cache.csv/apis/lib'



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

  ['cl',    %w[2020/21]],
]


pp DATASETS



###
## todo/fix: (re)use / move into
##     Footballdata::Tool.download( DATASETS ) !!!!
##    or Footballdata::Batch.download  or Job.download or ?????
def download( datasets=DATASETS )
  datasets.each do |dataset|
    league  = dataset[0]
    seasons = dataset[1]
    seasons.each do |season|
        Footballdata.schedule( league: league,
                               season: season )
    end
  end
end



Footballdata.config.convert.out_dir = Monopath.real_path( 'stage/one@yorobot' )

def convert( datasets=DATASETS )
  datasets.each do |dataset|
    league  = dataset[0]
    seasons = dataset[1]
    seasons.each do |season|
      Footballdata.convert( league: league,
                            season: season )
    end
  end
end
