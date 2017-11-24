//PREPARE
(
"/Volumes/HD2/projects/eremite/kod/sc/1009-reduce-sketch.scd".load;
"/Volumes/HD2/projects/eremite/kod/lib/patterns/birds.scd".load;
"/Volumes/HD2/projects/eremite/kod/sc/0906-vibro-gui.scd".load;

SFCue.fromFile("/Volumes/HD2/projects/eremite/render/bell.wav", \bell, { ~volume = 0.5; ~quant = 1 }).load;
SFCue.fromFile("/Volumes/HD2/projects/eremite/render/bebop-test.wav", \bebop, { ~quant = 1 }).load;
SFCue.fromFile("/Volumes/HD2/projects/eremite/render/speak-realtid.wav", \realtid, { ~volume = 0.1 }).load;
SFCue.fromFile("/Volumes/HD2/projects/eremite/render/speak-har det hänt.wav", \hardet, { ~volume = 0.1 }).load;

MyPhones.watch.makeGui;
Ndef(\zero, { { PinkNoise.ar }.dup * 0.01 } );
Ndef(\forestamb, { Pan2.ar(HPF.ar( PinkNoise.ar, LFNoise2.ar(1).exprange(440, 880)) * 0.02, -0.6) } );
)
MyPhones.unwatch;
//Pre-run:
//Test speakers
//Test phones
//Test microphones * 2

//Overture:
Ndef(\forestamb).play(fadeTime:2); Pdef(\parus).play
Ndef(\forestamb).stop(fadeTime:10);

//REDUCE
Tempo.bpm = 60

Pdef(\parus).play
Pdef(\parus).stop;
Pdef(\cuculus).stop

s.meter

Ndef(\forestamb).play(fadeTime:2);
Pdef(\parus).stop;
Ndef(\forestamb).stop(fadeTime:10);

//START REDUCE
~baseplay = [~base.play(quant:1)]; Pdef(\parus).stop; Ndef(\forestamb).stop(fadeTime:10); Pdef(\parus).stop; Pdef(\cuculus).stop


~playing = ~playing.add(PatternConductor(~sources.choose, quant:1).play)
Pdef('reduce.longnotes').play

SampleCue(\bell).play;

Pfin(8, Pdef(\parus)).play(quant:1);


Pdef('reduce.longnotes').stop; ~playing.do(_.stop()); ~playing = nil;
SFCue(\bell, { ~outbus = 0; ~volume = 0.7 }).play

q.ch.audience.play(Pdef('reduce.longnotes'));
//q.ch.lamp.play(Pdef('reduce.longnotes'));

(
//START BEBOP
//SFCue(\bell, { ~outbus = 0; ~volume = 0.7 }).play;
TempoClock.default.play( {
    Pdef('reduce.longnotes').stop; ~playing.do(_.stop()); ~playing = nil; ~baseplay.stop;

}, 1);
SFCue(\bebop2).play;
)
(
//END BEBOP
SFCue(\bebop2).stop; //FIXME: quant
~playing = ~playing.add(PatternConductor(~sources.choose, quant:2).play);
10.do { ~playing = ~playing.add(PatternConductor(~sources.choose, quant:2).play) };
Pdef('reduce.longnotes').play
)

Pbind(\dur, 4).play(quant:4)
SFCue(\bebop2).fadeOut = 10
Ndef(\zero).stop(fadeTime:10);

SFCue(\bebop2).use {
    (~stopQuant ? ~quant).postln
}
Quant



//---->>>>> QLAB: MUZAK

//BEBOP
SampleCue(\bell).play;
SFCue(\realtid).play;
SFCue(\hardet).play;


//---->>>>> QLAB: BEBOP


~vibro.makeGui

Ndef(\forestamb).play(fadeTime:20);
//Fågel på citationstecken
Pfindur(12, Pdef(\parus)).play;
Pdef(\cuculus).play;
Pdef(\hackspett);

Pdef(\cuculus).stop;

Pdef(\parus).stop;
Pdef(\hackspett).stop


Ndef(\forestamb).stop(fadeTime:30);
Ndef(\forestamb).stop(fadeTime:3);
//

//---->>>>> QLAB: ZIMMER


Pdef(\parus).stop;
Pdef(\cuculus).stop; Pdef(\hackspett).stop;


