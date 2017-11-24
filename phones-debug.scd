//TALGOXE
x = NetAddr("localhost", 9998);
x.sendMsg("/pdmsg", "auto",  "sparrow")
x.sendMsg("/pdmsg", "auto",  "cuculus")
x.sendMsg("/pdmsg", "auto",  "parus")

//STEP 1
MyPhones.watch;

(
MyPhones.phones[\PODx].sendMsg("/pdmsg", "auto", "parus");
MyPhones.phones[\POD1].sendMsg("/pdmsg", "auto", "parus");
MyPhones.phones[\POD2].sendMsg("/pdmsg", "auto", "sparrow");
MyPhones.phones[\POD3].sendMsg("/pdmsg", "auto", "cuculus")
);

MyPhones.unwatch
MyPhones.reload
(
Pdef(\parus,
    Pseq([
        Pbind(
            \type, \phone,
            \server, x,
            \instrument, \parus,
            \latency, 1,
            \test, p { arg ev;
                var i = 0;
                var max = 8;
                loop {
                    //i.postln;
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
            \db, Pseq([[-10, -14, -21, -26], -9], inf) + 3,
            \attack, Pseq([#[0.06, 0.06, 0.04, 0.01], 0.04], inf),
            \glide, Pseq([1.03, 0.97], inf),
            \release, 0.05,
            \curve, 0
        ),
        Pbind(\type, \rest, \dur, Pwhite(2.25, 15, 1))
], inf));
Pdef(\parus).stop
);

(
Pdef(\parus2,
    Pseq([
        Pbind(
            \type, \phone,
            \phone, \POD1,
            \instrument, \parus,
            \latency, 1,
            \test, p { arg ev;
                var i = 0;
                var max = 8;
                loop {
                    //i.postln;
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
            \db, Pseq([[-10, -14, -21, -26], -9], inf) + 3,
            \attack, Pseq([#[0.06, 0.06, 0.04, 0.01], 0.04], inf),
            \glide, Pseq([1.03, 0.97], inf),
            \release, 0.05,
            \curve, 0
        ),
        Pbind(\type, \rest, \dur, Pwhite(2.25, 15, 1))
], inf))
);

//GÖK
(
Pdef(\cuculus,
    Pn(
        Pseq([
            Plazy({ Pfin(3.rrand(8) * 2, Pseq([
                Pbind(
                    \type, \phone,
                    \server, x,

                    \instrument, \cuculus,
                    \dur, 0.3,
                    \amp, 0.95,
                    \legato, Pseq([0.1, 0.55]),
                    \midinote, Pseq([75.5, 72]),
                    \attack, Pseq([0.1, 0.12]),
                    \release, 0.1,
                    \pattack, Pseq([0.97, 0.99]),
                    \patime, Pseq([0.2, 1]),
                    \pdtime, 0.2,
                    \pdecay, Pseq([0.95, 1])
                ),
                Pbind(\type, \rest, \dur, Pwhite(0.77, 0.9, 1))
                ], inf
                )
            )}),
            Pbind(\type, \rest, \dur, Pwhite(4, 12, 1))
        ])
    )
).stop;
)



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
    OffsetOut.ar(\outbus.kr(0), snd);
}).add
);
(
Pbindef(\hackspett,
    \instrument, \hackspett,
    \outbus, 4,
    \preamp, 1,
    \dur, Phprand(0.3, 1.2),
    \delta, Pwhite(7, 20),
    \amp, 0.6
)
);
(
Pbindef(\hackspett_last,
    \instrument, \hackspett,
    \outbus, 4,
    \preamp, 1,
    \dur, Phprand(0.3, 1.2),
    \delta, Pwhite(7, 20),
    \amp, 0.5
)
);
(
Pdef(\sparrow, Pbind(
    \instrument, \cuculus,
    \type, \phone,
    \server, x,
    \delta, Phprand(1.551, 2.1) ,
    \lag, [0, 0.01],
    \dur, 1,
    \midinote, [106, 106.5] * Pwhite(0.99, 1.01),
    \legato, 0,
    \db, 0,
    \attack, 0.07,
    \pattack, 0.6,
    \patime, 0.2
)).stop;
)