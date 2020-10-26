##
##
=begin
rake:
-r, --require MODULE     Require MODULE before executing rakefile.
ruby:
-rlibrary       require the library before executing your script
=end



## todo/fix: use a different name LintExtension or such - why? why not?
## module LintHelper   ## todo/check: rename to/use sportdb helper or such - why? why not?
##    wrap in module (or use global methods) - why? why not?
##
##  -r startup.rb or
##     start.rb   or
##     autoconf.rb or
##     auto.rb or
##     init.rb or
##     profile.rb or
##     lib.rb or
##     boot.rb or
##     helper.rb
##     env.rb
##     environment.rb
##     ...




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



def do_lint( datasets )
  total_errors = 0
  total_buf = String.new( '' )

  datasets.each do |key,h|
    name   = h[:name]
    path   = "#{Mono.root}/openfootball/#{name}"

    kwargs = {}
    kwargs[:mods] = h[:mods]  if h[:mods]

    buf, errors = SportDb::PackageLinter.lint( path, **kwargs )

    total_errors += errors.size

    total_buf << "\n"
    total_buf << "==== #{name} ====\n"
    total_buf << build_errors( errors )

    ## save
    # out_path = "#{path}/.build/conf.txt"
    out_path = "#{Mono.real_path('yorobot/logs')}/lint.#{key}.txt"
    File.open( out_path , 'w:utf-8' ) do |f|
      f.write( buf )
    end
  end


  puts total_buf

  out_path = "#{Mono.real_path('yorobot/logs')}/lint.all.txt"
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
end  ## method do_lint

