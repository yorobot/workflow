require "gitti"



def ssh_clone
  #############
  ### "deep" standard/ regular clone
  [
    'yorobot/logs',
    'yorobot/stage',
  ].each do |repo|
    Git.clone( "git@github.com:#{repo}.git" )
  end

  ######
  ### shallow "fast clone" - support libraries
  ###  use https:// instead of ssh - why? why not?
  [
    'yorobot/cache.csv',
  ].each do |repo|
    Git.clone( "git@github.com:#{repo}.git", depth: 1 )
  end
end




if $PROGRAM_NAME == __FILE__
  ssh_clone()
end

