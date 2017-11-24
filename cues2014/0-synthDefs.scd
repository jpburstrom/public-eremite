(
SynthDef("reduce.rhythm",
    { arg outbus=0;
        var snd = Mix(Mix.fill(32, { |i| SinOsc.ar(\freq.kr(200) * (i+3)) * (1-(i/16)) })) * 0.1;
        var adjustment = -6.dbamp;
        snd = snd * EnvGen.kr(Env.perc(\attack.kr(0), \release.kr(0.1), \amp.kr(1)), doneAction:2);
        snd = BLowPass4.ar(snd, 10000, 0.4);
        //OffsetOut.ar(0, snd);
        OffsetOut.ar(outbus, snd * adjustment) //F
    }
).add;
SynthDef(\hackspett_bell, {
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
    OffsetOut.ar(\outbus.kr(0), HPF.ar(snd, 400));
}).add;
);