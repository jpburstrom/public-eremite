Ndef(\panner1, {
    Pan2.ar(\in.ar, FSinOsc.kr(0.5)) + [SinOsc.ar(100, mul:0.1), SinOsc.ar(140, mul:0.1)]
}).play;
Ndef(\panner1, {
    Pan2.ar(\in.ar, FSinOsc.kr(0.5)) + SinOsc.ar(200, mul:0.1)
}).play;

Ndef(\hubba, { arg in; in * SinOsc.ar(10) })
Ndef(\sound, { SinOsc.ar(220) * 0.1 });
Ndef(\sound)[1] = \filter -> { |in| in * 1  };
Ndef(\sound).objects
Ndef(\sound).rebuild


Ndef(\panner1)[1] = nil
Fdef(\ring, { |in| in[0].dup  })
Fdef(\ring, nil)

Ndef(\sound2, { SinOsc.ar(320) * 0.1 });

Ndef(\sound).add(Ndef(\sound2)) <>> Ndef(\panner1)
Ndef(\sound2) <>> Ndef(\panner1)


Ndef.record

Ndef(\sound).stop
Ndef(\sound).add(\filter -> Ndef(\panner).source)
Ndef(\panner1).play(0, 2)
Ndef(\panner1).playN((0..1).dup, -6.dbamp)
Ndef(\panner1).playNDialog
Ndef(\panner).clear

Ndef(\panner1).objects

Ndef.ar(\sound, 2)

Ndef.at(\sos)

Ndef(\panner2).stop
Ndef(\panner2) <<>.in1 Ndef(\sound)
Ndef(\panner2) <<>.in1 nil


a.fadeTime = 2
b.fadeTime = 2

a = NodeProxy.new.play;
a.source = { RLPF.ar(\in2.ar(0!2), [4600, 7000], 0.1) };
b = NodeProxy.new;
b.source_ { Impulse.ar([5, 7] / 2) };
a <<> b;
a.play;
a.stop