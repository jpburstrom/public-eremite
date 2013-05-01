

{ Mix(BPF.ar(Impulse.ar(2), 60, 20)) ! 2}.play

{ Mix(SinOsc.ar([50, 67].midicps )) ! 2 * 0.4}.play

Ndef(\low, { SinOsc.ar([51.4, 52, 50, 38].midicps , mul:0.1) }).play
Ndef(\low).stop
(
Tdef(\hello, {
    7.do {
        Ndef(\high, { SinOsc.ar(88.0.rrand(99).midicps, 0, 0.1) }).play;
        0.05.wait;
    };
    Ndef(\high).stop
}).play
)
Tdef(\hello).stop;

(
SynthDef(\sin2, {
    var snd;
    snd = SinOsc.ar(\freq.kr, \amp.kr) * EnvGen.ar(Env.perc(0, \sustain.kr), doneAction:2);
    Out.ar(0, snd!2);
})


(
SynthDef(\test, {
    var snd;
    snd = Pulse.ar(\freq.kr, \width.kr(0.5), \amp.kr) * EnvGen.ar(Env.perc(0, \sustain.kr), doneAction:2);
    Out.ar(0, snd!2);
}).add
)
(
SynthDef(\impulsar, { arg gate=1;
    var snd;
    snd = Decay.ar(Impulse.ar(\freq.kr, \amp.kr), 0.01) * EnvGen.ar(Env.asr(0, 1, \release.kr), gate, doneAction:2);
    Out.ar(0, snd ! 2);
}).add
)
(
SynthDef(\sin, {
    var snd;
    snd = SinOsc.ar(\freq.kr, \width.kr(0.5), \amp.kr) * EnvGen.ar(Env.perc(0, \sustain.kr), doneAction:2);
    Out.ar(0, snd!2);
}).add
)

(
Pbindef(\test,
    \instrument, \sin,
    \scale, Scale.dorian,
    \degree, Pseq([0, 4, 1, 2, 6, 3], inf),
    \width, Pbrown(0.1, 0.9),
    \octave, Pwhite(3, 4),
    \legato, 2.2,
    \dur, Prand([0.2, 0.1], inf),
    \amp, 1
).stop
)

Tempo.bpm = 40

(
Pbindef(\test2,
    \instrument, \test,
    \scale, Scale.phrygian,
    \root, 1,
    \degree, Pseq([0, 1, 2, 6, 3], inf),
    \octave, Pwhite(2, 3),
    \width, Pbrown(0.1, 0.9),
    \dur, 0.8,
    \legato, 0.6,
    \amp, 1
).stop
)

(
Pbindef(\test3,
    \instrument, \test2,
    \scale, Scale.dorian,
    \degree, Pseq([0, 4, 1, 6, 3], inf),
    \width, Pbrown(0.1, 0.9),
    \octave, Pwhite(3, 4),
    \dur, Prand([0.4, 0.05], inf),
    \legato, Pwhite(1.0, 2.0),
    \lag, 0.02,
    \amp, 1
).play
)


(
Pbindef(\test4,
    \instrument, \impulsar,
    \scale, Scale.lydian,
    \degree, Pxrand([[0, 3], [3, 4], [1, 6], [2, 6], [6, 3]], inf),
    \width, Pbrown(0.1, 0.9),
    \octave, Pwhite(4, 5),
    \dur, Prand([0.1, 0.2], inf),
    \legato, Pwhite(0.2, 0.3),
    \release, 0.2,
    \lag, 0.02,
    \amp, 1
).play
)