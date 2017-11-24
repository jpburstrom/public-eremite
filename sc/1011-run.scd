//PREPARE
(
"/Volumes/HD2/projects/eremite/kod/sc/1009-reduce-sketch.scd".load;
"/Volumes/HD2/projects/eremite/kod/lib/patterns/birds.scd".load;
"/Volumes/HD2/projects/eremite/kod/sc/0906-vibro-gui.scd".load;

SFCue.fromFile("/Volumes/HD2/projects/eremite/render/bell.wav", \bell, { ~volume = 0.3; ~quant = 1 }).load;
SFCue.fromFile("/Volumes/HD2/projects/eremite/render/bebop-test.wav", \bebop, { ~quant = 1 }).load;
SFCue.fromFile("/Volumes/HD2/projects/eremite/render/speak-realtid.wav", \realtid, { ~volume = 0.1 }).load;
SFCue.fromFile("/Volumes/HD2/projects/eremite/render/speak-har det hänt.wav", \hardet, { ~volume = 0.1 }).load;
MyPhones.watch.makeGui;
Ndef(\zero, { { PinkNoise.ar }.dup * 0.01 } );
Ndef(\forestamb, { Pan2.ar(HPF.ar( PinkNoise.ar, LFNoise2.ar(1).exprange(440, 880)) * 0.02, -0.6) } );
)
MyPhones.unwatch;

//REDUCE
Tempo.bpm = 90
Tempo.bpm = 60

Pdef(\parus).play
Pdef(\parus).stop
Pdef(\cuculus).stop

Ndef(\forestamb).play(fadeTime:2);
Pdef(\parus).stop;
Ndef(\forestamb).stop(fadeTime:10);

~baseplay = [~base.play(quant:1)]; Pdef(\parus).stop; Ndef(\forestamb).stop(fadeTime:10)
~playing = ~playing.add(PatternConductor(~sources.choose, quant:1).play)
Pdef('reduce.longnotes').play
Pdef('reduce.longnotes').stop; ~playing.do(_.stop()); ~playing = nil;
SFCue(\bell, { ~outbus = 5 }).play

(
Pdef('reduce.longnotes').stop; ~playing.do(_.stop()); ~playing = nil; ~baseplay.stop;
Ndef(\zero).play(fadeTime:3)
)
Ndef(\zero).stop(fadeTime:10);

Pbindef(\pentaLove, \instrument, \testtone, \scale, Scale.majorPentatonic, \root, 4, \degree, Pwhite(0, 10), \dur, Pxrand([0.25, 0.5, 0.75], inf), \outbus, Pwhite(4, 7), \db, -32).play(quant:1)
Pbindef(\pentaLove).stop

Pbindf(~base, \freq, 100).play(quant:1)



//---->>>>> QLAB

//BEBOP
SFCue(\realtid).play;
SFCue(\hardet).play;

SampleCue(\bell).play;

SFCue(\bebop).play
//
SFCue(\bebop).stop

~vibro.makeGui

Ndef(\forestamb).play(fadeTime:20);
Pdef(\parus).play;
Pdef(\cuculus).play;


Pdef(\parus).play;
ReaperServer().stop;
Ndef(\forestamb).stop(fadeTime:30);
//

Pdef(\parus).stop;
Pdef(\cuculus).stop;


