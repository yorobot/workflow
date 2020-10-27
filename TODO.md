# TODOs


- [ ]  add starting step to flow-lite !!!
       plus - step done in xx sec(s) or such - at the end!!!

``` ruby
       start_time = Time.now   ## todo: use Timer? t = Timer.start / stop / diff etc. - why? why not?

       ...
       end_time = Time.now
       diff_time = end_time - start_time
       puts "read_#{key}: done in #{diff_time} sec(s)"
```



- [ ]  check lint - logs get not saved to logs@yorobot ??? double check


- [ ]  use LogFile.open( ) or such
        to yorobot - why? why not?
---

lints to fix:

italy

```
!! ERROR: 2015-16/2-serieb.txt[1] - WARN: 1 unmatched lines: ["AC Cesena (1940-2018)    0-2  Bari"]
!! ERROR: 2013-14/2-serieb.txt[1] - WARN: 1 unmatched lines: ["AC Cesena (1940-2018)    0-2  Spezia"]
!! ERROR: 2017-18/2-serieb.txt[1] - WARN: 1 unmatched lines: ["AC Cesena (1940-2018)    0-2  Ascoli"]
```




## Notes

```
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
```

