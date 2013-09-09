// Att göra måndag:
// --------------------
// 30 minuter:
// Skapa en synth där man kan påverka följande:
// - freq 20-20000
// - envelope (self-releasing)
// - timbre 0-1
(
SynthDef(\eremiteSynth, {

    var freq = \freq.kr(400);
    var snd = Mix.fill(4, { Saw.ar(freq * Rand(0.999, 1.001)) }) * 0.3;
    var ffreq = \timbre.kr(0.8).linexp(0, 1, 20, 20000);
    snd = BLowPass4.ar(snd, ffreq+freq, 1);
    snd = snd * EnvGen.ar(Env.asr(\attack.kr(0.01), \amp.kr(1), \release.kr(0.1), \curve.kr(-4)), \gate.kr(1), doneAction:2);
    Out.ar(0, snd.dup);
}).add;
)
//
// 3 timmar:
// Kolla på score. Ca en minut per ord. Följ duration. 60 bpm.
// 1. Första kolumnen: rytmik.
// 2. Andra kolumnen: tonhöjd(er), timbre.
// 3. Tredje kolumnen: envelope

Tempo.bpm = 60;

// 0,09	transparence	shadow	unreal
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Prand([0.2, 0.6, 0.9, 0.3], inf),
    \midinote, Pseq([28, 30, 32, 36] + 12, inf),
    \timbre, 0.2,
    \attack, 1, \amp, Pwhite(0.2, 1), \release, 2, \curve, -4
).finDur(9)
.play;
)

// 0,06	discussing	selling	eyes
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.1, 0.15, 0.16], inf) * Pwhite(0.9, 1.1).stutter(3),
    \midinote, Pseq([65, 34], inf),
    \timbre, Pseq([0.2, 0.9], inf),
    \attack, Pwhite(0.0, 0.3), \amp, 1, \release, Pwhite(0,1), \curve, -4
).finDur(6)
.play;
)

// 0,08	screw	resistance	willpower
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([8,3]),
    \delta, 4,
    \midinote, Pseq([64, 67]),
    \timbre, 0.7,
    \attack, 3, \amp, 1, \release, 0.1, \curve, -4
).finDur(8)
.play;
)

// 0,09	showing	stranger	garden
(
Pbind(
    \instrument, \eremiteSynth, \dur, 1,
    \note, 0,
    \timbre, 0.5,
    \attack, 0.01, \amp, 1, \release, 0.1, \curve, -4
).finDur(9)
.play;
)

// 0,04	rotation	wind	fighting
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pbrown(0.2, 0.3),
    \note, Pseq([1,3,5], inf) + Pwhite(1, 6).stutter(3),
    \timbre, 0.1,
    \attack, Pwhite(0, 1), \amp, Pwhite(0.5, 1), \release, Pwhite(0, 1), \curve, -4
).finDur(4)
.play;
)

// 0,57	friendly	training	evolution
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.2, 0.1], inf) + Prand([0.2, 0.1], inf).stutter(2) ,
    \degree, Pwhite(0, 8),
    \timbre, Pbrown(0, 1.0, 0.07),
    \attack, Pseries(0, 0.01), \amp, 1, \release, Pseries(0, 0.01), \curve, -4
).finDur(57)
.play;
)

// 0,05	embarrassed	avoiding	hesitation
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([Pwhite(0.2, 0.32, 2), 0.4], inf),
    \freq, Pseq([50, 63], inf),
    \timbre, 0,
    \attack, 1, \amp, 1, \release, Pseq([0, Pn(0.9, 4)], inf), \curve, -4
).finDur(5)
.play;
)

// 0,07	living	leading	image
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pn(Pn(0.1, 4) ++ Pn(0.2, 1), inf),
    \note, Pseries(0, Pwhite(1, 2)).wrap(0, 32), //mirror
    \octave, 3,
    \timbre, Pseries(0, 0.02),
    \attack, Pseries(0, 0.02), \amp, 1, \release, 1, \curve, -4
).finDur(7)
.play;
)

// 0,07	magic	confusion	distracting
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.2, 8]),
    \note, [0, 2, 5, 6],
    \timbre, Pwhite(),
    \attack, 0, \amp, Pseq([0.1, 1], 1), \release, 1, \curve, -8
).finDur(7)
.play;
)

//PAUS


// 0,06	breathing	heat	impatience
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([2, 1.6], inf),
    \legato, 1,
    \midinote, Pseq([32, 41, 50], inf),
    \timbre, Pwhite(0.2, 0.6),
    \attack, 3, \amp, Pwhite(0.2, 1), \release, 0.01, \curve, -4
).finDur(6)
.play;
)

// 0,07	incredible	surprise	weight of head
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pn(Plazy({ Pn(0.05, 9) ++ Pstutter(1.rrand(3), Pn(0.2, 1)) }), inf),
    \note, Pkey(\dur) * 100,
    \timbre, 1 - (Pkey(\dur) * 5),
    \attack, (Pkey(\dur) * 10) - 0.5, \amp, 1, \release, (Pkey(\dur) * 1), \curve, -4
).finDur(7)
.play;
)

// 0,15	distance	mistrust	disorientated
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 10,
    \legato, 1,
    \midinote, 32,
    \timbre, 1,
    \attack, 10, \amp, 1, \release, 10, \curve, -8
).finDur(15)
.play;
)

// 0,03	alive	diving	divided
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pn(0.2, 5) ++ 0.3,
    \note, 8 - Pseq([0,2,5,6,8,5]),
    \timbre, Prand([0,2,5,6,8,5], 8) / 8,
    \attack, Pkey(\note) / Pkey(\timbre), \amp, 1,
    \release, (Pkey(\attack) / Pkey(\dur)).min(6).max(0.01), \curve, -4
).finDur(3)
.play;
)

// 0,06	question	trust	experience
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.15, Pwhite(0.3, 2, 1)], inf),
    \legato, 1,
    \note, Pn(Pseq([4,3]) + Pwhite(0, 12, 1)),
    \timbre, 0.7,
    \attack, 0.01, \amp, 1, \release, 2 - Pkey(\dur), \curve, -4
).finDur(6)
.play;
)

// 0,44	insect	double	hole
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pwhite(0.01, 0.06),
    \note, [0,1] * Pwhite(0, 12.0),
    \timbre, Pwhite(0.1, 0.5),
    \attack, 0.001, \amp, 1, \release, 0.5 - Pkey(\timbre), \curve, 0
).finDur(44)
.play;
)

// 0,07	pointing	manipulating	attack
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pgeom(1, 0.86).max(0.01),
    \note, Pseq([0,3], inf) + (Pkey(\dur) * 10),
    \timbre, 1 - Pkey(\dur),
    \attack, Pkey(\dur), \amp, 1, \release, 0.01, \curve, -4
).finDur(7)
.play;
)

// 0,06	flow	feeling	wave
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 0.3 * (1 + Pseries()),
    \midinote, Pxrand([56, 64, 54, 29], inf),
    \timbre, 0.1,
    \attack, Pkey(\dur) * 2, \amp, 1, \release, Pkey(\dur) * 2, \curve, -4
).finDur(6)
.play;
)

// 0,02	working	comfortable	calm
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pbrown(0.12, 0.15, 0.01),
    \note, [0,5],
    \octave, 4,
    \timbre, Pwhite(0.4, 0.45),
    \attack, 0.2, \amp, 1, \release, 0.2, \curve, -4
).finDur(2)
.play;
)

// 0,03	resolving	time	problem
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pgeom(0.01, 1.05),
    \freq, [40, 80],
    \timbre, 1,
    \attack, 0.0, \amp, Pwhite(0.0, 1), \release, 0, \curve, -4
).finDur(3)
.play;
)

// 0,04	shape	open	strength
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([1,2,3,5,8,13]) * 0.1,
    \degree, Pseq([0, 8], inf),
    \timbre, 0.9,
    \attack, 0, \amp, 1, \release, 1, \curve, -8
).finDur(4)
.play;
)

// 0,11	sticky	matter	confrontation
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pwhite(0.01, 0.2),
    \midinote, Pwhite(32, 34),
    \timbre, Pwhite(0.6, 1),
    \attack, Pseries(0, 0.01).wrap(0.01, 0.5), \amp, 1, \release, Pseries(0, 0.01).wrap(0.01, 0.5), \curve, -4
).finDur(11)
.play;
)

// 0,20	tender	bored	nostalgic
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.3, 0.3, 0.6, 0.9, 1.2], inf),
    \note, Pseries(0, Pwhite(-2, -1)).wrap(0, Pwhite(6, 12).stutter(6)),
    \timbre, Pbrown(0.4, 0.5),
    \attack, 0, \amp, 1, \release, 3, \curve, -4
).finDur(20)
.play;
)

// 0,50	offering	snake	tentation
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseries(1, 1.2),
    \note, Pseries().wrap(0, Pseries(1).stutter(Pseries(1))),
    \timbre, Pseries(0.1, 0.05),
    \attack, Pkey(\dur), \amp, 1, \release, Pkey(\dur), \curve, 0
).finDur(50)
.play;
)

// 0,09	impulse	leaving	lack of understanding
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseries(0.1, 0.4).wrap(0.1,0.5),
    \note, (1 + Pkey(\dur)) * (1 + Pseries(0, 0.2)),
    \timbre, Pwhite(0, 1),
    \attack, 0, \amp, 1, \release, 2, \curve, -4
).finDur(9)
.play;
)

// 0,03	creature	mutation	leaping
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pn(Pif(Pfunc({ 0.6.coin }), Pn(0.3, 1), Pn(0.6, 1))),
    \note, Penvir((n: 1), Pfuncn({ |ev| ~n = (~n + (ev.dur * 10)).fold(1,12)}, inf)),
    \timbre, Pn(Pn(0.2, 1).stutter(Pwhite(1,3)) ++ Pn(0.6, 1).stutter(Pwhite(1,4))),
    \attack, 0.01, \amp, 1, \release, 1.1, \curve, -4
).finDur(3)
.play;
)

// 0,06	freeze	stone	crystallization
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.1, 0.2], inf) * Pseries(1, 1.1).stutter(3),
    \midinote, 33,
    \timbre, Pwhite(0.1, 0.2),
    \attack, 0.0, \amp, Env.perc(0, 6, curve:-2), \release, 0, \curve, -4
).finDur(6)
.play;
)

P

// 0,07	following	out of touch with reality	escape
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pwhite(0.2, 0.3).stutter(Pseries(1)),
    \midinote, Pwhite(32, 88).stutter(2),
    \legato, 1,
    \timbre, Pseq([0.6, 0.1], inf),
    \attack, 0.1, \amp, 1, \release, Pseq([0.1, 3], inf), \curve, -4
).finDur(7)
.play;
)

//----------------------------
// IN THE WINDOW
//----------------------------

// 0,01	lying in wait	reaction	fiery 	99
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.96, 0.05]),
    \legato, 1,
    \note, Pseq([12, 1]),
    \timbre, Pseq([0.5, 0.9]),
    \attack, 0, \amp, Pseq([0.96, 0.4]), \release, Pseq([0.1, 0.1]), \curve, -4
).finDur(1)
.play;
)

// 0,01	straight	flight	there
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 0.2,
    \legato, 0.2,
    \note, Pseries(0, 3) + Pseries().stutter(2),
    \timbre, 0.2,
    \attack, 0.01, \amp, 1, \release, Env.perc(0, 1), \curve, -4
).finDur(1)
.play;
)

// 0,06	gravity	melting	sternum
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Env(#[0.4, 0.01], #[6], \exp),
    \legato, 1,
    \note, Pstep(Pwhite(0, 11), 0.3),
    \timbre, Env(#[0, 0.8], #[6]),
    \attack, 0.01, \amp, 1, \release, Pseq([0.1, 0.5, 1.9], inf) * Pkey(\dur), \curve, -4
).finDur(6)
.play;
)

// 0,04	weird	cold	locked
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pwhite(0, 0.02) + Pseq([0.2, 0.3], inf),
    \note, Prand([0,8], inf),
    \legato, 3,
    \timbre, 0.7,
    \attack, 0.5, \amp, Pwhite(0.2, 1), \release, 0.01, \curve, 0
).finDur(4)
.play;
)

// 0,08	martial	challenge	Tarantino's movie
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, (Pn(0.1, 4) ++ Pn(0.2, 2)).repeat(inf),
    \sustain, 0.08,
    \note, (Pseq([0,2,4,7,8], inf) + Pseries(0, 2).stutter(5) - Pseries().stutter(10)).fold(0,12),
    \timbre, Pseries(0, 0.12).fold(0, 1),
    \attack, 0.05, \amp, 1, \release, 1 - Pseries(0, 0.12).fold(0.01, 1), \curve, -4
).finDur(8)
.play;
)

// 0,04	jive	social	 smiling
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([2,1,2,3,3,1], inf) * 0.1,
    \note, Pxrand([0,4,7,9], inf),
    \octave, Pwhite(4,5),
    \timbre, Pseg(Pseq([0, 0.8], inf), 0.4),
    \attack, 0.01, \amp, 1, \release, 0.1, \curve, -4
).finDur(4)
.play;
)

// 0,04	emergency	wondering	above
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, (0.1.repeat(8) ++ 0.2).repeat(inf),
    \legato, 0.4,
    \note, Pseq([0,8,7,2], inf),
    \timbre, Pseq([0.3, 0.5], inf),
    \attack, Pseq([0.0, 0.5, 0.6], inf), \amp, 1, \release, Pseq([0.3, 0.5, 0.6], inf), \curve, -4
).finDur(4)
.play;
)

// 0,02	roots	exploring	concealing
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.4,0.25], inf),
    \legato, 0.6,
    \note, Pseries().fold(Pwhite(0, 5), Pwhite(6, 12)),
    \timbre, 0.1,
    \attack, 0.8, \amp, 1, \release, 0.1, \curve, -4
).finDur(2)
.play;
)

// 0,09	singing	 laughing	young
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Prand([0.2, 0.4], inf),
    \degree, Pseries(0, -1).wrap(0, 7),
    \timbre, 1,
    \attack, 0.01, \amp, 1, \release, 1, \curve, -4
).finDur(9)
.play;
)

// 0,07	thinking about	lost	drawing
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 1.1,
    \legato, Pseq([0.9, 0.4], inf),
    \midinote, 28,
    \timbre, 0.1,
    \attack, 0, \amp, 1, \release, Pseq([0.1, 0.9, 0.4], inf), \curve, -4
).finDur(7)
.play;
)

// 0,02	famous	giving up	no way
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 2/30,
    \legato, Ptime() / 2,
    \note, 2 - Ptime(),
    \timbre, 1 - (Ptime() / 2),
    \attack, 0.01, \amp, 1, \release, Ptime(), \curve, -4
).finDur(2)
.play;
)

// 0,02	extreme	catching	determinated
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseries(0.02, 0.02),
    \legato, 0.1,
    \note, Pstep(1 - Pseries(0, 2), 0.12),
    \timbre, 0.8,
    \attack, 0, \amp, 1, \release, 0.1, \curve, 4
).finDur(2)
.play;
)

// 0,44	sitting	melancholy	liver
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pwhite(5.0, 6),
    \legato, 1,
    \midinote, [56, 59.1, 62],
    \timbre, Pwhite(0.3, 0.34),
    \attack, Pwhite(3, 5.0), \amp, 1, \release, 1, \curve, 4
).finDur(44)
.play;
)

// 0,01	foot	warm	control
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.4, 0.45], inf),
    \legato, 0.3,
    \midinote, 4.collect { 45.rrand(45.4) },
    \timbre, 0.4,
    \attack, 0.09, \amp, 0.4, \release, 0.00, \curve, 5
).finDur(1)
.play;
)

// 0,01	measuring	noticing	serenity
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 1/9,
    \legato, 0.3,
    \note, Pseries(0, 2).fold(0, 2) + Pseq([0, 12], inf).stutter(2),
    \timbre, Ptime() * 0.4 + 0.2,
    \attack, 0, \amp, 1, \release, 1, \curve, -4
).finDur(1)
.play;
)

// 0,06	strong	landlubber	diving
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, (0.2.repeat(2) ++ 0.3).repeat(inf),
    \legato, 0.1,
    \note, [0, 2, 5] - 4,
    \timbre, 0.6,
    \attack, 0.1, \amp, 1, \release, Ptime() / 3, \curve, -4
).finDur(6)
.play;
)

// 0,01	trying	patience	detachment
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.1, 0.14], inf).stutter(2),
    \legato, 0.1,
    \degree, Pseries(), //Latch/Clutch/??
    \timbre, 0.9,
    \attack, 0.01, \amp, 1, \release, 0.01, \curve, -4
).finDur(1)
.play;
)

// 0,03	control	puppet	closing
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 0.2,
    \note, Pseq([0,2,0,5,0,2,0,3]),
    \legato, 1,
    \timbre, Pseg(Pseq([0.6, 0.0]), 2.5),
    \attack, 0.01, \amp, 1, \release, Pseg(Pseq([0.01, 3.7]), 2.5), \curve, -4
).finDur(3)
.play;
)

// 0,07	talking	watching	mirror
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pxrand([0.1, 0.13, 0.14, 0.18, 0.23], inf),
    \legato, Pwhite(0.4, 1),
    \note, Pwhite(0, 1.0) + Prand([0,5], inf),
    \timbre, Prand([0.2, 0.5], inf).stutter(4),
    \attack, 0.01, \amp, 1, \release, 1 - Pkey(\timbre), \curve, -4
).finDur(7)
.play;
)

// 0,00	curled up	cocoon	rapper
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 0.05,
    \legato, Prand([0.2, 0.9],inf),
    \note, Pseries(0, 1).wrap(0,1) * 12,
    \timbre, 1 - (Ptime() * 2),
    \attack, 0.01, \amp, 1, \release, (Ptime() * 4) + 0.1, \curve, -4
).finDur(0.5)
.play;
)

// 0,07	ice	indecision	tearing out
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 2,
    \legato, 0.2,
    \note, Pwhite(0, 3, 4) + Pseq([0, 8], inf).stutter(3),
    \timbre, Pwhite() * 0.4,
    \attack, 0, \amp, 1, \release, 5, \curve, -4
).finDur(7)
.play;
)

// 0,03	monkey	nature	discovering
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pwhite(0.1, 0.11) * 2,
    \legato, Pbrown(0.1, 1, 0.5),
    \freq, 100 * Pwhite(1, 12),
    \timbre, 0.7 - (Ptime() / 4),
    \attack, 0.01, \amp, 1, \release, Ptime() + 0.1, \curve, -4
).finDur(3)
.play;
)

// 0,01	playing	reaching	underground
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, (1 / Pseries(3,5)).max(0.01),
    \legato, 0.8,
    \note, Pseq([0, 14], inf),
    \timbre, 0.1,
    \attack, 0, \amp, Env.perc(0, 1, curve:8), \release, 0, \curve, -4
).finDur(1)
.play;
)

// 0,07	kid	laughing	illogical
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.15, 0.5], inf),
    \legato, Pseq([0.9, 0.2], inf),
    \note, Pseries(24, Pwhite(-1,-3)),
    \timbre, Pwhite(0,1.0),
    \attack, Pwhite(0,1.0), \amp, Pwhite(0,1.0), \release, Pwhite(0,1.0), \curve, -4
).finDur(7)
.play;
)

// 0,10	throw	confidence	hasty
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 0.04.repeat(10) ++ 10,
    \legato, 1,
    \note, Pseq([0,2,4,9], inf),
    \octave, Pseries(4).stutter(4),
    \timbre, 0.0.repeat(10) ++ 0.4,
    \attack, 0.01, \amp, 1, \release, 10.repeat(10) ++ 0.9, \curve, 6
).finDur(10)
.play;
)

// 0,05	quick	tunnel	inertia
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq(0.08 ! 6 ++ 1.0, inf),
    \legato, Pseq(0.4 ! 6 ++ 1, inf),
    \midinote, 30,
    \timbre, Pseries(0, 0.1).wrap(0, 0.7),
    \attack, 0.0, \amp, 1, \release, Pseq(0.4 ! 6 ++ 1, inf), \curve, -4
).finDur(5)
.play;
)
// 0,04	walking	sagging	letting go
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq(1 ! 1 ++ (0.04 ! 10), inf),
    \legato, 2,
    \midinote, [88, 80],
    \timbre, 0.0,
    \attack, 0, \amp, 1, \release, 1, \curve, -4
).finDur(4)
.play;
)

// 0,44	voice	fullness	giving
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.3, 0.2, 0.1], inf) * Pseries(1, 0.1).stutter(3),
    \legato, 0.1,
    \degree, Pseries(0, -1).fold(-24, 0),
    \timbre, 0.8,
    \attack, 0.01, \amp, 1, \release, Pbrown(0, 6), \curve, -4
).finDur(44)
.play;
)

// 0,11	gliding	water	going back
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseg([0.1, 0.4], repeats:inf),
    \legato, Pseg([0.1, 1], 0.3, repeats:inf),
    \midinote, Pwhite(20, 90),
    \timbre, 0.1,
    \attack, Pseq([0.5, 0.1], inf).stutter(12), \amp, 1, \release, Pseq([0.1, 3], inf).stutter(12), \curve, -0,
).finDur(11)
.play;
)

// 0,04	pretty girl	ingenuousness	Nabokov
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([0.2, 0.2, 0.2, 0.6], inf) * 0.3,
    \legato, 1,
    \note, Pseries(0, Pwhite(2,3)).fold(0, 33),
    \timbre, Pseq([0, 0.2], inf),
    \attack, 0.01, \amp, 1, \release, 2, \curve, -4
).finDur(4)
.play;
)

// 0,06	deaf	inside	funny
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, 1,
    \legato, 0.01,
    \note, [0,11] - 12,
    \lag, [0, 0.03],
    \timbre, [0.7, 0.6],
    \attack, 0.01, \amp, 1, \release, [0.1, 0.3], \curve, -4
).finDur(6)
.play;
)

// 0,06	difficult	wishing	being unknown
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq(8.collect { 0.1.rrand(0.2) }, inf),
    \note, Pfuncn({ 4.collect { 1.rrand(9) } }, inf).stutter(8),
    \legato, 0.1,
    \strum, 0.04,
    \timbre, Pwhite(0.0, 0.4),
    \attack, 0.01, \amp, 1, \release, (Pkey(\timbre) * 2) + 0.01, \curve, -4
).finDur(6)
.play;
)

// 0,03	precise	doubt	concentrate
(
Pbind(
    \instrument, \eremiteSynth,
    \dur, Pseq([1,1,2,2] * 0.1, inf),
    \legato, 0.1,
    \note, Pseq([5,7].dup, inf),
    \octave, [3,4],
    \strum, 0.1,
    \timbre, Pseg(Pseq([0.1, 0.5, 0.1], inf), repeats:inf),
    \attack, 0.01, \amp, 1, \release, Pkey(\timbre), \curve, -4
).finDur(3)
.play;
)
// (end)


