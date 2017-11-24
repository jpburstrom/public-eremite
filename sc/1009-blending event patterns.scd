(
Pdef(\test, Pbind(\freq, 330, \dur, 0.2));
Pdef(\test2, Pbind(\freq, 360, \dur, 0.6));

Pchain(
Prout({ arg ev;
    x = Pdef(\test).asStream;
    y = Pdef(\test2).asStream;
    loop {
        ev.putAll(x.next(ev).blend(y.next(ev), ev.blendFactor.postln));
        ev = ev.yield;
    }
}), Pbind(\blendFactor, Pbrown(0, 1, 0.1))).play;

)
Pdef(\test).next


//Idé: en lista med patterns, typ
//Välj vilka parametrar som ska korsfejdas (dur, legato, ...)
//Kan också välja att spela båda strömmarna samtidigt (om det är olika instrument)

~xfader(~patternList, ~indexPattern, ~paramsToFade, ~playBoth)
~patternList // en lista med patterns
~indexPattern // Env eller pattern som går mellan 0 och ~patternList.size-1
~paramsToFade // [\amp, \pan, \freq]
~playBoth     //
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


z.play
Pbind(*[\freq, 360, \dur, 0.6]).patternpairs.pairsDo { arg ... args; args.postln }
Pwhite(0, 0.1).blend(Pwhite(1, 1.1), Pwhite(0.2, 0.3)).asStream.next


