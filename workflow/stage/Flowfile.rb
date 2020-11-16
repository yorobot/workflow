

step [:sync, :clone] do
  #############
  ### "deep" standard/ regular clone
  [
     "logs@yorobot",
    "stage@yorobot",
  ].each do |repo|
    Mono.sync( repo )
  end


  ######
  ### shallow "fast clone" - support libraries
  ###  use https:// instead of ssh - why? why not?
  [
    "sport.db.more@yorobot",
  ].each do |repo|
    Mono.sync( repo )  # was: Mono.clone( repo, depth: 1 )
  end
end



step [:publish, :pub, :push] do
  msg = "auto-update week #{Date.today.cweek}"

  Mono.open( "stage@yorobot" ) do |proj|
    puts "check for changes in >#{Dir.pwd}<..."
    if proj.changes?
      proj.add( "." )
      proj.commit( msg )
      proj.push
    else
      puts '  - no changes -'
    end
  end
end



####
# note:   use yo --require NAME to pull in (auto-require) datasets config/setup

step [:download, :dl] do
  download( DATASETS )
end

step :convert do
  convert( DATASETS )
end


