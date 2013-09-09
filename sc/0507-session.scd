//Find all phones on local network
(
var list = ("bash" + thisProcess.nowExecutingPath.dirname ++  "/find-hosts.sh").unixCmdGetStdOutLines;
~clients = ();
list = list.collect({ |str| str.split($ )[0].asSymbol; }).asSet;
list = (list & [
    'podx.local',
    'pod1.local',
    'pod2.local',
    'pod3.local',
    'phone1.local'
]).asList;

list.do { |key|
    ~clients[key.asString.split($.)[0].asSymbol] = NetAddr(key.asString, 12345);
};

a = ~clients;

)

//Upload // Happy face // Webpage

(
Event.addEventType(\pod, {
    currentEnvironment.client.notNil.if {
        var client = a[currentEnvironment.client];
        client.sendMsg("/freq", currentEnvironment.freq);
        client.sendMsg("/amp", currentEnvironment.amp);
        client.sendMsg("/on");
    }
})
)

Pbind(\type, \pod, \client, \pod1, \freq, 8000, \amp, 2, \dur, 0.1).play
Pbind(\type, \pod, \client, \pod3, \freq, 6000, \amp, 2, \dur, 0.1).play

Pbind(\type, \pod, \client, \pod1, \freq, Pseries(200, 1, 2000), \amp, 2, \dur, 0.1).play
Pbind(\type, \pod, \client, \pod3, \note, Prand([0,3,8],inf), \amp, Pwhite(0, 1), \dur, Pwhite(0.01, 0.2)).play
Pbind(\type, \pod, \client, \podx, \freq, Pseries(200, 1, 2000), \amp, 2, \dur, 0.1).play

~clients.podx.sendMsg("/hello")

CmdPeriod.add { ~clients.do (_.sendMsg("/off")) };
~clients

n = NetAddr("169.254.153.17", 12345)

n.sendMsg("/hello")
~clients.do (_.sendMsg("/off"))
n.sendMsg("/stream", "connect", "169.254.238.186", "puredata.ogg", "8000")

CmdPeriod.removeAll

//Browsing/
(
Pbind(
    \type, \pod,
    \client, \pod3,
    \note, Prand([0,3,8],inf),
    \amp, Pwhite(0, 1),
    \dur, Pwhite(0.01, 0.2)
).play;
Pbind(
    \type, \pod,
    \client, \pod1,
    \octave, 6,
    \note, Prand([0,3,7],inf),
    \amp, Pwhite(0, 1),
    \dur, Pwhite(0.01, 0.2)
).play;
)


//Online poker / Download / frown
(
Pbind(
    \type, \pod,
    \client, \pod3,
    \note, Pn(Pseries(0, 2, 16)),
    \amp, 1,
    \dur, Pwhite(0.1, 0.12)
).play;
Pbind(
    \type, \pod,
    \client, \pod1,
    \note, Pn(Pseries(0, 1, 32)),
    \amp, 1,
    \dur, Pwhite(0.1, 0.12)
).play;
)

//Login
(
Pbind(
    \type, \pod,
    \client, \pod3,
    \note, Pwhite(0, 32),
    \amp, Pseq([1, 0], inf),
    \dur, Pseq([0.1, Pwhite(5,8, 1)], inf)
).play;
Pbind(
    \type, \pod,
    \client, \pod1,
    \note, Pwhite(0, 32),
    \amp, Pseq([1, 0], inf),
    \dur, Pseq([0.1, Pwhite(5,8, 1)], inf)
).play;
Pbind(
    \type, \pod,
    \client, \pod2,
    \note, Pwhite(0, 32),
    \amp, Pseq([6, 0], inf),
    \dur, Pseq([0.01, Pwhite(5,8, 1)], inf)
).play;
)

//Password
(
Pbind(
    \type, \pod,
    \client, \pod2,
    \scale, Scale.harmonicMinor,
    \degree, Pseq([0,1,2,1,2,3,2,3,4], inf),
    \octave, Pwhite(5, 6),
    \amp, 0.2,
    \dur, 1 / Pkey(\octave)
).play;
)

//Phone ring
(
Pbind(
    \type, \pod,
    \client, \pod2,
    \scale, Scale.harmonicMinor,
    \degree, Pseq([0,2,4,7], 2) ++ Pn(-10000, 1),
    \octave, 7,
    \amp, 0.1,
    \dur, 0.1
).play;
)