


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


def lint
  errors_by_dataset = []

  DATASETS.each do |key,h|
    path   = h[:path]

    kwargs = {}
    kwargs[:mods] = h[:mods]  if h[:mods]

    buf, errors = SportDb::PackageLinter.lint( path, **kwargs )
    puts buf
    puts
    print_errors( errors )

    errors_by_dataset << [File.basename(path), errors]

    ## save
    # out_path = "#{path}/.build/conf.txt"
    out_path = "./workflow.json/#{key}.conf.txt"
    File.open( out_path , 'w:utf-8' ) do |f|
      f.write( buf )
    end
  end

  total_errors = 0
  errors_by_dataset.each do |rec|
    dataset = rec[0]
    errors  = rec[1]

    total_errors += errors.size

    puts
    puts "==== #{dataset} ===="

    print_errors( errors )
  end

  ## note: let's stop processing pipeline if any errors found!!!
  if total_errors > 0
    puts "#{total_errors} error(s) total; please fix"
    exit 1
  end
end  ## method lint

