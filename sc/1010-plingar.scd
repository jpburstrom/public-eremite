//Idé:
//Ett nätverk av små pling och instick som kan ligga som ett lager ovanpå //under befintling musik
//Den kunde också fungera som melodi -- långsam, hämtad från "huvudtemat"




(
SynthDef(\klankTest, {
    var freqs = \freqs.kr([1200, 2500, 3800, 5100]);
    var snd = DynKlank.ar(`[freqs, 0.1, \ring.kr(1)], Decay.ar(Impulse.ar(0), 0.01)) *
    EnvGen.kr(Env.perc(0, \ring.kr(1)), 1, \amp.kr, doneAction:2);

    Out.ar(\outbus.kr(0), snd);
}).add;

)

(
Pbind(
    \instrument, \klankTest,
    \freqs, Pfunc({ Ref(#[1200, 2500, 3800, 5100].collect(_ * 0.95.rrand(1.05))) }).stutter(8),
    \outbus, Pxrand((1..4), inf),
    \delta, Pwhite(3, 6),
    \ring, Pwhite(1.0, 4)

).play(quant:1);
)
(
Pbindef(\rings,
    \instrument, \klankTest,
    \freqs, Pxrand([
        //`[350, 360, 480, 1500],
        `[1200, 2500, 3800, 5100],
        `[1234, 2345, 3456, 4567],
        ], inf
    ),
    \outbus, Pxrand((1..5), inf),
    \delta, Pxrand((12..32), inf) * 0.25,
    \ring, Pwhite(1.0, 4),
    \db, -24

).play(quant:1)

)

p { #[1200, 2500, 3800, 5100].collect(_ * 0.95.rrand(1.05)) }
