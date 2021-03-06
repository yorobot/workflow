
$LOAD_PATH.unshift( Monopath.real_path( 'webget-football/lib@yorobot/sport.db.more' ))
$LOAD_PATH.unshift( Monopath.real_path( 'football-sources/lib@yorobot/sport.db.more' ))
require 'football/sources'


Webget.config.sleep = 3



## top-level countries / leagues
##
## check / use uefa country league ranking - 1. eng, 2. de, etc. ????


DATASETS = [
 ['br.1',    %w[2020]],     # starts Sun Aug 9  - note: now runs into 2021!!!

 ['eng.1',   %w[2020/21]],   # starts Sat Sep 12
 ['eng.2',   %w[2020/21]],   # starts Sat Sep 12
 ['eng.3',   %w[2020/21]],   # starts Sat Sep 12
 ['eng.4',   %w[2020/21]],   # starts Sat Sep 12
 ['eng.5',   %w[2020/21]],   # starts Sat Oct 3
 ## todo/fix: add league cup and ...

 ['de.1',    %w[2020/21]],   # starts Fri Sep 18
 ['de.2',    %w[2020/21]],   # starts Fri Sep 18
 ['de.3',    %w[2020/21]],   # starts Fri Sep 18
 ['de.cup',  %w[2020/21]],

 ['es.1',    %w[2020/21]],   # starts Fri Sep 11
 ['es.2',    %w[2020/21]],   # starts Fri Sep 11

 ['it.1',    %w[2020/21]],   # starts Sun Sep 20
 ['it.2',    %w[2020/21]],   # starts Fri Sep 25

 ['fr.1',    %w[2020/21]],   # starts Fri Aug 21
 ['fr.2',    %w[2020/21]],   # starts Sat Aug 22



 ['at.1',    %w[2020/21]],   # starts Fri Sep 11
 ['at.2',    %w[2020/21]],   # starts Fri Sep 11
 ['at.3.o',  %w[2020/21]],   # starts Fri Aug 21
 ['at.cup',  %w[2020/21]],   # starts Fri Aug 28


 ['mx.1',    %w[2020/21]],   # starts Fri Jul 24
]

pp DATASETS



def download( datasets )
  Worldfootball::Jobs.download( datasets )
end


def convert( datasets )
  Worldfootball.config.convert.out_dir = Monopath.real_path( 'stage/two@yorobot' )

  Worldfootball::Jobs.convert( datasets )
end

