
(
SynthDef(\cymbal, {
	var lodriver, locutoffenv, hidriver, hicutoffenv, freqs, res, thwack;

    locutoffenv = EnvGen.ar(Env.perc(0, 1, curve: -8), \trig.tr) * 20000 + 10;
	lodriver = LPF.ar(WhiteNoise.ar(0.1), locutoffenv);

	hicutoffenv = 10001 - (EnvGen.ar(Env.perc(0, 2, curve: -8), \trig.tr) * 10000);
	hidriver = HPF.ar(WhiteNoise.ar(0.1), hicutoffenv);
	hidriver = hidriver * EnvGen.ar(Env.perc(0, 1, 0.25, curve: -8), \trig.tr);

    thwack = HPF.ar(EnvGen.ar(Env.perc(0,0.001,1), \trig.tr), 500);

	freqs  = {exprand(300, 15000)}.dup(100);
    //freqs = ~freqs;
    ~freqs = freqs;
	res    = Ringz.ar(hidriver + lodriver + thwack, freqs).mean;

    Out.ar(0, (((res * 1) + (lodriver * 1) + thwack).dup.tanh) * \amp.kr);

    //Out.ar(0, res);

    //Out.ar(0, thwack);
}).add;

SynthDef(\hihat, {
    Out.ar(0, HPF.ar(WhiteNoise.ar(\amp.kr(1)) * XLine.ar(1, 0.01, 0.2, doneAction:2).dup, 540))
}).add;


SynthDef(\bd, {
    Out.ar(0, (SinOscFB.ar(\freq.kr(80), 0.4) * XLine.ar(6 * \amp.kr(1), 0.01, \sustain.kr(0.2), doneAction:2)).dup)
}).add;


//z = Synth(\cymbal, [\trig, 1])

)

SynthDef(\cymbaltest, {
    Out.ar(0, WhiteNoise.ar(0.1) * EnvGen.ar(Env.perc(0, 1), \trig.tr));
}).add


(
//PdefAllGui();
Pdef(\cymbal, Pmono(\cymbal,
    \dur, Pwrand([Pseq([1]), Pseq([0.54, 0.46])], [1.6,1].normalizeSum, inf) / 4,
    \db, -24
));

Pdef(\hihat, Pbind(
    \instrument, \hihat,
    \dur, 0.25,
    \amp, Pseq([0.2, 1], inf) * 0.2,
    \timingOffset, -0.05,
));

)


(
Pdef(\bd, Pbind(
    \instrument, \bd,
    \dur, Pseq([3, 4, 5, 2, 6, 3, 4, 2], inf) * 0.25,
    \amp, Pwhite(0.2, 0.5, inf) * 0.05,
    \timingOffset, 0.05,
    \sustain, Pwhite(0.4, 2),
    \freq, Pwhite(60, 80)
));
)


Pdef(\cymbal).play; Pdef(\bd).play; Pdef(\hihat).play;
Pdef(\cymbal).stop; Pdef(\hihat).stop; Pdef(\bd).stop;

TempoClock.default.tempo = 1

Pdef(\hihat).stop; Pdef(\bd).stop;
Pdef(\hihat).play; Pdef(\bd).play;

Pdef(\empty, Pbind()).play
Pdef(\bd).play

Pdef(\empty).stop; Pdef(\bd).stop

Pdef(\cymbal2, Pdef(\cymbal).source);

Pdef(\cymbal2).play;

~freqs

z.set(\trig, 1)

(instrument:\cymbal).play
PmonoArtic
Tempo.bpm = 300
(
Pproto({
    ~fsynth = (type: \on, instrument: \cymbal).yield;
    ~fControl = [\set, ~fsynth[\id], ~fsynth[\msgFunc] ];
    },
    Pbind(
        #[type, id, msgfunc], Pkey(\fControl),
        \dur, Pwrand([Pseq([1]), Pseq([0.55, 0.45])], [2,1].normalizeSum, inf)
    ).trace
).play
)
{exprand(300, 20000)}.dup(100).ccopy


