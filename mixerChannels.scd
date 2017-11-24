//MIXERS
//Mix down 2>1
MixerChannelDef(\mix2x1, 2, 1,
    SynthDef("mixers/Mxb2x1", {
        arg busin, busout, level;
        var in;
        in = In.ar(busin, 2) * level;
        in = Mix(in);
        // so that mixerchan bus can be used as postsendbus
        ReplaceOut.ar(busin, in);
        Out.ar(busout, in);
    }),
    (level: (spec: \amp, value: 0.75)),
    MixerChannelDef.at(\mix1x1).guidef
);



q.ch = (
    stereo: MixerChannel(\stereo, s, 2, 2, 1, outbus: 0),
    table: MixerChannel(\table, s, 2, 1, 1, outbus: 2),
    lamp: MixerChannel(\lamp, s, 2, 1, 1, outbus: 3),
    forest_monitor: MixerChannel(\monitor, s, 2, 1, 1, outbus:4),
    //Audience and forest_lamp share channel
    audience: MixerChannel(\audience, s, 2, 1, 1, outbus: 5),
    forest_lamp: MixerChannel(\forest_lamp, s, 2, 1, 1, outbus: 5),
    sub: MixerChannel(\sub, s, 2, 1, 1, outbus: 6),
    tower: MixerChannel(\tower, s, 2, 1, 1, outbus: 7)
);
q.ch.bebop = MixerChannel(\bebop, s, 2, 2, 1, outbus: q.ch.table);
q.ch.bebop.newPreSend(q.ch.stereo, 0);

q.ch.sorting = MixerChannel(\sorting, s, 2, 2, 1, outbus: q.ch.stereo);
q.ch.sorting.newPreSend(q.ch.sub);

q.ch.zimmer = MixerChannel(\zimmer, s, 2, 2, 1, outbus: q.ch.table);
q.ch.zimmer.newPreSend(q.ch.stereo, 0);

q.s = ();