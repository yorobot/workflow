
$LOAD_PATH.unshift( Monopath.real_path( 'webget-football/lib@yorobot/sport.db.more' ))
$LOAD_PATH.unshift( Monopath.real_path( 'football-sources/lib@yorobot/sport.db.more' ))
require 'football/sources'



#############
## up (ongoing) 2020 or 2020/21 seasons

Webget.config.sleep = 1


DATASETS = [
 ['eng.1',  %w[2020/21]],
 ['de.1',   %w[2020/21]],
 ['es.1',   %w[2020/21]],
 ['fr.1',   %w[2020/21]],
 ['it.1',   %w[2020/21]],

 ['at.1',   %w[2020/21]],

 ['mx.1',   %w[2020/21]],

 ['br.1',   %w[2020]],
 ['jp.1',   %w[2020]],
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
        Fbref.schedule( league: league,
                        season: season )
    end
  end
end



Fbref.config.convert.out_dir = Monopath.real_path( 'stage/three@yorobot' )

def convert( datasets )
  datasets.each do |dataset|
    league  = dataset[0]
    seasons = dataset[1]
    seasons.each do |season|
      Fbref.convert( league: league,
                     season: season )
    end
  end
end
