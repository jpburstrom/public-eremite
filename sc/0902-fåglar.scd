// björktrast
// gråsparv
// koltrast
// orre
// tjäder
// stor hackspett
// rödhuvad hackspett
// skogsduva
// blåmes
// domherre
// talltita
// gök
// storspov
// dvärguv
// talgoxe
// (ripa)

//Talgoxe
(
SynthDef(\parusMajor, {
    Out.ar(\outbus.kr(0), SinOsc.ar(\freq.kr(440) * EnvGen.kr(Env([\glide.kr(1), 1], \sustain.kr(1) )))
    * EnvGen.kr(
        Env.asr(\attack.kr(0.01), \amp.kr(1), \release.kr(0.01), \curve.kr(-4)),
        \gate.kr(1), doneAction:2
    ));
}).add
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
            var rep = [8,6,3].wchoose([4,2,1].normalizeSum);
            0.25.repeat(rep)
        }),
        \legato, 0.4,
        \freq, Pseq([#[4349, 4143, 4521, 4780], 3531], inf) * 1,
        \db, Pseq([[-10, -14, -21, -26], -9], inf),
        \attack, Pseq([#[0.06, 0.06, 0.04, 0.01], 0.04], inf),
        \glide, Pseq([1.03, 0.97], inf),
        \release, 0.05,
        \curve, 0
    ),
    Pbind(\type, \rest, \dur, Pwhite(2.25, 15, 1))
], inf).play
)