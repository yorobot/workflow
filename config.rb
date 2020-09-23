
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



################
# club country repos
AT_DIR        = "./austria"
DE_DIR        = "./deutschland"
EN_DIR        = "./england"
ES_DIR        = "./espana"
IT_DIR        = "./italy"
FR_DIR        = "./france"
WORLD_DIR     = "./world"   # incl. netherlands, portugal, switzerland, turkey, etc.

BR_DIR        = "./brazil"
MX_DIR        = "./mexico"
EUROPE_CL_DIR = "./europe-champions-league"

# euro     = "#{OPENFOOTBALL_DIR}/euro-cup"
# worldcup = "#{OPENFOOTBALL_DIR}/world-cup"


DATASETS = {
             at:    { path: AT_DIR }, ## domestic clubs
             de:    { path: DE_DIR },
             en:    { path: EN_DIR },
             es:    { path: ES_DIR },
             it:    { path: IT_DIR },
             fr:    { path: FR_DIR },
#             world: { path: WORLD_DIR },

             mx:    { path: MX_DIR },
#             br:    { path: BR_DIR },
            ## note: reserve cl for country code for Chile!! - why? why not?
#             europe_cl:  { path: EUROPE_CL_DIR, mods: MODS },
}


###
# todo/check: rename to/use MIRRORS instead - why? why not?
DATASETS_CSV = {

}



