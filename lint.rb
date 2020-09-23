


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
  errors_by_dataset = []

  DATASETS.each do |key,h|
    path   = h[:path]

    kwargs = {}
    kwargs[:mods] = h[:mods]  if h[:mods]

    buf, errors = SportDb::PackageLinter.lint( path, **kwargs )
    puts buf
    puts
    puts build_errors( errors )

    errors_by_dataset << [File.basename(path), errors]

    ## save
    # out_path = "#{path}/.build/conf.txt"
    out_path = "./workflow.json/#{key}.conf.txt"
    File.open( out_path , 'w:utf-8' ) do |f|
      f.write( buf )
    end
  end

  buf = String.new( '' )
  total_errors = 0
  errors_by_dataset.each do |rec|
    dataset = rec[0]
    errors  = rec[1]

    total_errors += errors.size

    buf << "\n"
    buf << "==== #{dataset} ====\n"

    buf << build_errors( errors )
  end
  puts buf


  ## note: let's stop processing pipeline if any errors found!!!
  ##    note save errros for now in all.conf.txt
  out_path = "./workflow.json/all.conf.txt"
  if total_errors > 0
    puts "#{total_errors} error(s) total; please fix"

    File.open( out_path , 'w:utf-8' ) do |f|
      f.write( buf )
    end
    ## exit 1
  else
    File.open( out_path , 'w:utf-8' ) do |f|
      f.write( "OK\n" )
    end
  end
end  ## method lint

