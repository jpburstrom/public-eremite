// 0,07	pointing	manipulating	attack
(
SynthDef("reduce.rhythm",
    { arg outbus=0;
        var snd = Splay.ar(Mix.fill(32, { |i| SinOsc.ar(\freq.kr(200) * (i+3)) * (1-(i/16)) }), 1, 0.1 );
        snd = snd * EnvGen.kr(Env.perc(\attack.kr(0), \release.kr(0.1), \amp.kr(1)), doneAction:2);
        snd = BLowPass4.ar(snd, 10000, 0.4);
        //OffsetOut.ar(0, snd);
        OffsetOut.ar(outbus, snd)
    }
).add;

//SampleCue.fromFile("/Volumes/HD2/projects/eremite/render/bell.wav", \bell).player.amp_(0.3).play

);


(
//BASE
~base = Pbind(
    \instrument, "reduce.rhythm",
    \dur, Pseq([0.25, 0.75], inf),
    //\lag, Pwhite(-0.01, 0.01),
    \freq, Pbrown(200, 210, 0.125),
    \release, Pwhite(0.05, 0.14).stutter(inf),
    \amp, 0.2,
);

~sources = [
    Pbind(
        \instrument, "reduce.rhythm",
        \dur, Pxrand([0.25, 0.75, 0.5], inf)  * Pwrand([1, 0.5], [0.9, 0.1], inf).stutter(4),
        //\lag, Pwhite(-0.01, 0.01),
        \degree, 1,
        \octave, 7,
        \release, 0.01,
        \amp, 0.1,
    ),
    Pbind(
        \instrument, "reduce.rhythm",
        \dur, Prand([0.5, 0.75], inf),
        \degree, Prand([2, 8], inf), //Pxrand([2,4,5], inf).stutter(Prand([8, 16, 24], inf)),
        \octave, 3,
        //\lag, Pwhite(-0.01, 0.01),
        \attack, Pwhite(0, 0.02),
        \release, Pwhite(0.01, 0.2),
        \amp, 0.1,
    ),
    Pbind(
        \instrument, "reduce.rhythm",
        \dur, Prand([0.75, 1], inf) ,
        \degree, 2,
        \octave, 3,
        //\lag, Pwhite(-0.01, 0.01),
        \release, Pwhite(0.01, 0.2),
        \amp, 0.1,
    ),

    Pbind(
        \instrument, "reduce.rhythm",
        \dur, Prand([0.75, 1], inf) * 0.5 ,
        \degree, 2,
        \octave, 4,
        //\lag, Pwhite(-0.01, 0.01),
        \release, Pwhite(0.01, 0.2),
        \amp, 0.1,
    )
];

Pbindef('reduce.longnotes',
    \instrument, "reduce.rhythm",
    \dur, Prand([2, 3, Rest(2), Rest(3)], inf) ,
    \degree, Pwhite(0, 4) * 4,
    \mtranspose, Pwhite(-0.5, 0.5),
    \octave, 2,
    \release, Pwhite(0.01, 0.2),
    \attack, 5,
    \release, 5,
    \amp, 0.01,
);

)



