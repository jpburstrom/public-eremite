{ Out.ar(2, Mix.fill(5, SinOsc.ar(LFNoise2.kr(1).range(45, 40)) * 0.1)) }.play


{ Out.ar(2, Mix.fill(5, { SinOsc.ar(LFNoise2.kr(1).range(45, 140)  ) * 0.1 } )) }.play

Tempo.bpm = 60

(
fork {
    loop {
        //"hello".postln;
        { Out.ar([0,1,3].choose, SinOsc.ar() * Line.kr(0.5, 0, 0.1, doneAction:2)) }.play;
        1.rrand(4).wait;
    }
}
)


{ Out.ar(2, SinOsc.ar(LFNoise2.kr(20).range(40, 120)) * 0.1) }.play


{ Out.ar(2, Mix.fill(5, { |i| SinOsc.ar(70 + (i*5)) * XLine.ar(0.5, 0.00001, 6, doneAction:2) } ) * 0.5) }.play

~gong = Buffer.read(s, "/Volumes/HD2/projects/eremite/gongong/gongong.wav")

(
Tdef(\eremite_events, {
    loop {
        //"hello".postln;
        [
            { Out.ar(0, Mix(PlayBuf.ar(2, ~gong, BufRateScale.kr(~gong)) * 0.5)) },
            { Out.ar(1, SinOsc.ar(1000) * XLine.kr(0.5, 0.0001, 0.6, doneAction:2).dup) },
            { Out.ar(2, Mix.fill(5, { |i| SinOsc.ar(70 + (i*5)) * XLine.ar(0.5, 0.00001, 6, doneAction:2) } ) * 0.5) }
        ].choose.play;


        [6,8,10,12].choose.wait;
    }
}).play
)


Tdef(\eremite_events).stop

{ PlayBuf.ar(2, ~gong, BufRateScale.kr(~gong)) }.play