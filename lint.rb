
$LOAD_PATH.unshift( File.expand_path( "./sport.db.more/sportdb-auto/lib" ))

## note: MUST require linters AFTER changing leagues_dir/clubs_dir etc.
require 'sportdb/linters'



def print_errors( errors )
  if errors.size > 0
    puts "#{errors.size} error(s) / warn(s):"
    errors.each do |error|
      puts "!! ERROR: #{error}"
    end
  else
    puts "#{errors.size} errors / warns"
  end
end


if ARGV.size > 0

  dataset = datasets[ ARGV[0] ]

  path   = dataset[0]
  kwargs = dataset[1] || {}

  buf, errors = SportDb::PackageLinter.lint( path, **kwargs )
  puts buf
  puts
  print_errors( errors )

## save
# out_path = "#{path}/.build/conf.txt"
out_path = "./tmp/#{ARGV[0]}.conf.txt"
File.open( out_path , 'w:utf-8' ) do |f|
 f.write( buf )
end

else    ## check all
errors_by_dataset = []

datasets.values.each do |dataset|
  path   = dataset[0]
  kwargs = dataset[1] || {}

  buf, errors = SportDb::PackageLinter.lint( path, **kwargs )
  puts buf

  errors_by_dataset << [File.basename(path), errors]
end


errors_by_dataset.each do |rec|
  dataset = rec[0]
  errors  = rec[1]

  puts
  puts "==== #{dataset} ===="

  print_errors( errors )
end
end

puts "bye"


