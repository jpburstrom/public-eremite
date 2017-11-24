(
var z = Pbind(\freq, 200, \dur, Pwhite(0.05, 0.1), \legato, 1);
var x = Pbind(\freq, 1200, \dur, 0.4, \legato, Pwhite(0.1, 0.9));
var target = List[];
var blendPtn = Pn(Penv([1, 1, 0.01, 0.01, 1], [4, 1, 2, 4], \exp)); //
blendPtn = Pseg(Pwhite(), Pwhite(0.1,1));
x = Environment.newFrom(x.patternpairs);
z.patternpairs.pairsDo { arg a, b, i;
    target.add(a);
    target.add(b.asPattern.blend(x[a].asPattern, blendPtn));
};
p = Pbind(*target);
Pdef(\bebop, p.collect({ |ev| ev.freq = ev.freq.cpsmidi.asInt.midicps }))
)

Pbindf(Pdef(\bebop), \amp, 1)                        .play


//
(
v = {
    var tgt = 3;
    var r = [];
    while { tgt > 0 } {
        var x = [0.25, 0.75, 1].choose.min(tgt);
        tgt = tgt - x;
        r = r.add(x)
    };
    Pseq(r)
}
)

Pbind(\lag, Pwhite(0, 0.02), \note, Pseq([0,8],inf), \dur, Pn(Plazy(v)) * 0.5, \legato, 0.6).play;
Pbind(\lag, Pwhite(0, 0.02), \note, Pseq([2,10,5],inf), \dur, Pn(Plazy(v)) * 0.5, \legato, 0.05).play;

Psync(Pbind(\dur, Prand([0.25, 0.75, 1], inf)), 4, 4).loop().play

Pbind(\dur, Pseq([2,1], inf)).lag(5).asStream.nextN(10, ())
Pseg