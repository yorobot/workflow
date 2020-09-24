require "gitti"

require_relative "./config"



def ssh_clone
  #############
  ### "deep" standard/ regular clone
  [
    'yorobot/logs',
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


  names = DATASETS.map { |key,h| File.basename(h[:path]) }
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
    Git.clone( "git@github.com:openfootball/#{name}.git", depth: 1 )
  end


  #############
  ### "deep" standard/ regular clone for csv datasets
  names = DATASETS_CSV.map { |key,h| File.basename(h[:path]) }
  pp names

  names.each do |name|
    Git.clone( "git@github.com:footballcsv/#{name}.git", "#{name}.csv" )
  end
end




if $PROGRAM_NAME == __FILE__
  ssh_clone()
end

