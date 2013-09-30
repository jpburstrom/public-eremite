//Talgoxe
(
SynthDef(\parusMajor, {
    Out.ar(\outbus.kr(0), SinOsc.ar(\freq.kr(440) * EnvGen.kr(Env([\glide.kr(1), 1], \sustain.kr(1) )))
    * EnvGen.kr(
        Env.asr(\attack.kr(0.01), \amp.kr(1), \release.kr(0.01), \curve.kr(-4)),
        \gate.kr(1), doneAction:2
    ));
}).add;
)
(
Pseq([
    Pbind(
        \instrument, \parusMajor,
        \test, p { arg ev;
            var i = 0;
            var max = 8;
            loop {
                i.postln;
                if (i == max) {
                    nil.yield;
                };
                i.yield;
                i = i + 1;
            }
        },
        \dur, Plazy({
            //TODO: don't repeat 3
            var rep = [8,6,3].wchoose([4,2,1].normalizeSum) * Pwhite(0.98, 1.02);
            0.25.repeat(rep)
        }),
        \legato, 0.4,
        \freq, Pseq([#[4349, 4143, 4521, 4780], 3531], inf) * 1,
        \db, Pseq([[-10, -14, -21, -26], -9], inf) - 12,
        \attack, Pseq([#[0.06, 0.06, 0.04, 0.01], 0.04], inf),
        \glide, Pseq([1.03, 0.97], inf),
        \release, 0.05,
        \curve, 0
    ),
    Pbind(\type, \rest, \dur, Pwhite(2.25, 15, 1))
], inf).play
)

//Gök
(
SynthDef(\cuculus, { arg pattack=1, pdecay=1, patime=0.1, pdtime=0.1;
    var psustain = \sustain.kr(1);
    var freq;
    patime = patime * psustain;
    pdtime = pdtime * psustain;
    psustain = (psustain - patime - pdtime).max(0);
    freq = \freq.kr(440) * EnvGen.kr(Env([pattack,1,1,pdecay], [patime, psustain, pdtime]));

    Out.ar(\outbus.kr(0),
        SinOsc.ar(freq) + PinkNoise.ar(0.03)
        * EnvGen.kr(
            Env.asr(\attack.kr(0.01), \amp.kr(1), \release.kr(0.01), \curve.kr(-4)),
            \gate.kr(1), doneAction:2
        ) ! 2
    );
}).add;
);

SynthDef.wrap

(
Pseq([
    Pbind(
        \instrument, \cuculus,
        \dur, 0.3,
        \amp, 1,
        \legato, Pseq([0.2, 0.55]),
        \midinote, Pseq([75.5, 72]),
        \attack, Pseq([0.3, 0.2]),
        \release, 0.1,
        \pattack, Pseq([0.97, 0.99]),
        \patime, Pseq([0.2, 1]),
        \pdtime, 0.2,
        \pdecay, Pseq([0.95, 1])
    ),
    Pbind(\type, \rest, \dur, Pwhite(0.7, 0.9, 1))
    ], inf
    ).play
);



// gråsparv
(
Pbind(
    \instrument, \cuculus,
    \delta, Phprand(1.551, 2.1),
    \lag, [0, 0.01],
    \dur, 0.171,
    \midinote, [106, 106.5] * Pwhite(0.99, 1.01),
    \db, -10,
    \attack, 0.07,
    \decay, 0.07,
    \pattack, Pwhite(0.6, 0.7),
    \patime, 0.43,
    \pdecay, Pwhite(0.6, 0.7),
    \pdtime, 0.28
).play
)

// björktrast
// koltrast

//Första fras
(
Pbind(
    \instrument, \cuculus,
    \dur, Pseq([0.3, 0.4, 0.5]),
    \freq, Pseq([1937.dup, 2174.dup, [2572, 2620]]),
    \strum, Pwhite(0.01, 0.05),
    \patime, Pseq([0.5, 0.5, 0.2]),
    \pattack, Pseq([[1.374, 1.170], [0.9, 0.94], [0.78, 0.80]]),
    \pdecay, Pseq([1,1, 0.78]),
    \pdtime, Pseq([0,0,[0.24, 0.5]]),
    \attack, 0.1,
    \decay, 0.1,
    \legato, Pseq([0.6, 0.5, 0.8]),
).play
)

//Drill
(
Pbind(
    \instrument, \cuculus,
    \dur, Pseq([0.03, 0.05], inf) * Pwhite(0.9, 1.1) * 0.7,
    \legato, 1.5,
    \midinote, Pseq([116.5, 111], inf) ,
    \db, -10,
    \attack, 0.1,
    \decay, 0.1,
    \pattack, 0.8 * Pwhite(0.9, 1.1),
    \patime, 0.4,
    \pdecay, 1.1 * Pwhite(0.9, 1.1),
    \pdtime, 0.2
).fin(8).play
)

//Drill 2
(
Pbind(
    \instrument, \cuculus,
    \dur, Pwhite(0.01, 0.02),
    \legato, 1.5,
    \freq, p { var x = { 2300.rrand(4000) } ! 10; loop { x.yield } } * Pwhite(1, 2),
    \db, -18 ,
    \attack, 0.2,
    \decay, 0.1,
    \pattack, 0.8 * Pwhite(0.9, 1.1),
    \patime, 0.1,
    \pdecay, 1.1 * Pwhite(0.9, 1.1),
    \pdtime, 0.2
).finDur(0.2).trace.play
)



Pwhite.new ! 10

// orre
// tjäder
// stor hackspett
// rödhuvad hackspett
(
SynthDef(\hackspett, {
    var snd, wood = (
        'kfreq': #[ 1, 2.777, 7.378, 15.377 ],
        'kamp': #[ 0.08, 0.02, 0.02, 0.016 ],
        'kres': #[ 1.0, 0.99799196787149, 0.99799196787149, 0.99397590361446 ],
    ),
    wood2 = (
        'kfreq': #[ 1, 1.777, 2.378, 3.377 ],
        'kamp': #[ 0.08, 0.02, 0.02, 0.016 ],
        'kres': #[ 1.0, 0.99799196787149, 0.99799196787149, 0.99397590361446 ],
    );

    snd = (5 * HPF.ar(Decay.ar(Impulse.ar(\speed.kr(20)), 1), 1000)).softclip;
    snd = Klank.ar(`[wood2.kfreq, wood2.kamp * \preamp.kr(0.1), wood2.kres], snd, \freq.kr(500), 0, \wetness.kr(0.1)).distort
    * Linen.kr(\gate.kr(1), \attack.kr(0), \amp.kr(1), \release.kr(0), doneAction:2);
    OffsetOut.ar(\out.kr(0), snd.dup);
}).add
)
(instrument:\hackspett).play

(

Pdef(\hacktest, Pbind(
    \instrument, \hackspett,
    \note, [0, 3, 12],
    \strum, 0.001,
    \octave, 6,
    \db, -3,
    \dur, 2,
    \speed, 2 * Pseg([5, 10, 5], 2.05, \exp, inf),
    \legato, 1,
    \release, 0,
    \attack, 0.01,
    \wetness, Pn(Pn(0.1, 10) ++ 0.3),
    \preamp, Pwhite(0.1, 0.5)
)).play(quant:1)

)

(

Pdef(\hacktest2, Pbind(
    \instrument, \hackspett,
    \note, 1,
    \strum, 0.0001,
    \octave, 4,
    \db, -3,
    \dur, 0.5,
    \legato, 1,
    \release, 0.01,
    \attack, 0.01,
    \speed, Prand([10, 15, 20], inf),
    \wetness, Pn(Pn(0.1, 10) ++ 0.3),
    \preamp, Pwhite(0.1, 0.9)
)).play

)


Pn(Pn(0.5, 10) ++ 2).asStream.nextN(14)

Pdef(\hacktest2).stop


// skogsduva
// blåmes
// domherre
// talltita
// storspov
// dvärguv
// (ripa)

