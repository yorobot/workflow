
CACHE_REPO = "@footballcsv/cache.footballdata"


step [:sync, :clone] do
  Mono.sync( CACHE_REPO )
end


step [:publish, :pub, :push] do
  msg = "auto-update week #{Date.today.cweek}"

  Mono.open( CACHE_REPO ) do |proj|
    puts "check for changes in >#{Dir.pwd}<..."
    if proj.changes?
      proj.add( "." )
      proj.commit( msg )
      proj.push
    else
      puts '  - no changes -'
    end
  end
end



step [:download, :dl] do
  Webget.config.sleep = 1                       ## small csv datasets (wait/sleep 1000ms)
  Footballdata12xpert.download( start: '2019/20' )  ## note: start with 2019/20, 2020, 2020/21
end

step :convert do
  Footballdata12xpert.config.convert.out_dir = Mononame.real_path( CACHE_REPO )
  Footballdata12xpert.convert( start: '2019/20' )
end

