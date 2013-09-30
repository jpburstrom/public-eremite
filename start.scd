(
"lib/init.scd".resolveRelative.load.((
    verbose: true
));
)


z = MixingBoard("mains", nil, 4.collect(nil))
~main = MixerChannel(\main, s, 2, 2);
~forest = MixerChannel(\forest, s, 2, 2);
~main.play { SinOsc.ar }
MixerChannelGUI


q.debug