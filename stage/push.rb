require "gitti"


def ssh_push_csv
  msg = "auto-update week #{Date.today.cweek}"

  GitProject.open( "./stage" ) do |proj|
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    end
  end
end




if $PROGRAM_NAME == __FILE__
  if ARGV.size == 0
    ## run (try) all
    ssh_push_csv()
  else
    ARGV.each do |arg|
      case arg
      when 'csv'  then ssh_push_csv()
      else
        puts "[push script] unknown argument >#{arg}<"
        exit 1
      end
    end
  end
end
