// ~path   = "/tmp/r1_ortf.wav";
~path   = "/tmp/r1_ortf-48k.wav";
~path = "/Volumes/Mega/samples/impulses/Samplicity M7 Main - 02 - Wave, 32 bit, 48 Khz, v1.1/M7 - 1 Halls 06 Small & Near/1 Halls 06 Small & Near L.wav"
~path = "/Volumes/HD2/projects/eremite/render/impulse-next door.wav"
~path = "/Volumes/Mega/samples/impulses/Samplicity M7 Main - 02 - Wave, 32 bit, 48 Khz, v1.1/M7 - 3 Rooms 17 Small Vox Room/3 Rooms 17 Small Vox Room  M-to-S.wav"
~ezConv.free
~ezConv = EZConv(~path);

// inspect
~ezConv.numChannels;
~ezConv.irSpectrum;

(
// A simple test.
x = play {
       // var o = PinkNoise.ar(0.5 ! 2) * Decay2.ar(Impulse.ar(0.5), 0.15, 0.75);
    var o = SoundIn.ar(0);
    // stereo source
        ~ezConv.ar(o, leak: 0.1, mul: 0.5); // watch out for gain buildup when convolving.
    }
)

s.meter

s.options.sampleRate
= 48000
s.quit
StageLimiter
Quarks.gui