Ndef.defaultServer = t;

s.queryAllNodes
Ndef((\sin1 -> \room), { ( SinOsc.ar(LFNoise2.kr(0.1).exprange(40, 42)) + SinOsc.ar(LFNoise2.kr(0.1).exprange(42, 45)) ) * 0.1 }).play
Ndef(\sin1 -> \room).release
Ndef(\sin1 -> \room).stop
Ndef((\sin1 -> \room)).fadeTime_(10)
Ndef(\sin2 -> \room, { SinOsc.ar(LFNoise2.kr(0.1).exprange(30, 51)) * 0.05 }).play


Ndef(\sin3 -> \room, { (SinOsc.ar(LFNoise2.ar(0.1).exprange(8005, 8020)) + SinOsc.ar(8000)) * 0.001 }).play.fadeTime_(20)
Ndef(\sin3 -> \room).fadeTime = 0
Ndef(\sin3 -> \room).stop

Ndef(\sin1 -> \room).stop; Ndef(\sin2 -> \room).stop; Ndef(\sin3 -> \room).stop

/////////////////////////////////////
//TABLEEEEEEEE
/////////////////////////////////////

Ndef(\noise1, { BPF.ar(WhiteNoise.ar, 1100, 0.22) * 0.8 } ).play
Ndef(\noise1).release
Ndef(\noise1).fadeTime_(10)

Ndef(\noise2, { BPF.ar(WhiteNoise.ar, 10000, 0.2) * 0.01 } ).play.fadeTime_(10)
Ndef(\noise2).release
Ndef(\noise2).stop

///////////////////////////////////////////
// RING
///////////////////////////////////////////

(
Tdef(\randomRingLoop2, {
    {
        20.rrand(120).postln.wait;
        Tdef(\ring).play;
        (10.rrand(20)).wait;
        Tdef(\ring).stop;
        "STOP".postln;
    }.loop
}).play
)
Tdef(\randomRingLoop2).stop
Ndef(\noise2).play
Ndef(\noise2).stop; Ndef(\sin1).play;
Ndef(\sin1).stop; Ndef(\noise1).play;
Ndef(\noise1).stop; Ndef(\sin2).play;