require "gitti"


def ssh_clone
  #############
  ### "deep" standard/ regular clone
  [
    'yorobot/workflow.json',
    'openfootball/football.json',
  ].each do |repo|
    Git.clone( "git@github.com:#{repo}.git" )
  end

  ######
  ### shallow "fast clone" - support libraries
  ###  use https:// instead of ssh - why? why not?
  [
    'yorobot/sport.db.more',
  ].each do |repo|
    Git.clone( "git@github.com:#{repo}.git", depth: 1 )
  end


  ###################
  ### shallow "fast" clone (no commit/push possible); use depth 1
  ###  use https:// instead of ssh - why? why not?
  [
    'england',
    'deutschland',
    'espana',
    'italy',
    'france',
    'austria',
    'mexico',
  ].each do |name|
    Git.clone( "git@github.com:openfootball/#{name}.git", depth: 1 )
  end

  #############
  ### "deep" standard/ regular clone for csv datasets
  [
    'england',
    'deutschland',
    'espana',
  ].each do |name|
    Git.clone( "git@github.com:footballcsv/#{name}.git", "#{name}.csv" )
  end
end


ssh_clone()