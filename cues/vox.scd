(
AsyncCue(\vox_share, {
    ~volume = -3.dbamp;
    ~play = e {
        var synth = q.ch.stereo.play({
            var z = SoundIn.ar(0) * XLine.ar(0.01, 1, 10);
            z = Compander.ar(z, z,
                thresh: 0.1,
                slopeBelow: 1,
                slopeAbove: 0.2,
                clampTime: 0.01,
                relaxTime: 0.01
            );
            z.dup * ~volume;
        });
        var synth2 = q.ch.audience.play({
            var z = SoundIn.ar(0) * XLine.ar(0.01, 1, 9);
            z = Compander.ar(z, z,
                thresh: 0.1,
                slopeBelow: 1,
                slopeAbove: 0.2,
                clampTime: 0.01,
                relaxTime: 0.01
            );
            z.dup * ~volume * 1;
        });
        ~addToCleanup = {
            synth.free;
            synth2.free;
        };
    };

    ~quant = 0.1;
});

);
/*
//Then she went to the drawer...
AsyncCue(\vox_table1, {
    ~mixerChannel = q.ch.table;
    ~volume = 6;
    ~play = e {
        var synth = ~mixerChannel.play({
            var z = SoundIn.ar(0);
            z = LPF.ar(z, 2000);
            (z ! ~mixerChannel.def.inChannels) * ~volume;
        });
        ~addToCleanup = {
            synth.free;
        };
    };

    ~quant = 0.1;
});


//I leave them in the forest
AsyncCue(\vox_table2, {
    ~mixerChannel = q.ch.table;
    ~volume = 0.dbamp;
    ~play = e {
        var synth = ~mixerChannel.play({
            var z = SoundIn.ar(0);
            z = LPF.ar(z, 8000);
            (z ! ~mixerChannel.def.inChannels) * ~volume;
        });
        ~addToCleanup = {
            synth.free;
        };
    };

    ~quant = 0.1;
});
*/
//Going out in the forest
(
AsyncCue(\vox_audience, {
    ~mixerChannel = q.ch.audience;
    ~volume = 18.dbamp;
    ~play = e {
        var synth = ~mixerChannel.play({
            var z = SoundIn.ar(0) * XLine.ar(0.01, 1, 1);
            //z = LPF.ar(z, 2000);
            (z ! ~mixerChannel.def.inChannels) * ~volume;
        });

        ~addToCleanup = {
            synth.free;
        };
    };
    ~quant = 0.1;
});
);

(
AsyncCue(\vox_audience_headset, {
    ~mixerChannel = q.ch.audience;
    ~volume = 0.dbamp;
    ~play = e {
        var synth = ~mixerChannel.play({
            var z = SoundIn.ar(0) * XLine.ar(0.01, 1, 1);
            //z = LPF.ar(z, 2000);
            (z ! ~mixerChannel.def.inChannels) * ~volume;
        });

        ~addToCleanup = {
            synth.free;
        };
    };
    ~quant = 0.1;
});
);

(
AsyncCue(\vox_audience_processing, {
    ~mixerChannel = q.ch.audience;
    ~volume = 12.dbamp;
    ~play = e {
        var synth = ~mixerChannel.play({
            var z = SoundIn.ar(0) * XLine.ar(0.01, 1, 1);
            //z = LPF.ar(z, 2000);
            (z ! ~mixerChannel.def.inChannels) * ~volume;
        });

        ~addToCleanup = {
            synth.free;
        };
    };
    ~quant = 0.1;
});
);


