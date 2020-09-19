require "gitti"

task default: %w[hello]

task :hello do
  puts Git.version
  puts Git.status
  puts Git.changes
end

task :clone do
  Git.clone( 'https://github.com/openfootball/mexico.git' )
  Git.clone( 'https://github.com/openfootball/france.git' )
  puts "Dir.pwd: >#{Dir.pwd}<"

  GitProject.open( './mexico' ) do |proj|
    proj.status
    proj.changes
    proj.files
  end

  puts "Dir.pwd: >#{Dir.pwd}<"
end
