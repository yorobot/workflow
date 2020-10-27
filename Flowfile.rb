#############
#  clone

step :clone do
  #############
  ### "deep" standard/ regular clone
  [
             'logs@yorobot',
    'football.json@openfootball',
  ].each do |repo|
    Mono.clone( repo )
  end

  ######
  ### shallow "fast clone" - support libraries
  ###  use https:// instead of ssh - why? why not?
  [
    'sport.db.more@yorobot',
  ].each do |repo|
    Mono.clone( repo, depth: 1 )
  end


  names = DATASETS.map { |key,h| h[:name] }
  # e.g. like [
  #  'england',
  #  'deutschland',
  #  'espana',
  #  'italy',
  #  'france',
  #  'austria',
  #  'mexico']
  pp names

  ###################
  ### shallow "fast" clone (no commit/push possible); use depth 1
  ###  use https:// instead of ssh - why? why not?
  ###    no need for commits - just read-only ok
  names += [ ## add basic setup too
            'leagues',
            'clubs',
           ]
  names.each do |name|
    Mono.clone( "#{name}@openfootball", depth: 1 )
  end


  #############
  ### "deep" standard/ regular clone for csv datasets
  names = DATASETS_CSV.map { |key,h| h[:name] }
  pp names

  names.each do |name|
    Mono.clone( "#{name}@footballcsv" )
  end
end



##################
#  push

step :push_logs do
  msg  = "auto-update week #{Date.today.cweek}"

  puts "check for changes in >#{Mono.real_path('logs@yorobot')}<..."
  Mono.open( 'logs@yorobot' ) do |proj|
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    end
  end
end


step :push_json do
  msg  = "auto-update week #{Date.today.cweek}"

  puts "check for changes in >#{Mono.real_path('football.json@openfootball')}<..."
  Mono.open( 'football.json@openfootball' ) do |proj|
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    end
  end
end


step :push_csv do
  msg  = "auto-update week #{Date.today.cweek}"
  names = DATASETS_CSV.map { |key,h| h[:name] }
  # e.g.
  # ['england',
  #  'deutschland',
  #  'espana']
  pp names

  names.each do |name|
    path = Mono.real_path( "#{name}@footballcsv" )
    puts "check for changes in >#{path}<..."

    Mono.open( "#{name}@footballcsv" ) do |proj|
      if proj.changes?
        proj.add( '.' )
        proj.commit( msg )
        proj.push
      end
    end
  end
end

step :push do
   step :push_json
   step :push_csv
   step :push_logs
   ##
   # or step_push_json
   # or step_push_csv
   # or step_push_logs
end



#################
#  more

step :lint do
  ## note: no database (connection) required for linting!!!
  lint( DATASETS )
end


step :build do
  build( DATASETS )
end


step :stats do
  connect
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



step :mirror do
  ##  was: task :mirror => :config
  connect

  #########
  ## country repos
  mirror( league: 'eng', reponame: 'england' )
  mirror( league: 'de',  reponame: 'deutschland' )
  mirror( league: 'es',  reponame: 'espana' )
  mirror( league: 'at',  reponame: 'austria' )
  mirror( league: 'be',  reponame: 'belgium')

  mirror( league: 'mx',  reponame: 'mexico')

  ########
  ## all-in-one world
  ['it',   # Italy
   'fr',   # France
   'nl',   # Netherlands
   'sco',  # Scotland
   'br',   # Brazil
   'cn',   # China
  ].each do |league|
    mirror( league: league, reponame: 'world' )
  end

  puts "mirror done"
end



##  used by json export/generate task
# FOOTBALL_JSON_DIR =  "./football.json"

step :json do
  # was task :json => :config
  connect

  [
    'at.1',  # Austria
    'at.2',
    'at.cup',

    'de.1',  # Germany • Deutschland
    'de.2',
    'de.3',
    'de.cup',

    'eng.1',  # England
    'eng.2',
    'eng.3',
    'eng.4',

    'es.1',  # Spain • España
    'es.2',

    'it.1',  # Italy
    'it.2',

    ## from europe/ datasets
    'fr.1',  # France
    'fr.2',

    'sco.1', # Scotland

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

    'ru.1',  # Russia
    'ru.2',

    ## from south-america/ datasets
    'ar.1',  # Argentina
    'br.1',  # Brazil

    ## from world/ datasets
    'cn.1',  # China
    'jp.1',  # Japan
    'au.1',  # Australia

    ###################
    ## more
    'mx.1',  # Mexico

    #########
    ## clubs int'l  (incl. group/group phase)
    'uefa.cl.quali',   # Champions League Quali(fications)
    'uefa.cl',         # Champions League
  ].each do |league|
    SportDb::JsonExporter.export( league, out_root: Mono.real_path( 'football.json@openfootball' ))
  end
end


