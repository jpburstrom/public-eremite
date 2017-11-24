(
//
s.latency = 0.1;
OpenObject.start;
q.clk = AudioMulchClock();
q.clk.shift = -3;
q.clk.startAction;
q.clk.stopAction = {
    "cleanup".postln;
    q.processing.stop;
};
TempoClock.default = q.clk;
q.phoneClock = TempoClock.new
);

(
"Adding OSC".postln;
OSCdef(\clip, { arg action;
    action.postln;
    (
        'pentaLove play': { Pdef(\pentaLove).play },
        'pentaLove stop': { Pdef(\pentaLove2).stop; Pdef(\pentaLove).stop },
        'pentaLove harp': { Pdef(\pentaLove).stop; Pdef(\pentaLove2).play },
        'proc start': { q.processing.stop; q.processing.play(\horn) },
        'proc add': { q.processing.play(\URN) },
        'proc pause': q.processing[\pause],
        'proc long' : { q.processing.play(nil, true) },
        'proc resume': q.processing[\resume],
        'proc stop': q.processing[\stop],
        'phones watch': { MyPhones.watch },
        'phones unwatch': { MyPhones.unwatch },
        'parus play': {
            Pdef(\parus).play(q.phoneClock)
        },
        'parus stop': {
            Pdef(\parus).stop
        },
        'birds play': {
            Pdef(\parus).play(q.phoneClock);
            Pdef(\cuculus).play(q.phoneClock);
            Pdef(\sparrow).play(q.phoneClock)
        },
        'birds stop': {
            Pdef(\parus).stop;
            Pdef(\cuculus).stop;
            Pdef(\sparrow).stop
        },
        'stop all': {
            Pdef.all.do(_.stop);
            q.processing.stop
        },

    )[action[1]].value;
    }, '/clip'
);
OSCdef(\main, { |msg|
    q.ch.fr.level = msg[1];
    q.ch.fl.level = msg[1];
}, \main);

OSCdef(\back, { |msg|
    q.ch.br.level = msg[1];
    q.ch.bl.level = msg[1];
}, \back);

#[room, table, lamp, audience, horn].do { |ch|
    OSCdef(ch, { |msg|
        q.ch[ch].level = msg[1];
    }, ch);
};

OSCdef(\vol_main, { arg vol;
    vol.postln;
}, '/vol/main');
OSCdef(\vol_back, { arg vol;
    vol.postln;
}, '/vol/back');
OSCdef(\vol_back, { arg vol;
    vol.postln;
}, '/vol/back');


);