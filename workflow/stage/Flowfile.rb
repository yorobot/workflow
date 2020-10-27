

step :clone do
  #############
  ### "deep" standard/ regular clone
  [
     "logs@yorobot",
    "stage@yorobot",
  ].each do |repo|
    Mono.clone( repo )
  end


  ######
  ### shallow "fast clone" - support libraries
  ###  use https:// instead of ssh - why? why not?
  [
    "cache.csv@yorobot",
  ].each do |repo|
    Mono.clone( repo, depth: 1 )
  end
end



step :push do
  msg = "auto-update week #{Date.today.cweek}"

  Mono.open( "stage@yorobot" ) do |proj|
    if proj.changes?
      proj.add( "." )
      proj.commit( msg )
      proj.push
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


