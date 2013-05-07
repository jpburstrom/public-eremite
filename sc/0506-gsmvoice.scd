//"GSM voice" -- for dwarf speaker

{ HPF.ar(LPF.ar(Decimator.ar(SoundIn.ar(0), 18900, 12), 5000), 400) }.play

{ SoundIn.ar(1) }.play
