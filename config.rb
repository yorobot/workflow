

## champions league mods
MODS = {
'Arsenal   | Arsenal FC'    => 'Arsenal, ENG',
'Liverpool | Liverpool FC'  => 'Liverpool, ENG',
'Barcelona'                 => 'Barcelona, ESP',
'Valencia'                  => 'Valencia, ESP'
}


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

