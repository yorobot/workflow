puts "pwd: #{Dir.pwd}"
## use working dir as root? or change to home dir ~/ or ~/mono - why? why not?
Mono.root = Dir.pwd

Mono.walk  ## for debugging print / walk mono (source) tree



require_relative './config'


#############
#  clone

step :clone do
  #############
  ### "deep" standard/ regular clone
  [
    'yorobot/logs',
    'openfootball/football.json',
  ].each do |repo|
    Mono.clone( repo )
  end

  ######
  ### shallow "fast clone" - support libraries
  ###  use https:// instead of ssh - why? why not?
  [
    'yorobot/sport.db.more',
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
    Mono.clone( "openfootball/#{name}", depth: 1 )
  end


  #############
  ### "deep" standard/ regular clone for csv datasets
  names = DATASETS_CSV.map { |key,h| h[:name] }
  pp names

  names.each do |name|
    Mono.clone( "footballcsv/#{name}" )
  end
end



##################
#  push

step :push_logs do
  msg  = "auto-update week #{Date.today.cweek}"
  ## todo/fix: rename to logs or something why? why not?
  GitProject.open( './logs' ) do |proj|
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    end
  end
end


##  used by json export/generate task
# FOOTBALL_JSON_DIR = "./workflow.json"
# FOOTBALL_JSON_DIR = "./football.json"

step :push_json do
  msg  = "auto-update week #{Date.today.cweek}"

  GitProject.open( './football.json' ) do |proj|
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    end
  end
end


step :push_csv do
  msg  = "auto-update week #{Date.today.cweek}"

  names = DATASETS_CSV.map { |key,h| File.basename(h[:path]) }
  # e.g.
  # ['england',
  #  'deutschland',
  #  'espana']
  pp names

  names.each do |name|
    GitProject.open( "./#{name}.csv" ) do |proj|
      if proj.changes?
        proj.add( '.' )
        proj.commit( msg )
        proj.push
      end
    end
  end
end

step :push do
  push_json
  push_csv
  push_logs
end

