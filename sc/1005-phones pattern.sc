(
var x = Pbind(
    \type, \phone,
    \phone, \PODx,
    \instrument, \parus,
    \latency, 1,
    \dur, 0.25,
    \attack, Pwhite(0, 0.2),
    \release, 0,
    \legato, Pwhite(0.1, 2),
    \db, Pseg([3, -44], Prand([0.75, 1.5], inf), \lin, inf) - 24,
    \degree, Pwhite(16, 21).stutter(Pwhite(2,3)),
);

Ptpar([
    0, x,
    8, Pchain(Pbind(\mtranspose, -7, \phone, \POD1), x),
    16, Pchain(Pbind(\mtranspose, 5, \phone, \POD2), x)
]).play(quant:1);
)


(
var z = Pbind(\type, \phone, \phone, \POD1, \instrument, \parus, \attack, 0, \release, 0, \dur, 0.4, \amp, 0.4, \sustain, 0.001, \freq, 2000);

Ptpar([
    0, z,
    0.2, Pbindf(z, \phone, \POD2),
    0.5, Pbindf(z, \phone, \PODx)
]).play
)

MyPhones.size = 3
MyPhones.debug(2)
MyPhones.watch.makeGui
MyPhones.unwatch
OSCFunc.trace

Window.new.fullScreen(true).background_(Color.blue).front