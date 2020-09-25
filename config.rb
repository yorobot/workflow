
###################
## mods
## -- champions league mods
MODS = {
'Arsenal   | Arsenal FC'    => 'Arsenal, ENG',
'Liverpool | Liverpool FC'  => 'Liverpool, ENG',
'Barcelona'                 => 'Barcelona, ESP',
'Valencia'                  => 'Valencia, ESP'
}


##########################
## seasons
SEASON_LATEST = ['2018/19', '2019',
                 '2019/20', '2020',
                 '2020/21']

## for all start with 2010/11 season for now
SEASON_ALL    = ['2010/11',
                 '2011/12',
                 '2012/13',
                 '2013/14',
                 '2014/15',
                 '2015/16',
                 '2016/17',
                 '2017/18',
                 '2018/19', '2019',
                 '2019/20', '2020']


##########################
## datasets

DATASETS = {
  at:         { path: './austria' }, ## domestic clubs
  de:         { path: './deutschland' },
  eng:        { path: './england' },
  es:         { path: './espana' },
  it:         { path: './italy' },
  fr:         { path: './france' },
  world:      { path: './world' }, # incl. netherlands, portugal, switzerland, turkey, etc.

  br:         { path: './brazil' },
  mx:         { path: './mexico' },
  ## note: reserve cl for country code for Chile!! - why? why not?
  europe_cl:  { path: './europe-champions-league', mods: MODS },

  euro:       { path: './euro-cup' },
  worldcup:   { path: './world-cup' },
}


###
# todo/check: rename to/use MIRRORS instead - why? why not?
DATASETS_CSV = {
  at:         { path: './austria' },
  de:         { path: './deutschland' },
  eng:        { path: './england' },
  es:         { path: './espana' },
  be:         { path: './belgium' },

  mx:         { path: './mexico' },

  world:      { path: './world' },

  ## add more
  ## - europe-champions-league
  ## - major-soccer-league
  ## - ...
}



