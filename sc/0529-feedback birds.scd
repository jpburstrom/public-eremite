//Birdie 1
Ndef(\fb, {Limiter.ar(DelayC.ar(BPF.ar(SoundIn.ar(1), 700, 0.2), 1, LFNoise2.ar(10).range(0.1,2)), 0.5) * 2})

//Crazy feedback
(
Ndef(\fb, {
    Limiter.ar(
        DelayC.ar(
            BPF.ar(SoundIn.ar(1), LFNoise2.ar(1).range(220, 880), 0.1)
            , 1, LFNoise0.ar(0.1).range(1,2)),
        1)
})
)

//Crazy feedback
Ndef(\fb, {Limiter.ar(DelayC.ar(BPF.ar(SoundIn.ar(1), LFNoise2.ar(0.1).exprange(220, 880), 0.2), 1, LFNoise2.ar(1).range(1,2)), 0.5) * 2})

Ndef(\fb).play
Ndef(\fb).stop

Ndef(\back, { LPF.ar(SoundIn.ar(1, 0.58) * -1) + Decay.ar(Impulse.ar(LFNoise2.ar(1).exprange(0.1, 80)), 0.1)}).play

Ndef(\back).stop

