Ndef(\vibro2, {
    var snd = Mix.fill(10, { SinOsc.ar(LFNoise2.kr(1).range(50, 60)) * 0.05 }) + (Mix(Decimator.ar(SinOsc.ar([1000, 850] + SinOsc.kr(LFNoise2.kr(0.1).range(3, 8), 0, 5)), 44100, 2)) * 0.005);
    PanAz.ar(3, snd, \chan3.kr(-1) + 0.66667)
}).play;

ControlSpec.add

Ndef(\vibro2).edit

NamedControl
/*
ATT GÖRA:
Nivåer på allt
Cuelista
Cymbaler fixa
Sänka volym fix
Tillstånd - fixa fejd olika längd

Headset:
- kolla möjligheterna att koppla genom datorn
- inte rundgång
- kolla nivåer

Telefon:
Vem ringer när?1
*/

- Reducera dig till en grej


//Kolla upp kontrollspec

//Första början, Reducera
//I fönstret / Bebop
Slå på musiken (cymbal-bebop) när tar tangentbord
Sänker volymen
Slår av musiken när sätter sig vid tangentbord
Glob av eld -- det låter lite
Nu snackar vi nästan realtid
Har det hänt er nån gång
Bebop empty
//Tillstånd på blindgång
//Blue Phenomenon / Frontfig
//Telefonsamtal

Pdef(\cymbal).play; Pdef(\bd).play; Pdef(\hihat).play;
//Ändra volym
Pdef(\cymbal).stop; Pdef(\hihat).stop; Pdef(\bd).stop;
//Reaper x 3


s.makeWindow

Pdef.defaultQuant = 0;

(
var channels = [0, 1, 2];
var numChannels = [1,1,1];
var win = Window.new;
GridLayout
win.addLayout
channels.do

)

Ndef(\vibro).play(0, 1, fadeTime:2) // LEFT
Ndef(\vibro).play(1, 1, fadeTime:2) // RIGHT
Ndef(\vibro).play(2, 1, fadeTime:2) // FLOOR
Ndef(\vibro).release(10)
//Vad händer efter .release?



s.makeWindow
Pdef(\cymbal).play; Pdef(\bd).play; Pdef(\hihat).play;
Pdef(\cymbal).stop; Pdef(\hihat).stop; Pdef(\bd).stop;

TempoClock.default.tempo = 1

Pdef(\hihat).stop; Pdef(\bd).stop;
Pdef(\hihat).play; Pdef(\bd).play;

Pdef(\bd).play;
Pdef(\empty, Pbind(\amp, Pseries(0, 0.01).fold(0, 0.1))).play;

Pdef(\empty).stop;
Pdef(\bd).stop

Pdef(\cymbal);

PdefAllGui()