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

( 'instrument': \parus, 'legato': 0.47261800137647, 'dur': 0.22316267732359, 'release': 0.01, 'server': MyPhones.phones['POD1'], 'freq': 493.88330125612, 'type': \phone, 'latency': 1.0 ).play

Pchain(Pbind(\latency, 1, \release, 1, \type, \phone, \amp, 4, \server, MyPhones.phones['POD1'], \instrument, \parus), Pdef(\bebop)).trace.play;

~pd = NetAddr("localhost", 9999)
Event.newFrom([\latency, 1, \release, 0.1, \type, \phone, \server, ~pd, \instrument, \parus]).play
(
var host = "http://" ++ "ipconfig getifaddr en1".unixCmdGetStdOutLines[0];
fork {
    "/Volumes/HD2/projects/eremite/kod/phones/*".pathMatch.do({ arg x;
        MyPhones.download( host ++ ":8000/" ++ x.basename);
        1.wait;

    });
    MyPhones.reload
}
)
MyPhones.open('iPhone Simulator', )
MyPhones.debug(2)
MyPhones.sendMsg('POD1', "/open", "main.pd")
MyPhones.makeGui

MyPhones.phones['iPhone Simulator'].ip.ccopy

x = NetAddr("192.168.1.70", 12345)
z = NetAddr("192.168.1.70", 8888)
x
Tdef(\hoho, {
    loop {
        z.sendMsg("/pdmsg", "parus", "gate", 1);
        3.wait;
    }
}).play
M
(
Tdef(\test,  {
    loop {
        0.125.wait;
        MyPhones.phones[\POD1].sendBundle(["/pdsched", SystemClock.seconds, 1.0, "parus", "gate", 1]);
    }
}).play
)



NetAddr("127.0.0.1", 8000).sendMsg("/test", 80.99)

NetAddr("192.168.1.64", 12345).sendMsg("/pdmsg", "parus", "gate", 1.99);




MyPhones.debug(0)
MyPhones.unwatch
MyPhones.download("192.168.1.70/phones/voicer.pd");
MyPhones.download("http://danielnouri.org/docs/SuperColliderHelp/ServerArchitecture/bundledCommands.html")

Ndef(\vibro2).play
Ndef(\vibro2).stop(fadeTime:10)


(
Pseq([
    Pbind(
        \type, \phone,
        \server, MyPhones.phones['PODx'],
        \instrument, \parus,
        \latency, 1,
        \test, p { arg ev;
            var i = 0;
            var max = 8;
            loop {
                i.postln;
                if (i == max) {
                    nil.yield;
                };
                i.yield;
                i = i + 1;
            }
        },
        \dur, Plazy({
            //TODO: don't repeat 3
            var rep = [8,6,3].wchoose([4,2,1].normalizeSum) * Pwhite(0.98, 1.02);
            0.25.repeat(rep)
        }),
        \legato, 0.4,
        \freq, Pseq([#[4349, 4143, 4521, 4780], 3531], inf) * 1,
        \db, Pseq([[-10, -14, -21, -26], -9], inf),
        \attack, Pseq([#[0.06, 0.06, 0.04, 0.01], 0.04], inf),
        \glide, Pseq([1.03, 0.97], inf),
        \release, 0.05,
        \curve, 0
    ),
    Pbind(\type, \rest, \dur, Pwhite(2.25, 15, 1))
], inf).play
)


(
Pseq([
    Pbind(
        \type, \phone,
        \phone, \POD2,
        \instrument, \parus,
        \latency, 1,
        \dur, 0.3,
        \amp, 1,
        \legato, Pseq([0.2, 0.55]),
        \midinote, Pseq([75.5, 72]),
        \attack, Pseq([0.3, 0.2]),
        \release, 0.1,
        \pattack, Pseq([0.97, 0.99]),
        \patime, Pseq([0.2, 1]),
        \pdtime, 0.2,
        \pdecay, Pseq([0.95, 1])
    ),
    Pbind(\type, \rest, \dur, Pwhite(0.7, 0.9, 1))
    ], inf
    ).play
);

(
//Gråsparv
Pbind(
    \type, \phone,
    \phone, \PODx,
    \instrument, \parus,
    \delta, Phprand(1.551, 2.1),
    \lag, [0, 0.01],
    \dur, 0.171,
    \midinote, [106, 106.5] * Pwhite(0.99, 1.01),
    \db, -10,
    \attack, 0.07,
    \decay, 0.07,
    \pattack, Pwhite(0.6, 0.7),
    \patime, 0.43,
    \pdecay, Pwhite(0.6, 0.7),
    \pdtime, 0.28
).play
)
