{
    var snd = Mix.fill(10, { SinOsc.ar(LFNoise2.kr(1).range(80, 85) ) * 0.05 });

    PanAz



}.play


Ndef(\vibro, { Mix.fill(10, { SinOsc.ar(LFNoise2.kr(1).range(50, 60)) * 0.05 }) + (Mix(Decimator.ar(SinOsc.ar([1000, 850] + SinOsc.kr(LFNoise2.kr(0.1).range(3, 8), 0, 5)), 44100, 2)) * 0.005) });

Ndef(\vibro).play
{ Mix.fill(10, { SinOsc.ar(LFNoise2.kr(1).range(50, 60)) * 0.05 }) }.play

(
Tdef(\vibroThing, {
    var i = 0;
    loop {
        [
            { Ndef(\vibro).play(2, 2, fadeTime:2) }
            ,
            { Ndef(\vibro).play(0, 2, fadeTime:2) }
            ,
            { Ndef(\vibro).play(0, 1, fadeTime:2) }
        ][i].value;
        i = (i + 1) % 3;
        10.rrand(16).wait;
    }
}).play;
)

Tdef(\vibroThing).stop; Ndef(\vibro).stop;
3 % 3

Tdef(\plingThing, {
    loop {
        Ndef(\pling, { SinOsc.ar(400) * XLine.kr(1, 0.00001, 4, doneAction:2)  * 0.4 }).play([0, 1].choose);
        12.rrand(24).wait;
    }
}).play