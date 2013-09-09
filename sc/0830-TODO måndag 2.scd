// 4 timmar
// Välj en kolumn
// Utgå från synth i förra övningen
// Skapa en ndef för varje ord, utgå från föregående när du gör den nya
// Skapa den tänkt för duration (om möjligt)
// Använd ca 4 minuter per ndef

// 0,09	transparence	shadow	unreal
(
Ndef(\transparence,
    {
        var freq = \freq.kr(200);
        var snd = Mix.fill(40, { VarSaw.ar(freq * LFNoise2.kr(0.1).range(0.5, 1.5), 0, LFNoise2.kr(0.1).range(0, 1)) }) * 0.3.dup;
        var ffreq = \timbre.kr(0.8).linexp(0, 1, 20, 20000);
        snd = BLowPass4.ar(snd, 800, 1);
        snd;
    }
).play();
)

// 0,06	discussing	selling	eyes
(
Ndef(\eyes,
    {
        var freq = [300,400,500,600, 700, 800];
        var snd = Splay.ar(Mix.fill(10, { VarSaw.ar(freq * LFNoise2.kr(0.1).range(0.95, 1.05), 0, 0.5) }), 1, 0.2 );
        var ffreq = \timbre.kr(0.8).linexp(0, 1, 20, 20000);
        snd = BLowPass4.ar(snd, 900, 1);
        snd;
    }
).play;
)

// 0,08	screw	resistance	willpower
(
Ndef(\resistance,
    {
        var freq = [300,400,500,600, 700, 800] * 0.5;
        var snd = Splay.ar(Mix.fill(10, { VarSaw.ar(freq * LFNoise2.kr(0.1).range(0.95, 1.05), 0, 0.5) }), 1, 0.2 );
        var ffreq = \timbre.kr(0.8).linexp(0, 1, 20, 20000);
        snd = snd * LFSaw.ar(Ndef(\tempo).kr * 8);
        snd = BLowPass4.ar(snd, 900, 1);

    }

).play;
)


// 0,09	showing	stranger	garden
(
Ndef(\stranger,
    {
        var freq = [300,400,500,600, 700, 800] * 3 * LFNoise2.kr(0.1).range(1, 1.3);
        var snd = Splay.ar(Mix.fill(10, { VarSaw.ar(freq * LFNoise2.kr(0.1).range(0.95, 1.05), 0, 0.5) }), 1, 0.2 );
        var ffreq = \timbre.kr(0.8).linexp(0, 1, 20, 20000);
        snd = snd * LFSaw.ar(10) * LFSaw.ar(10.2) + snd;
        snd = BLowPass4.ar(snd, 4800, 0.2);
    }

).play;
)

// 0,04	rotation	wind	fighting
(
Ndef(\wind,
    {
        var freq = [300,400,500,600, 700, 800] * 3 * LFNoise2.kr(0.1).range(1, 1.3);
        var snd = Splay.ar(Mix.fill(1, { WhiteNoise.ar(0.1) }), 1, 0.2 );
        var ffreq = \timbre.kr(0.8).linexp(0, 1, 20, 20000);
        //snd = snd * LFSaw.ar(10) * LFSaw.ar(10.2) + snd;
        snd = Mix.fill(8, { BLowPass4.ar(snd, LFNoise2.ar(Rand(0.2, 0.6)).exprange(400, 1600), 0.2) });
    }

).play;
)

// 0,57	friendly	training	evolution
(
Ndef(\evolution,
    {
        var freq = [300,400,500,600, 700, 800] * 3 * LFNoise2.kr(0.1).range(1, 1.3);
        var snd = Splay.ar(Mix.fill(8, { Saw.ar(Rand(10, 18)) }), 1, 0.2 );
        var ffreq = \timbre.kr(0.8).linexp(0, 1, 20, 20000);
        snd = snd * XLine.kr(0.2, 1, 57);
        //snd = snd * LFSaw.ar(10) * LFSaw.ar(10.2) + snd;
        snd = Mix.fill(1, { BLowPass4.ar(snd, LFNoise2.ar(Rand(0.2, 0.6)).exprange(400, 1600), 0.2) });
    }
).play;
)

// 0,05	embarrassed	avoiding	hesitation
(
Ndef(\avoiding,

    {
        var snd = Splay.ar(Mix.fill(10, { Saw.ar(LFNoise2.kr(1).range(30, 104)) }), 1, 0.2 );
        //snd = snd * LFSaw.ar(10) * LFSaw.ar(10.2) + snd;
        snd = BLowPass4.ar(snd, LFNoise2.ar(Rand(0.2, 0.6)).exprange(400, 500), 0.2);
    }

).play;
)

// 0,07	living	leading	image
(
Ndef(\image,

    {
        var snd = Splay.ar(Mix.fill(10, { Saw.ar(LFNoise2.kr(1).range(30, 104)) }), 1, 0.2 );
        snd = snd + Mix(SinOscFB.ar([ 455, 461, 479, 490, 492, 521, 537, 541, 542, 548 ], LFNoise2.ar(1).range(0, 0.2), 0.1));
        snd = BHiPass4.ar(snd, LFNoise2.ar(Rand(0.2, 0.6)).exprange(400, 500), 0.2);
    }


).play;
)

// 0,07	magic	confusion	distracting
(
Ndef(\confusion,
    {
        var snd = Splay.ar(Mix.fill(10, { Saw.ar(LFNoise2.kr(1).range(100, 104)) }), 1, 0.08 );
        snd = snd + Mix(SinOscFB.ar([ 455, 461, 479, 490, 492, 521, 537, 541, 542, 548 ].collect { |i| i * LFNoise1.kr(10).range(1, 1.6) } , LFNoise2.ar(1).range(0, 0.2), 0.1));
        snd = BHiPass4.ar(snd, LFNoise2.ar(Rand(0.2, 0.6)).exprange(100, 500), 0.2);
    }

).play;
)

// 0,06	breathing	heat	impatience
(
Ndef(\heat,
    {
        var snd = Splay.ar(Mix.fill(100, { Saw.ar(LFNoise2.kr(1).range(10, 1004)) }), 1, 0.08 );
        snd = BLowPass4.ar(snd, LFNoise2.ar(Rand(0.2, 0.6)).exprange(10000, 15000), 0.2);
    }
).play;
)

// 0,07	incredible	surprise	weight of head
(
Ndef(\weight_of_head,
    {
        var snd = Splay.ar(Mix.fill(10, { Saw.ar(LFNoise2.kr(1).range(10, 104)) }), 1, 0.8 );
        snd = snd * Decay.ar(Dust.ar(1), 1);
        snd = BLowPass4.ar(snd, LFNoise2.ar(Rand(0.2, 0.6)).exprange(2000, 2500), 0.2);
    }
).play;
)

// 0,15	distance	mistrust	disorientated
(
Ndef(\distance,
    {
        var snd = Splay.ar(Mix.fill(30, { Saw.ar(LFNoise0.kr(0.2).range(40, 404)) }), 1, 0.8 );
        snd = snd * Decay.ar(Impulse.ar(Ndef(\tempo).kr * 2), 3 / Ndef(\tempo).kr );
        snd = BLowPass4.ar(snd, LFNoise2.ar(Rand(0.2, 0.6)).exprange(2000, 5500), 0.4);
    }

).play;
)


// 0,03	alive	diving	divided
(
Ndef(\alive,
    {
        var snd = Splay.ar(Mix.fill(12, { |i| Saw.ar(50 * ((i * 2)+1)) }), 1, 0.8 );
        snd = snd * Decay.ar((Impulse.ar(2) * 0.5) + (Impulse.ar(3) * 0.5) + (Impulse.ar(5) * 0.25), 1);
        snd = BLowPass4.ar(snd, LFNoise2.ar(Rand(0.2, 0.6)).exprange(200, 5500), 0.4);
    }

).play;
)

// 0,06	question	trust	experience
(
Ndef(\experience,
    {
        var snd = Splay.ar(Mix.fill(16, { |i| Saw.ar(50 * (i+3)) * (1-(i/16)) }), 1, 0.8 );
        snd = snd * Decay.ar((Impulse.ar(1.2) * 0.5) + (Impulse.ar(6) * 0.5) + (Impulse.ar(5) * 0.25), 2);
        snd = BLowPass4.ar(snd, 10000, 0.4);
    }

).play;
)

// 0,44	insect	double	hole
(
Ndef(\insect,
    {
        var snd = Splay.ar(Mix.fill(16, { |i| Saw.ar(150 * (i+3)) * (1-(i/16)) }), 1, 0.8 );
        snd = snd * Decay.ar((Impulse.ar(1.2) * LFNoise2.ar(10).range(0.5, 2)) + (Impulse.ar(12) * 0.5) + (Impulse.ar(100) * 0.25), 0.1);
        snd = BLowPass4.ar(snd, 10000, 0.4);
    }
).play;
)

// 0,07	pointing	manipulating	attack
(
Ndef(\attack,
    {
        var snd = Splay.ar(Mix.fill(32, { |i| SinOsc.ar(200 * (i+3)) * (1-(i/16)) }), 1, 0.8 );
        snd = snd * Decay.ar(Impulse.ar(1.2, 0.25) + Impulse.ar(1.2, 0), 0.1);
        snd = BLowPass4.ar(snd, 10000, 0.4);
    }
).play;
)

// 0,06	flow	feeling	wave
(
Ndef(\flow,
    {
        var snd = Splay.ar(Mix.fill(2, { |i| SinOsc.ar(50 * (i+3)) * (1-(i/16)) }), 1, 0.8 );
        snd = snd * Decay.ar(Impulse.ar(1, 0.01) + Impulse.ar(10, 0), LFNoise2.kr(2).exprange(0.1, 1));
        snd = BLowPass4.ar(snd, 1000, 0.1);
    }
).play;
)

// 0,02	working	comfortable	calm
(
Ndef(\calm,
    {
        var snd = Splay.ar(Mix.fill(5, { |i| SinOsc.ar(45 * (i+3)) * (1-(i/16)) }), 1, 0.8 );
        snd = snd * Decay.ar(Impulse.ar(45, 0), LFNoise2.kr(2).exprange(0.1, 0.2));
        snd = BLowPass4.ar(snd, LFNoise2.kr(0.1).range(1000, 3000), 0.2);
    }
).play;
)

// 0,03	resolving	time	problem
(
Ndef(\problem,
    {
        var snd = Splay.ar(Mix.fill(5, { |i| SinOsc.ar(45 * (i+3)) * (1-(i/16)) }), 1, 0.8 );
        snd = snd * EnvGen.ar(Env.linen(0.1, 0, 0, curve:\sin), Dust.ar(5));
        snd = BLowPass4.ar(snd, LFNoise2.kr(0.1).range(1000, 3000), 0.2);
    }
).play;
)

//-----------------------
// CONTINUE
//-----------------------

// 0,04	shape	open	strength
(
Ndef(\

).play;
)

// 0,11	sticky	matter	confrontation
(
Ndef(\

).play;
)

// 0,20	tender	bored	nostalgic
(
Ndef(\

).play;
)

// 0,50	offering	snake	tentation
(
Ndef(\

).play;
)

// 0,09	impulse	leaving	lack of understanding
(
Ndef(\

).play;
)

// 0,03	creature	mutation	leaping
(
Ndef(\

).play;
)

// 0,06	freeze	stone	crystallization
(
Ndef(\

).play;
)

// 0,07	following	out of touch with reality	escape
(
Ndef(\

).play;
)

//----------------------------
// IN THE WINDOW
//----------------------------

// 0,01	lying in wait	reaction	fiery 	99
(
Ndef(\

).play;
)

// 0,01	straight	flight	there
(
Ndef(\

).play;
)

// 0,06	gravity	melting	sternum
(
Ndef(\

).play;
)

// 0,04	weird	cold	locked
(
Ndef(\

).play;
)

// 0,08	martial	challenge	Tarantino's movie
(
Ndef(\

).play;
)

// 0,04	jive	social	 smiling
(
Ndef(\

).play;
)

// 0,04	emergency	wondering	above
(
Ndef(\

).play;
)

// 0,02	roots	exploring	concealing
(
Ndef(\

).play;
)

// 0,09	singing	 laughing	young
(
Ndef(\

).play;
)

// 0,07	thinking about	lost	drawing
(
Ndef(\

).play;
)

// 0,02	famous	giving up	no way
(
Ndef(\

).play;
)

// 0,02	extreme	catching	determinated
(
Ndef(\

).play;
)

// 0,44	sitting	melancholy	liver
(
Ndef(\

).play;
)

// 0,01	foot	warm	control
(
Ndef(\

).play;
)

// 0,01	measuring	noticing	serenity
(
Ndef(\

).play;
)

// 0,06	strong	landlubber	diving
(
Ndef(\

).play;
)

// 0,01	trying	patience	detachment
(
Ndef(\

).play;
)

// 0,03	control	puppet	closing
(
Ndef(\

).play;
)

// 0,07	talking	watching	mirror
(
Ndef(\

).play;
)

// 0,00	curled up	cocoon	rapper
(
Ndef(\

).play;
)

// 0,07	ice	indecision	tearing out
(
Ndef(\

).play;
)

// 0,03	monkey	nature	discovering
(
Ndef(\

).play;
)

// 0,01	playing	reaching	underground
(
Ndef(\

).play;
)

// 0,07	kid	laughing	illogical
(
Ndef(\

).play;
)

// 0,10	throw	confidence	hasty
(
Ndef(\

).play;
)

// 0,05	quick	tunnel	inertia
(
Ndef(\

).play;
)

// 0,04	walking	sagging	letting go
(
Ndef(\

).play;
)

// 0,44	voice	fullness	giving
(
Ndef(\

).play;
)

// 0,11	gliding	water	going back
(
Ndef(\

).play;
)

// 0,04	pretty girl	ingenuousness	Nabokov
(
Ndef(\

).play;
)

// 0,06	deaf	inside	funny
(
Ndef(\

).play;
)

// 0,06	difficult	wishing	being unknown
(
Ndef(\

).play;
)

// 0,03	precise	doubt	concentrate
(
Ndef(\

).play;
)

// (end)