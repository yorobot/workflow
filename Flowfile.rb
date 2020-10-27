
require './config'


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
  lint( DATASETS )
end


step :mirror do
  ##  was: task :mirror => :config

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
