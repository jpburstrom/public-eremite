(
"lib/init.scd".resolveRelative.load.((
    verbose: true,
    //resetStorage: true
));

)

q.store.writeToFile

q.store

q.changed(\recall, q.store);nil
q.changed(\store, q.store)

q.addDependant(z = TestDependant())
q.removeDependant(z)

q.store.revertFromFile
q.ch.main.level
q.store
~test

z = MixingBoard("mains", nil, [q.ch.main])

q.ch.main.gui

~main = MixerChannel(\main, s, 2, 2);
~forest = MixerChannel(\forest, s, 2, 2);
~main.play { SinOsc.ar }
MixerChannelGUI
Te
q.store.foo = 22
q.store.writeToFile

MixerChannel
q.store
q.debug

x = SFP("/Volumes/HD2/projects/eremite/samples/birds/Blåmes 10_musikradion_sthlm_blames_(parus_caeruleus)_ve-070375aa9_aa424171_96.wav").stop

x.play
x.stop
playToMixer
~main.play(x)

x.release(10)
PeakMonitor(~main)

~sender = MixerChannel(\sender, s, 1, 2).hasSe

MixerChannelDef.mixerDefs

Library.at(\mixerdefs)
MixerScope(~main)
MixingBoard.boards.copy.do(_.free)
MixingBoard.refresh
MixerChannelGUI

[2,3].empty
Collection
~main.postSends[0].level
~test2 = MixerChannel(\test, s, 1, 1)

~test = MixerChannel(\test, s, 2, 1);
MixingBoard("Mainz", nil, [~test])
~test.setControl(\level, 0)
q.watchMixer(~test)
MixerChannelGUI


~test.addDependant(p = TestDependant());
z.put(\control, { arg ... args; args.postln })

~test2.def.guidef.asCode

~test.patches
~test.play({ SinOsc.ar([300,499])})

    