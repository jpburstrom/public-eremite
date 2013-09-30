MIDISyncClock.init
s.latency = 0.05

Tempo.bpm = 100

MIDISyncClock.play({ Pbind().play}, [4, -0.1])

ReaperServer().stop

MIDISyncClock.tempo
MIDISyncClock.seconds

Pdef(\test, PReaper(Pbind())).play

//This should stop reaper
Pdef(\test).stop

Pdef(\test, PReaper(Pbind(\amp, 1, \dur, 0.25, \note, Pseries().fold(0, 2.75)), 0, 2@22.5)).play(quant:4)

//This should stop reaper
Pdef(\test).stop

ReaperServer().time(2@22)




(
Pdef(\moggga, Pbind(
    \freq, Pfuncn({ 3.collect(330.rrand(350)) }, inf),
    \amp, 0.3,
    \legato, 1,
    \dur, 3
)).play(quant:4)
)

s.quit