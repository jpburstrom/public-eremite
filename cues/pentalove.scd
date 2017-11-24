SynthDef("reduce.nice",
    { arg outbus=0;
        var snd = Splay.ar(Mix.fill(32, { |i| SinOsc.ar(\freq.kr(200) * (i+3)) * (1-(i/16)) }), 1, 0.1 );
        snd = snd * EnvGen.kr(Env.perc(\attack.kr(0), \release.kr(0.1), \amp.kr(1)), doneAction:2);
        snd = BLowPass4.ar(snd, 1000, 0.9);
        //OffsetOut.ar(0, snd);
        OffsetOut.ar(outbus, snd)
    }
).add;

(
Pbindef(\pentaLove,
    \instrument, 'reduce.nice',
    \scale, Scale.minorPentatonic,
    \octave, Prand((5..6), inf),
    \root, 7,
    //Do root 99 times, then freak out
    \degree, Pn(0, 99) ++ Pxrand([0,1,2], inf),
    \dur, Pxrand([0.25, 0.5, 1], inf) * (Pseg([4, 0.25], 120) ++ Pn(0.5)),
    \outbus, Pxrand([0,1,2,5,6], inf),
    \release, 1,
    \amp, -16.dbamp
).stop;
);

SpawnerCue(\pentaLove, {
    ~player = Pdef(\pentaLove);
});
