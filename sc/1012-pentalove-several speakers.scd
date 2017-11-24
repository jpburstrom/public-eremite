(
SynthDef(\testtone, {
    Out.ar(\outbus.kr(0, 0), SinOsc.ar(\freq.kr(440)) * EnvGen.kr(Env.perc, 1, \amp.kr(0.1), doneAction:2));
}).add
);

Pbindef(\pentaLove, \instrument, \testtone, \scale, Scale.minorPentatonic, \root, 1, \degree, Pwhite(2, 11), \dur, Pxrand([0.125, 0.25, 0.5], inf), \outbus, 6).play(quant:1)

Pbindef(\pentaLove, \instrument, 'reduce.nice', \scale, Scale.majorPentatonic, \octave, 5, \root, Pwhite(3, 3), \degree, Pwhite(0, 10), \dur, Pxrand([0.25, 0.5, 1, 2], inf) * 0.5, \outbus, Pxrand([0,1,2,5,6], inf), \release, 1, \db, nil).set(\amp, 0.01).gui

Pbindef(\pentaLove).stop

Pbindf(~base, \freq, 100).play(quant:1)



AbstractCue(\vox_table2).play;
AbstractCue(\vox_table2).stop;

SynthDef("reduce.nice",
    { arg outbus=0;
        var snd = Splay.ar(Mix.fill(32, { |i| SinOsc.ar(\freq.kr(200) * (i+3)) * (1-(i/16)) }), 1, 0.1 );
        snd = snd * EnvGen.kr(Env.perc(\attack.kr(0), \release.kr(0.1), \amp.kr(1)), doneAction:2);
        snd = BLowPass4.ar(snd, 1000, 0.9);
        //OffsetOut.ar(0, snd);
        OffsetOut.ar(outbus, snd)
    }
).add;
