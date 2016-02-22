;;INTA 4742/6742 CX4232 CSE6742
;;Spring 2016
;;==================NOTES===================
;; =========Instructor Comments=========
;; be careful of too many variables
;; IRG defensive? How would those have had a tangiable effect on the outcome of the battle? ONe thing we want to think about when we're doing more recent battles
;; is as technically gets more advanced, communciations technology has a bigger role in the battles. that's one of the challenges for one of the more modern battles.
;; If we have other data and examples to talk about, this is more data and motivation for what we should model and we should try to compare and contrast what we have.
;; the more
;; =========Class Today=========
;; we're goign to do background research into what battle we're doing
;; how did we get here, what's happenening the world, what are we tryign to accmomplish, going throught he timeline of the battle
;; what occured when, what were the decision points for the battle, identify decision points and opporunties . Look at who was involved and
;; what were the types of soldiers and equipment that were involved. Cristicsms of the battle that happened afterware. This can all go in
;; story board of what happened. POSSIBLE PRESENTATION NEXT WEEK?
;; second element - conception plans for the model - what's goign to be important to actually put in
;; =========Research Question=========
;; Broadly - impact of technology
;; narrowly - invest in new technology/sights/etc
;; ==================END NOTES==================

globals [sand]  ;; Assume sand is flat after a point...
breed [m1a1s m1a1] ;; US Army M1A1
breed [t72s t72] ;; Iraqi Republican Guard T-72

m1a1s-own [hp thermal_sights turret_stab gps]       ;; both t72s and m1a1s have options for hit points, thermal sights, turrent stabilization, and GPS
t72s-own [hp thermal_sights turret_stab gps]       ;; both t72s and m1a1s have options for hit points, thermal sights, turrent stabilization, and GPS

to setup
  clear-all
  ask patches [ set pcolor brown ]
  setup-m1a1s   ;; create the m1a1s, then initialize their variables
  setup-t72s ;; create the t72s, then initialize their variables
  setup-technology
  reset-ticks
end

to setup-m1a1s
  set-default-shape m1a1s "m1a1" ;; make m1a1s their own shape
  let current-m1a1s 1 ;;initialize counter
  ;;initailize loop and let it: create n number of m1a1s with size 5, color blue, facing EAST and in a line, increment counter
  while [current-m1a1s <= (initial-number-m1a1 / 2)]
  [ create-m1a1s 1 [set color blue set size 5 setxy lead_m1a1_x_cor - 2.5 lead_m1a1_y_cor - ((5 * current-m1a1s)) set heading 90 ]
    create-m1a1s 1 [set color blue set size 5 setxy lead_m1a1_x_cor - 2.5 lead_m1a1_y_cor + ((5 * current-m1a1s)) set heading 90 ]
    set current-m1a1s current-m1a1s + 1
  ]
  ;;if we have an even number of M1A1s we need to make the line accordingly.
  let initial-number-m1a1-mod initial-number-m1a1 - 1
  if initial-number-m1a1 mod 2 = 0 [ask m1a1 initial-number-m1a1-mod [die] ] ;; mod 2
  ;;create the LEAD m1a1
  create-m1a1s 1 [set color white set size 5 setxy lead_m1a1_x_cor lead_m1a1_y_cor set heading 90]
  ;;set thermal_sights 0
  ;;set turret_stab 0
  ;;set gps 0

end


to setup-t72s
  set-default-shape t72s "t72" ;; make t72s their own shape
  let current-t72s 1 ;;initialize counter
  ;;initailize loop and let it: create n number of t72s with size 5, color blue, facing WEST and in a line, increment counter
  while [current-t72s <= (initial-number-t72 / 2)]
  [ create-t72s 1 [set color red set size 5 setxy lead_t72_x_cor + 2.5 lead_t72_y_cor - ((5 * current-t72s)) set heading 270 ]
    create-t72s 1 [set color red set size 5 setxy lead_t72_x_cor + 2.5 lead_t72_y_cor + ((5 * current-t72s)) set heading 270 ]
    set current-t72s current-t72s + 1
  ]
  ;;if we have an even number of T72s we need to make the line accordingly.
  let initial-number-t72-mod initial-number-t72 - 1
  if initial-number-t72 mod 2 = 0 [ask t72 initial-number-t72-mod [die] ] ;; mod 2
  ;;create the front T-72
  create-t72s 1 [set color green set size 5 setxy lead_t72_x_cor lead_t72_y_cor set heading 270]
  ;;set thermal_sights 0
  ;;set turret_stab 0
  ;;set gps 0

end

to setup-technology
  ;;in here we'll setup up our technology variables
  ;; note for all this the point of the model isn't to see if the technology should be IMPROVED at all, it's to see if a
  ;; tangible difference exists for having the technology in the first place.
  if M1A1_Thermal_Sights = True  [
    let i 0
    while [i < initial-number-m1a1]
    [
      ask m1a1s [set thermal_sights 1]
      set i i + 1
    ]
  ]
    if M1A1_Turret_Stablization = True  [
    let i 0
    while [i < initial-number-m1a1]
    [
      ask m1a1s [set turret_stab 1]
      set i i + 1
    ]
  ]
      if M1A1_GPS = True  [
    let i 0
    while [i < initial-number-m1a1]
    [
      ask m1a1s [set gps 1]
      set i i + 1
    ]
  ]
      ;;now we do the same thing for the T72s
      if T72_Thermal_Sights = True  [
    let i 0
    while [i < initial-number-t72]
    [
      ask t72s [set thermal_sights 1]
      set i i + 1
    ]
  ]
    if T72_Turret_Stablization = True  [
    let i 0
    while [i < initial-number-t72]
    [
      ask t72s [set turret_stab 1]
      set i i + 1
    ]
  ]
      if T72_GPS = True  [
    let i 0
    while [i < initial-number-t72]
    [
      ask t72s [set gps 1]
      set i i + 1
    ]
  ]



end



;;TO DO -
; use layout-circle to arraange the T-72s at some point

to go
  ;;if not any? turtles [ stop ]
  ask m1a1s
  [
    move
    death
    ;;reproduce-m1a1s
  ]
  ask t72s
  [
    move
    ;;set energy energy - 1  ;; t72s lose energy as they move
    ;;catch-m1a1s
    death
    ;;reproduce-t72s
  ]
end

to move  ;; turtle procedure
  rt random 50
  lt random 50
  fd 1
end


;;to reproduce-t72s  ;; t72s procedure
;;  if random-float 100 < t72s-reproduce [  ;; throw "dice" to see if you will reproduce
;;   set energy (energy / 2)               ;; divide energy between parent and offspring
;;    hatch 1 [ rt random-float 360 fd 1 ]  ;; hatch an offspring and move it forward 1 step
;;  ]
;;end

;;to catch-m1a1s  ;; t72s procedure
;;  let prey one-of m1a1s-here                    ;; grab a random m1a1s
;;  if prey != nobody                             ;; did we get one?  if so,
;;    [ ask prey [ die ]                          ;; kill it
;;      set energy energy + t72s-gain-from-food ] ;; get energy from eating
;;end

to death  ;; turtle procedure
  ;;when energy dips below zero, die
  if hp < 0 [ die ]
end

;;to display-labels
;;  ask turtles [ set label "" ]
;;  if show-energy? [
;;    ask t72s [ set label round energy ]
;;  ]
;;end

;;to setup-aggregate
;;  set-current-plot "populations"
;;  clear-plot
;;  ;; call procedure generated by aggregate modeler
;;  system-dynamics-setup
;;  system-dynamics-do-plot
;;end

;;to step-aggregate
;;  ;; each agent tick is DT=1
;;  repeat ( 1 / dt ) [ system-dynamics-go ]
;;end

;;to compare
;;  go
;;  step-aggregate
;; set-current-plot "populations"
;;  system-dynamics-do-plot
;; update-plots
;;  display-labels
;;end


; Copyright 2005 Uri Wilensky.
; See Info tab for full copyright and license.
@#$#@#$#@
GRAPHICS-WINDOW
350
10
1370
1051
50
50
10.0
1
14
1
1
1
0
1
1
1
-50
50
-50
50
0
0
1
ticks
30.0

TEXTBOX
8
80
148
99
Sheep settings
11
0.0
0

TEXTBOX
186
80
299
98
Wolf settings
11
0.0
0

TEXTBOX
104
10
254
28
Agent Model
11
0.0
0

BUTTON
38
35
101
68
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
118
49
181
82
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
5
129
194
162
initial-number-m1a1
initial-number-m1a1
0
50
11
1
1
m1a1
HORIZONTAL

SLIDER
3
169
175
202
initial-number-t72
initial-number-t72
0
50
29
1
1
t72
HORIZONTAL

SLIDER
3
216
175
249
lead_m1a1_x_cor
lead_m1a1_x_cor
min-pxcor
max-pxcor
-20
1
1
NIL
HORIZONTAL

SLIDER
3
257
175
290
lead_m1a1_y_cor
lead_m1a1_y_cor
min-pycor
max-pycor
0
1
1
NIL
HORIZONTAL

SLIDER
3
295
175
328
lead_t72_x_cor
lead_t72_x_cor
min-pxcor
max-pxcor
20
1
1
NIL
HORIZONTAL

SLIDER
1
338
173
371
lead_t72_y_cor
lead_t72_y_cor
min-pycor
max-pycor
0
1
1
NIL
HORIZONTAL

SWITCH
2
376
180
409
M1A1_Thermal_Sights
M1A1_Thermal_Sights
0
1
-1000

SWITCH
1
415
206
448
M1A1_Turret_Stablization
M1A1_Turret_Stablization
0
1
-1000

SWITCH
3
456
119
489
M1A1_GPS
M1A1_GPS
0
1
-1000

SWITCH
224
377
391
410
T72_Thermal_Sights
T72_Thermal_Sights
1
1
-1000

SWITCH
221
427
416
460
T72_Turret_Stablization
T72_Turret_Stablization
1
1
-1000

SWITCH
215
475
320
508
T72_GPS
T72_GPS
1
1
-1000

@#$#@#$#@
## WHAT IS IT?

This is a model of the Battle of 73 Easting during Gulf War I in February 1991.

## HOW TO USE IT
Set the position of the lead US Army M1A1 and the lead Iraqi Republican Guard T-72. By default, these positions are indicative of the historic location of the battle.


## THINGS TO NOTICE


## THINGS TO TRY



## NETLOGO FEATURES


## RELATED MODELS



## CREDITS AND REFERENCES
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

m1a1
true
1
Rectangle -13345367 true false 90 75 210 240
Rectangle -13345367 true false 135 15 165 75

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Rectangle -1 true true 166 225 195 285
Rectangle -1 true true 62 225 90 285
Rectangle -1 true true 30 75 210 225
Circle -1 true true 135 -30 150
Circle -7500403 true false 180 76 116

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

t72
true
1
Rectangle -2674135 true true 90 75 210 240
Rectangle -2674135 true true 135 15 165 75

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Rectangle -7500403 true true 195 106 285 150
Rectangle -7500403 true true 195 90 255 105
Polygon -7500403 true true 240 90 217 44 196 90
Polygon -16777216 true false 234 89 218 59 203 89
Rectangle -1 true false 240 93 252 105
Rectangle -16777216 true false 242 96 249 104
Rectangle -16777216 true false 241 125 285 139
Polygon -1 true false 285 125 277 138 269 125
Polygon -1 true false 269 140 262 125 256 140
Rectangle -7500403 true true 45 120 195 195
Rectangle -7500403 true true 45 114 185 120
Rectangle -7500403 true true 165 195 180 270
Rectangle -7500403 true true 60 195 75 270
Polygon -7500403 true true 45 105 15 30 15 75 45 150 60 120

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3
@#$#@#$#@
setup
setup-aggregate
repeat 75 [ go step-aggregate ]
@#$#@#$#@
0.001
    org.nlogo.sdm.gui.AggregateDrawing 1
        org.nlogo.sdm.gui.ReservoirFigure "attributes" "attributes" 1 "FillColor" "Color" 192 192 192 15 105 30 30
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

m1a1_spawn
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 45 150 240 150

@#$#@#$#@
0
@#$#@#$#@
