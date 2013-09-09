Tdef(\pod1, {
    loop {
        var w;
        q.sendMsg("/freq", [98, 100].choose.midicps);
        q.sendMsg("/amp", (-12).rrand(-12).dbamp);
        q.sendMsg("/on");
        w = 0.1.rrand(0.2);
        w.wait;
    }
}).play;

(
Pbindef(\podtest,
    \type, \pod,
    \client, \pod2,
    \degree, Pwhite(0,12),
    \scale, Scale.partch_o1,
    //\root, Prand([0, 7], inf).stutter(6),
    \octave, 4.4,
    \root, 0,
    \db, Pbrown(0, 3),
    \dur, Prand([0.25, 0.125], inf).stutter(7),
).play;
)
Tempo.tempo = 1
(
Pbindef(\podtest2,
    \type, \pod,
    \client, \pod3,
    \degree, Pwhite(0,12),
    \scale, Scale.partch_o1,
    //\root, Prand([0, 7], inf).stutter(6),
    \octave, 3,
    \root, 0,
    \db, Pbrown(0, 3),
    \dur, Prand([0.25, 0.125], inf).stutter(7),
).play;
)



Event.addEventType(\pod2, {
    z.sendMsg("/freq", currentEnvironment.freq);
    z.sendMsg("/amp", currentEnvironment.amp);
    z.sendMsg("/on");
})

