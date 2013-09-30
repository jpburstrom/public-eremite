(
Ndef(\bits, {
    var bits = (2 ** 8).asInt;
    var bitsdiv = 1 / (bits * 0.5);
    var t = PulseCount.ar(Impulse.ar(48000/10));
    var snd = 0;
    var c = [0, 1];
    snd = t ** ((t * 0.01) % 1) >> ((t * 1) % (bits * 3 >> 1));
    snd = snd + ((1000 % (t % ((500 - t) % (2 ** 12) + (c * 100)))).poll);
    snd = snd + ((t * 4 * (c + 3)) * 0.1);

    (((snd % bits) * bitsdiv) - 1)
}).play
)


