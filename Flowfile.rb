#############
#  clone

step [:sync, :clone] do
  #############
  ### "deep" standard/ regular clone
  [
             'logs@yorobot',
  ].each do |repo|
    Mono.sync( repo )
  end

  ######
  ### shallow "fast clone" - support libraries
  ###  use https:// instead of ssh - why? why not?
  [
    'sport.db.more@yorobot',
  ].each do |repo|
    Mono.sync( repo )    ## was: Mono.clone( repo, depth: 1 )
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
    Mono.sync( "#{name}@openfootball" )  ## was: Mono.clone( "#{name}@openfootball", depth: 1 )
  end


  #############
  ### "deep" standard/ regular clone for csv datasets
  names = DATASETS_CSV.map { |key,h| h[:name] }
  pp names

  names.each do |name|
    Mono.sync( "#{name}@footballcsv" )
  end
end




##################
#  push

step :push_logs do
  msg  = "auto-update week #{Date.today.cweek}"

  Mono.open( 'logs@yorobot' ) do |proj|
    puts "check for changes in >#{Dir.pwd}<..."
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    else
      puts '  - no changes -'
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
    Mono.open( "#{name}@footballcsv" ) do |proj|
      puts "check for changes in >#{Dir.pwd}<..."
      if proj.changes?
        proj.add( '.' )
        proj.commit( msg )
        proj.push
      else
        puts '  - no changes -'
      end
    end
  end
end

step :push do
   step :push_csv
   step :push_logs
   ##
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
