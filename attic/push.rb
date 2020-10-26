require "gitti"

require_relative "./config"



def ssh_push_logs
  msg  = "auto-update week #{Date.today.cweek}"
  ## todo/fix: rename to logs or something why? why not?
  GitProject.open( './logs' ) do |proj|
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    end
  end
end


##  used by json export/generate task
# FOOTBALL_JSON_DIR = "./workflow.json"
# FOOTBALL_JSON_DIR = "./football.json"

def ssh_push_json
  msg  = "auto-update week #{Date.today.cweek}"

  GitProject.open( './football.json' ) do |proj|
    if proj.changes?
      proj.add( '.' )
      proj.commit( msg )
      proj.push
    end
  end
end


def ssh_push_csv
  msg  = "auto-update week #{Date.today.cweek}"

  names = DATASETS_CSV.map { |key,h| File.basename(h[:path]) }
  # e.g.
  # ['england',
  #  'deutschland',
  #  'espana']
  pp names

  names.each do |name|
    GitProject.open( "./#{name}.csv" ) do |proj|
      if proj.changes?
        proj.add( '.' )
        proj.commit( msg )
        proj.push
      end
    end
  end
end





if $PROGRAM_NAME == __FILE__
  if ARGV.size == 0
    ## run (try) all
    ssh_push_json()
    ssh_push_csv()
    ssh_push_logs()
  else
    ARGV.each do |arg|
      case arg
      when 'json' then ssh_push_json()
      when 'csv'  then ssh_push_csv()
      when 'logs' then ssh_push_logs()
      else
        puts "[push script] unknown argument >#{arg}<"
        exit 1
      end
    end
  end
end