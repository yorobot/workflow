require "gitti"

task default: %w[hello]

task :hello do
  puts Git.version
  puts Git.status
  puts Git.changes
end

task :clone do
  Git.clone( 'https://github.com/openfootball/mexico.git' )
end