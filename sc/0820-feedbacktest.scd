{
    var snd = SoundIn.ar(0);

    DelayN

    SwitchDelay.ar(snd, 1, 1, LFNoise0.kr(1).range(0.01, 0.5), 0.3)


}.play

b = Buffer.alloc(s, s.sampleRate, 1)

(
{
    var local = LocalIn.ar(1);
    var amp;
    amp = RunningSum.kr(Amplitude.kr(local), 5) / 5;
    local = Mix(SinGrain.ar(Impulse.kr(amp.max(0.01).poll * 55), 0.4, LFNoise0.kr(500).range(70,78)) + (local * 0.6)) ;
    LocalOut.ar(DelayC.ar(LeakDC.ar(local * -1), 1, 0.01));
    local.tanh * 0.1.dup;
}.play
)

(
{
    var local = LocalIn.ar(1);
    var amp;
    amp = RunningSum.kr(Amplitude.kr(local), 10) / 10;
    local = Mix(SinGrain.ar(Impulse.kr(8 / amp.max(0.001).poll), 0.14, LFNoise0.kr(500).range(100,100)) + (local * 0.5)) ;
    LocalOut.ar(LeakDC.ar(local));
    local.clip * 0.1.dup;
}.play
)

(
{
    var local = LocalIn.ar(1);
    var amp;
    amp = RunningSum.kr(Amplitude.kr(local), 10) / 10;
    local = Mix(SinGrain.ar(Impulse.kr(10), 0.54, LFNoise0.kr(500).range(12550,15554)) + (local * 0.5)) ;
    LocalOut.ar(LeakDC.ar(local));
    LPF.ar(local.clip * 0.1.dup, 3600);
}.play
)
