


def build_errors( errors )  ## rename to format errors - why? why not?
  buf = String.new( '' )
  if errors.size > 0
    buf << "#{errors.size} error(s) / warn(s):\n"
    errors.each do |error|
      buf << "!! ERROR: #{error}\n"
    end
  else
    buf << "#{errors.size} errors / warns\n"
  end
  buf
end



def lint
  total_errors = 0
  total_buf = String.new( '' )

  DATASETS.each do |key,h|
    path   = h[:path]

    kwargs = {}
    kwargs[:mods] = h[:mods]  if h[:mods]

    buf, errors = SportDb::PackageLinter.lint( path, **kwargs )
    puts buf
    puts
    puts build_errors( errors )

    total_errors += errors.size

    total_buf << "\n"
    total_buf << "==== #{File.basename(path)} ====\n"
    total_buf << build_errors( errors )

    ## save
    # out_path = "#{path}/.build/conf.txt"
    out_path = "./logs/lint.#{key}.txt"
    File.open( out_path , 'w:utf-8' ) do |f|
      f.write( buf )
    end
  end


  puts total_buf

  out_path = "./logs/lint.all.txt"
  if total_errors > 0
    puts "#{total_errors} error(s) total; please fix"

    File.open( out_path , 'w:utf-8' ) do |f|
      f.write( total_buf )
    end
    ## exit 1
    ## note: let's stop processing pipeline if any errors found!!!
    ##    note save errros for now in all.conf.txt
  else
    File.open( out_path , 'w:utf-8' ) do |f|
      f.write( "OK\n" )
    end
  end
end  ## method lint

