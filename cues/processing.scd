// 0,07	pointing	manipulating	attack

var defaultKeyActions = (
    $1: {
        OneShotCue(\hackbell).play;
    },
    $2: {
        Pfin(8, Pdef(\parus)).play(quant:1);
    },
    $3: {
        AsyncCue(\vox_audience_processing).play;
    },
    $4: {
        AsyncCue(\vox_audience_processing).stop;
    },
    $5: {
        AsyncCue(\vox_table2).play
    },
    $6: {
        AsyncCue(\vox_table2).stop;
    }
);

(
SynthDef("reduce.rhythm",
    { arg outbus=0;
        var snd = Splay.ar(Mix.fill(32, { |i| SinOsc.ar(\freq.kr(200) * (i+3)) * (1-(i/16)) }), 1, 0.1 );
        var adjustment = -6.dbamp;
        snd = snd * EnvGen.kr(Env.perc(\attack.kr(0), \release.kr(0.1), \amp.kr(1)), doneAction:2);
        snd = BLowPass4.ar(snd, 10000, 0.4);
        //OffsetOut.ar(0, snd);
        OffsetOut.ar(outbus, snd * adjustment) //F
    }
).add;
SynthDef(\hackspett_bell, {
    var snd, wood = (
        'kfreq': #[ 1, 2.777, 7.378, 15.377 ],
        'kamp': #[ 0.08, 0.02, 0.02, 0.016 ],
        'kres': #[ 1.0, 0.99799196787149, 0.99799196787149, 0.99397590361446 ],
    ),
    wood2 = (
        'kfreq': #[ 1, 1.777, 2.378, 3.377 ],
        'kamp': #[ 0.08, 0.02, 0.02, 0.016 ],
        'kres': #[ 1.0, 0.99799196787149, 0.99799196787149, 0.99397590361446 ],
    );

    snd = (5 * HPF.ar(Decay.ar(Impulse.ar(\speed.kr(20)), 1), 1000)).softclip;
    snd = Klank.ar(`[wood2.kfreq, wood2.kamp * \preamp.kr(0.1), wood2.kres], snd, \freq.kr(500), 0, \wetness.kr(0.1)).distort
    * Linen.kr(\gate.kr(1), \attack.kr(0), \amp.kr(1), \release.kr(0), doneAction:2);
    OffsetOut.ar(\outbus.kr(0), HPF.ar(snd, 400));
}).add;
);

OneShotCue(\hackbell, {
    ~volume = -3.dbamp;
    (latency:nil, instrument: \hackspett_bell, outbus: 0, release: 0.1, preamp: 30, dur: 0.85, amp: 0.05 * ~volume).play;

});
s.makeWindow
record

OneShotCue(\processing, {

    //BASE
    ~base = Pbind(
        \instrument, "reduce.rhythm",
        \dur, Pseq([0.25, 0.75], inf),
        //\lag, Pwhite(-0.01, 0.01),
        \freq, Pbrown(200, 210, 0.125),
        \release, Pwhite(0.05, 0.14).stutter(inf),
        \amp, 0.2,
    );

    ~keyActions = defaultKeyActions;

    ~sources = [
        Pbind(
            \instrument, "reduce.rhythm",
            \dur, Pxrand([0.25, 0.75, 0.5], inf).stutter(4),
            //\lag, Pwhite(-0.01, 0.01),
            \degree, 1,
            \octave, 7,
            \release, 0.01,
            \amp, 0.1,
        ),
        Pbind(
            \instrument, "reduce.rhythm",
            \dur, Prand([0.5, 0.75], inf),
            \degree, Prand([2, 8], inf), //Pxrand([2,4,5], inf).stutter(Prand([8, 16, 24], inf)),
            \octave, 3,
            //\lag, Pwhite(-0.01, 0.01),
            \attack, Pwhite(0, 0.02),
            \release, Pwhite(0.01, 0.2),
            \amp, 0.1,
        ),
        Pbind(
            \instrument, "reduce.rhythm",
            \dur, Prand([0.75, 1], inf) ,
            \degree, 2,
            \octave, 3,
            //\lag, Pwhite(-0.01, 0.01),
            \release, Pwhite(0.01, 0.2),
            \amp, 0.1,
        ),

        Pbind(
            \instrument, "reduce.rhythm",
            \dur, Prand([0.75, 1], inf) * 0.5 ,
            \degree, 2,
            \octave, 4,
            //\lag, Pwhite(-0.01, 0.01),
            \release, Pwhite(0.01, 0.2),
            \amp, 0.1,
        )
    ];

    ~longnotes = Pbind(
        \instrument, "reduce.rhythm",
        \dur, Prand([2, 3, Rest(2), Rest(3)], inf) ,
        \degree, Pwhite(0, 4) * 4,
        \mtranspose, Pwhite(-0.5, 0.5),
        \octave, 2,
        \release, Pwhite(0.01, 0.2),
        \attack, 5,
        \release, 5,
        \amp, 0.01,
    );

    //END PATTERNS

    ~resetList = {
        var i;
        ~playing.items = ~playlist.flop[1] ? [];
    };
    ~playInMixer = { arg mx, thing, label;
        "hello".postln;
        if (thing.notNil) {
            thing.postln;
            thing = EventPatternProxy(thing).quant_(0.5);
            ~playlist.addFirst([q.ch[mx].play(thing), label]);
            ~resetList.value;
        };


    };
    ~playlist = List[];

    ~mixerChannels = [\stereo, \table, \audience, \lamp, \sub];

    ~makeWindow = {
        ~win = Window("Processing", 800@300);

        ~win.layout = VLayout(
            HLayout(
                StaticText().string_("1: Hackspett"),
                StaticText().string_("2: Koltrast"),
                StaticText().string_("3: Vox A ON"),
                StaticText().string_("4: Vox A OFF"),
                StaticText().string_("3: Vox T ON"),
                StaticText().string_("4: Vox T OFF"),
            ),
            HLayout(
                VLayout(
                    StaticText().string_("Short"),
                    ~short = ListView().items_(~mixerChannels).enterKeyAction_( e { |o|
                        var item, label, mx;
                        mx = o.items[o.value];
                        if (~playlist.size == 0) {
                            item = ~base;
                            label = mx ++ ":Base"
                        } {
                            item = ~sources.choose;
                            label = mx ++ ":Rhythm"
                        };
                        ~playInMixer.(o.items[o.value].asSymbol, item, label);
                })),
                VLayout(
                    StaticText().string_("Long"),
                    ~long = ListView().items_(~mixerChannels).enterKeyAction_( e { |o|
                        var mx = o.items[o.value];
                        ~playInMixer.(mx.asSymbol, ~longnotes, mx ++ ":Long");
                })),
                VLayout(
                    StaticText().string_("Playing"),
                    ~playing = ListView().enterKeyAction_( e { |o|
                        o.value !? {
                            ~playlist[o.value][0].stop;
                            ~playlist.removeAt(o.value);
                            ~resetList.value;
                        }

                }))
            )
        );

        /*
        [~short, ~long, ~playing].do (_.keyDownAction_({ arg ... args;
            args.postln;
        }));

        */

        ~win.front;


    };

    ~pause = inEnvir {
        ~playlist.do { arg x; x[0].pause }
    };
    ~resume = inEnvir {
        ~playlist.do { arg x; x[0].resume }
    };

    ~stop = inEnvir {
        ~playlist.do { arg x; x[0].stop }
    };

    ~makeWindow.value;
});


GroupCue(\bebop,
    {
        ~cues = [
            SFCue(\bebopmusic),
            OneShotCue(\processingPause, { OneShotCue(\processing)[\pause].value } ),
        ];

        ~keyActions = defaultKeyActions;
    }
);

OneShotCue(\processingResume, {
    OneShotCue(\processing)[\resume].value;
    GroupCue(\bebop).stop;
}).use {
    ~keyActions = defaultKeyActions;
};

OneShotCue(\processingStop, {
    OneShotCue(\processing).use {
        ~stop.value;
        ~win.close
    }
}).use {
    ~keyActions = defaultKeyActions;
};


/*
CueList[
    SFCue(\processing), GroupCue(\bebop), OneShotCue(\processingResume), OneShotCue(\processingStop)
].gui
*/

