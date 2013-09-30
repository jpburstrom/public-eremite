(
Ndef(\bits, {
    var bits = (2 ** 8).asInt;
    var bitsdiv = 1 / (bits * 0.5);
    var t = PulseCount.ar(Impulse.ar(48000/10));
    var snd = 0;
    var c = [0, 1];
    snd = t ** ((t * 0.01) % 1) >> ((t * 1) % (bits * 3 >> 1));
    snd = snd + ((1000 % (t % ((500 - t) % (2 ** 12) + (c * 100)))).poll);
    snd = snd + ((t * 4 * (c + 3)) * 0.1);

    (((snd % bits) * bitsdiv) - 1)
}).play
)



(
Instr(\bits2, { arg p1=0.01, p2=3;
    var bits = (2 ** 8).asInt;
    var bitsdiv = 1 / (bits * 0.5);
    var t = PulseCount.ar(Impulse.ar(48000/4));
    var snd = 0;
    var c = [0, 1];
    snd = t ** ((t * p1) % 1) >> ((t * 1) % (bits * p1 >> 3));
    snd = snd + ((p2 % (t % ((p2 - t) % (2 ** 12) + (c * p2)))));
    snd = snd + ((t * p1 * (c + 3)) * 4);

    snd = (((snd % bits) * bitsdiv) - 1);
    snd * Decay.ar(Dust.ar(10), 1)
}, [NoLagControlSpec(0.01, 400, \lin, default:100), NoLagControlSpec(1, 1000)], \stereo);
)


x = Patch("bits2").play;

x.gui
x.stop

fork { loop { 2.wait; x.inputs[0].rand } }
x.respawnOnChange = 1.0
Pbind(\dur, Prand([0.125, 0.25], inf), \hello, Pfunc({x.rand})).play


Instr(\test, { SinOsc.ar })

Patch("test").gui
(
Ndef(\bass2, {
    Splay.ar(DelayN.ar(RHPF.ar(Decay.ar(Impulse.ar(6), 0.1, 5), [40, 43], 0.1).tanh.dup, [0, 0.2], [0, LFNoise2.kr(0.1).range(0.001, 0.09)]))
}).play
Ndef(\bass2).stop
)

(
//Nice
{ arg p1=0.01, p2=3;
    var bits = (2 ** 8).asInt;
    var bitsdiv = 1 / (bits * 0.5);
    var t = PulseCount.ar(Impulse.ar(48000/[2, 2.0001]));
    var snd = 0;
    var c = [0, 1];
    //snd = t*(42 & t >> 10);
    snd = t * (2 + ((t >> 12) & (t >> 9))) ;
    snd = Mix((((snd % bits) * bitsdiv) - 1) * [1, -1]).dup;

}.play;

)

(
//Nice 2
{ arg p1=0.01, p2=3;
    var bits = (2 ** 8).asInt;
    var bitsdiv = 1 / (bits * 0.5);
    var trig = Impulse.ar(48000/[16,20]);
    var t = (PulseCount.ar(trig) % (2**16));
    var rand = TRand.ar(8, 9, Impulse.ar(1)).floor;
    var snd = 0;
    var c = [0, 1];
    //snd = t*(42 & t >> 10);
    snd = t * ((t >> rand) & ((t >> rand)) & (t >> 9)) << [3, 1] >> c ;
    snd = Mix((((snd % bits) * bitsdiv) - 1) * 12).dup.softclip;

}.play;
)




