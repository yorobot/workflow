$LOAD_PATH.unshift( File.expand_path( "./cache.csv/apis/lib" ))
require 'metal'

#############
## up (ongoing) 2020 or 2020/21 seasons

### note: free trier has a 10 request/minute limit
##  sleep/wait 8secs after every request (should result in ~7-8 requests/minute)


Footballdata.config.sleep = 8


Footballdata.eng( 2020 )   ## note. includes Premier League & Championship
Footballdata.de( 2020 )
Footballdata.es( 2020 )
Footballdata.fr( 2020 )
Footballdata.it( 2020 )

Footballdata.nl( 2020 )
Footballdata.pt( 2020 )

Footballdata.br( 2020 )

Footballdata.cl( 2020 )
