;;INTA 4742/6742 CX4232 CSE6742
;;Spring 2016
;;==================NOTES==================
;; 3 Feb 2016
;; =========Group Discussion=========
;; model - training, IRG defenses, 
;; long tan battle reading? possibly use this as a basis for simulation and modeling
;; potentially model as a 'size of tank' quantity? cross section of tank? tank speed
;; Geography
;; what makes a tank a tank? Techincal mismatch between US and IRG, and decisions made by each army are good fodder 
;; 3000m effective range on the M1A1
;; =========Instructor Comments=========
;; be careful of to oman variables
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

;; TO-DO figure out how we're going to map elevation...see sand comment below 
globals [sand]  ;; track sand? Possibly make this elevation and have it linearly map onto hit chance?
;; initialize Iraq IRG and US Army ACR tanks
;; keep multiples plural, keep singular as 'a-'
breed [m1a1s a-m1a1] ;; US Army M1A1 
breed [t72s a-t72] ;; Iraqi Republican Guard T-72
breed [t55s a-t55] ;; Iraqi Republican Guard T-55 (possibly more 74 easting?)
;; we'll go ahead and put in place holders for british tanks, IRG infantry, and US Army M2A3s to add complexity later
;; breed [challengers a-challenger] ;; British Challenger Tank
;; breed [m2a3s a-m2a3] ;; US Army Bradley M2A3 IFV
;; breed [IRG_infantrys a-IRG_infantry] ;; Iraqi Republican Guard Infantry 
;; breed [M-60s a-M-60] ;; US Army 'old' M-60 Patton Tanks
;; breed [IRG_infantrys a-IRG_infantry] ;; US Army Bradley M2A3 IFV


;;OLD
turtles-own [speed accuracy night_vision armor troop_proficiency] ;; attempt to quantify tank attributes
patches-own [slowdown] ;; attempt to quantify what, if any, effect sand has (make patch do something different? )
	
to setup
  clear-all
  ask patches [ set pcolor green ]
  ;; check GRASS? switch.
  ;; if it is true, then grass grows and the sheep eat it
  ;; if it false, then the sheep don't need to eat
  if grass? [
    ask patches [
      set pcolor one-of [green brown]
      if-else pcolor = green
        [ set countdown grass-regrowth-time ]
        [ set countdown random grass-regrowth-time ] ;; initialize grass grow clocks randomly for brown patches
    ]
  ]
  set-default-shape sheep "sheep"
  create-sheep initial-number-sheep  ;; create the sheep, then initialize their variables
  [
    set color white
    set size 1.5  ;; easier to see
    set label-color blue - 2
    set energy random (2 * sheep-gain-from-food)
    setxy random-xcor random-ycor
  ]
  set-default-shape wolves "wolf"
  create-wolves initial-number-wolves  ;; create the wolves, then initialize their variables
  [
    set color black
    set size 2  ;; easier to see
    set energy random (2 * wolf-gain-from-food)
    setxy random-xcor random-ycor
  ]
  display-labels
  set grass count patches with [pcolor = green]
  reset-ticks
end

to go
  if not any? turtles [ stop ]
  ask sheep [
    move
    if grass? [
      set energy energy - 1  ;; deduct energy for sheep only if grass? switch is on
      eat-grass
    ]
    death
    reproduce-sheep
  ]
  ask wolves [
    move
    set energy energy - 1  ;; wolves lose energy as they move
    catch-sheep
    death
    reproduce-wolves
  ]
  if grass? [ ask patches [ grow-grass ] ]
  set grass count patches with [pcolor = green]
  tick
  display-labels
end

to move  ;; turtle procedure
  rt random 50
  lt random 50
  fd 1
end

to eat-grass  ;; sheep procedure
  ;; sheep eat grass, turn the patch brown
  if pcolor = green [
    set pcolor brown
    set energy energy + sheep-gain-from-food  ;; sheep gain energy by eating
  ]
end

to reproduce-sheep  ;; sheep procedure
  if random-float 100 < sheep-reproduce [  ;; throw "dice" to see if you will reproduce
    set energy (energy / 2)                ;; divide energy between parent and offspring
    hatch 1 [ rt random-float 360 fd 1 ]   ;; hatch an offspring and move it forward 1 step
  ]
end

to reproduce-wolves  ;; wolf procedure
  if random-float 100 < wolf-reproduce [  ;; throw "dice" to see if you will reproduce
    set energy (energy / 2)               ;; divide energy between parent and offspring
    hatch 1 [ rt random-float 360 fd 1 ]  ;; hatch an offspring and move it forward 1 step
  ]
end

to catch-sheep  ;; wolf procedure
  let prey one-of sheep-here                    ;; grab a random sheep
  if prey != nobody                             ;; did we get one?  if so,
    [ ask prey [ die ]                          ;; kill it
      set energy energy + wolf-gain-from-food ] ;; get energy from eating
end

to death  ;; turtle procedure
  ;; when energy dips below zero, die
  if energy < 0 [ die ]
end

to grow-grass  ;; patch procedure
  ;; countdown on brown patches: if reach 0, grow some grass
  if pcolor = brown [
    ifelse countdown <= 0
      [ set pcolor green
        set countdown grass-regrowth-time ]
      [ set countdown countdown - 1 ]
  ]
end

to display-labels
  ask turtles [ set label "" ]
  if show-energy? [
    ask wolves [ set label round energy ]
    if grass? [ ask sheep [ set label round energy ] ]
  ]
end
