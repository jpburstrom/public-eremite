OneShotCue(\headsetOn, {
    q.s.headset !? { q.s.headset.free };
    q.s.headset = q.ch.stereo.play({ SoundIn.ar(0) * 1 });
});
OneShotCue(\headsetOff, {
    q.s.headset !? { q.s.headset.free };
});

OneShotCue(\micOn, {
    q.s.mic !? { q.s.mic.free };
    q.s.mic = q.ch.audience.play({ SoundIn.ar(0) * 1 });
});
OneShotCue(\micOff, {
    q.s.mic !? { q.s.mic.free };
});