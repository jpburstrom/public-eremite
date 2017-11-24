q.processing = Proto({

    //BASE
    ~base = Pbind(
        \instrument, "reduce.rhythm",
        \dur, Pseq([0.25, 0.75], inf),
        //\lag, Pwhite(-0.01, 0.01),
        \freq, 205,
        \release, Pwhite(0.05, 0.14).stutter(inf),
        \amp, 0.2,
    );

    ~keyActions = nil;

    ~sources = [
        Pbind(
            \instrument, "reduce.rhythm",
            \dur, Pxrand([0.25, 0.75, 0.5], inf),
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
        //var i;
        //no-op
        //~playing.items = ~playlist.flop[1] ? [];
    };
    ~playInMixer = { arg mx, thing, label;
        //"hello".postln;
        if (thing.notNil) {
            thing = EventPatternProxy(thing.stretch(2)).quant_(1);
            ~playlist.addFirst([q.ch[mx].play(thing), label]);
            ~resetList.value;
        };


    };
    ~playlist = List[];

    ~play = { arg spkr, long;
        var item, label, mx;
        spkr = spkr ? ~mixerChannels[0];
        if (spkr == 'RAND') {
            spkr = ~mixerChannels.choose;
        };
        if (spkr == 'URN') {
            if (~mxUrn.size == 0) {
                ~mxUrn = ~mixerChannels.copy;
            };
            spkr = ~mxUrn.remove(~mxUrn.choose);

        };
        ~playlist.postln;

        //mx = o.items[o.value];
        if (long.isNil) {
            if (~playlist.size == 0) {
                item = ~base;
            } {
                item = ~sources.choose;
            };
        } {
            item = ~longnotes;
        };
        ~playInMixer.(spkr, item, label);
        spkr
    };

    ~mixerChannels = [ 'fl', 'room', 'fr', 'audience', 'table', 'bl', 'br', 'lamp', 'horn' ];
    ~mxUrn = ~mixerChannels.copy;

    ~pause = inEnvir {
        ~playlist.do { arg x; x[0].pause }
    };
    ~resume = inEnvir {
        ~playlist.do { arg x; x[0].resume }
    };

    ~stop = inEnvir {
        ~playlist.do { arg x; x[0].stop };
        ~playlist = List[];
        ~mxUrn = ~mixerChannels.copy;
    };

   // ~makeWindow.value;
});
q.processing.playlist