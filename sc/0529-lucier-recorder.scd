(
~buffers = 2.collect { Buffer.alloc(s, 4800000) };
~current = 0;


SynthDef(\ererecorder, { arg buf=0;
    RecordBuf.ar(OpLPF.ar(Mix(SoundIn.ar([0,1])), 1000), buf);
}).add;

SynthDef(\ereplayer, { arg buf=0;
    Out.ar(0, PlayBuf.ar(1, buf, LFNoise0.ar(1, 0.5, 0.6)))
}).add;

~switch = {
    var playBuf;
    ~recSynth.free;
    ~playSynth.free;
    ~current = (~current + 1) % 2;
    playBuf = (~current + 1) % 2;


    ~recSynth = Synth(\ererecorder, [\buf, ~buffers[~current]]);
    ~playSynth = Synth(\ereplayer, [\buf, ~buffers[playBuf]])

}
)
//PREP
~buffers.do(_.zero)

~liveMic = { OpLPF.ar(SoundIn.ar(0), 1000) * 1.8}.play(s);
//"WRONG DRAWER";
//START
~switch.value; ~startTime = Clock.beats;
//NEXT
(
~liveMic.free;
~loopLength = Clock.beats - ~startTime;
~recordRoutine = fork {
    loop {
        ~switch.value;
        ~loopLength.wait;
    }
}
)
//STOP
~recordRoutine.stop; ~recSynth.free; ~playSynth.free;