
puts "pwd: #{Dir.pwd}"
## use working dir as root? or change to home dir ~/ or ~/mono - why? why not?
Mono.root = Dir.pwd

Mono.walk  ## for debugging print / walk mono (source) tree



step :clone do
  #############
  ### "deep" standard/ regular clone
  [
    'yorobot/logs',
    'yorobot/stage',
  ].each do |repo|
    Mono.clone( repo )
  end


  ######
  ### shallow "fast clone" - support libraries
  ###  use https:// instead of ssh - why? why not?
  [
    'yorobot/cache.csv',
  ].each do |repo|
    Mono.clone( repo, depth: 1 )
  end
end



step :push do
  msg = "auto-update week #{Date.today.cweek}"

  Mono.open( 'yorobot/stage' ) do |proj|
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    end
  end
end
