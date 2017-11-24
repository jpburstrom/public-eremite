SynthDef("reduce.nice",
    { arg outbus=0;
        var snd = Mix(Mix.fill(32, { |i| SinOsc.ar(\freq.kr(200) * (i+3)) * (1-(i/16)) })) * 0.1 ;
        snd = snd * EnvGen.kr(Env.perc(\attack.kr(0), \release.kr(0.1), \amp.kr(1)), doneAction:2);
        snd = BLowPass4.ar(snd, 1000, 0.9);
        //OffsetOut.ar(0, snd);
        OffsetOut.ar(outbus, snd)
    }
).add;

(
Pdef(\pentaLove, Pbind(
    \instrument, 'reduce.nice',
    \scale, Scale.minorPentatonic,
    \octave, Prand((5..6), inf),
    \root, 7,
    //Do root 99 times, then freak out
    \degree, Pn(0, 99) ++ Pxrand([0,1,2], inf),
    \dur, Pxrand([0.25, 0.5, 1], inf) * (Pseg([4, 0.25], 120) ++ Pn(0.5)),
    \outbus, Pxrand([0,1,2,5,6], inf),
    \release, 1,
    \amp, -28.dbamp,
    \stretch, 2
    )
);
);

(
Pdef(\pentaLove2, Pbind(
    \instrument, 'reduce.nice',
    \scale, Scale.minorPentatonic,
    \octave, Prand((5..6), inf),
    \root, 7,
    //Do root 99 times, then freak out
    \degree, 2,
    \dur, Pxrand([0.25, 0.5, 1], inf) * 0.25,
    \outbus, Pxrand([0,1,2,5,6], inf),
    \release, 1,
    \amp, Pseg([-24, -80], 55).dbamp,
    \stretch, 2
    )
);
);



