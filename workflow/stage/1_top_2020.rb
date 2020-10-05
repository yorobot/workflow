$LOAD_PATH.unshift( File.expand_path( "./cache.csv/apis/lib" ))
require 'convert'


#############
## up (ongoing) 2020 or 2020/21 seasons

### note: free trier has a 10 request/minute limit
##  sleep/wait 8secs after every request (should result in ~7-8 requests/minute)
Webget.config.sleep = 8

def download
  Footballdata.eng( 2020 )   ## note. includes Premier League & Championship
  Footballdata.de( 2020 )
  Footballdata.es( 2020 )
  Footballdata.fr( 2020 )
  Footballdata.it( 2020 )

  Footballdata.nl( 2020 )
  Footballdata.pt( 2020 )

  Footballdata.br( 2020 )

  Footballdata.cl( 2020 )
end



Footballdata.config.convert.out_dir = './stage/one'

def convert
  ['ENG.1',
   'ENG.2',
   'DE.1',
   'ES.1',
   'FR.1',
   'IT.1',
   'NL.1',
   'PT.1',
   'BR.1',   ### note: gets 2020/21 season!! runs until february 2021!!!
  ].each do |league|
    Footballdata.convert( league: league, year: 2020 )
  end

  ## note: use special case converter for champions league for now
  Footballdata.convert_cl( league: 'CL', year: 2020 )
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
