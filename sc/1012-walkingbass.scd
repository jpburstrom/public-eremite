SynthDef(\bass, {
    var snd = SinOsc.ar(\freq.kr) * EnvGen.kr(Env.perc(\attack.kr(0.01), \release.kr(1), \amp.kr), doneAction:2);
    Out.ar(\outbus.kr, snd);
    }
).add;
(
Pbindef(\walking,
    \instrument, \bass,
    \dur, 0.25,
    \note, Pshuf((0..11), inf),
    \release, 0.4,
    \outbus, [0,1],
    \octave, Pwhite(3, 4).stutter(Pwhite(3, 4))
).play
)
s.prepareForRecord
s.record
s.stopRecording;

Server