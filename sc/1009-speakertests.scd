{ Decay.ar(Impulse.ar(LFNoise2.ar(0.2).range(5, 10))) * (SinOsc.ar([250])) * GC(\testamp, 0.5, \amp).kr}.play(s, 4)



SynthDef(\sinperc, {
    Out.ar(\outbus.kr(4), SinOsc.ar(\freq.kr(440)) * EnvGen.kr(Env.perc(\attack.kr(0.01), \release.kr(1)), doneAction:2) * \amp.kr(1))
}).add

(
Pbindef(\test,
    \instrument, \sinperc,
    \degree, Pwhite(0, 7).clump(2),
    \dur, Prand([1, 2, 4], inf),

    \octave, 6,
    \db, -24,
    \outbus, 4,
    \release, 4
).play(quant:1)
)
Pdef(\test).stop


(
Pbindef(\test2,
    \instrument, \sinperc,
    \degree, Pwhite(0, 11).clump(3),
    \dur, Prand([1, 2, 4], inf),
    \outbus, 3,
    \amp, 0.1,
    \sustain, 1,
    \attack, 0,
    \release, 3
).play(quant:1)
)
Pdef(\test2).stop

(
Pbindef(\lamp,
    \instrument, \sinperc,
    \degree, Pwhite(0, 11),
    \dur, Prand([0.25, 0.5, 0.75], inf),
    \mtranspose, [0, 5],
    \octave, 6,
    \strum, 0.085,
    \outbus, 2,
    \amp, [0.2, 0.1],
    \release, Pwhite(0.1, 1)
).play(quant:1)
)

Pdef(\lamp).stop

(
Pbindef(\lamp2,
    \instrument, \sinperc,
    \degree, Pwhite(0, 11),
    \dur, Prand([0.25, 0.5, 0.75], inf),
    \mtranspose, [0, 5],
    \octave, 6,
    \strum, 0.005,
    \outbus, 5,
    \amp, [0.6, 0.6],
    \release, Pwhite(0.1, 1)
).play(quant:1)
)

Ndef(\bass2, { LPF.ar(Saw.ar(37)) * LFNoise2.kr(0.4).range(0.1, 0.6) * 1 }).play(7)

Ndef(\bass2).release(fadeTime:19)