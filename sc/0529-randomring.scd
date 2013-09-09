~phone = NetAddr("169.254.77.117", 12345)
~phone.sendMsg("/vibrate")
//RING
Tdef(\ring, {
    inf.do {
        2.do {
            ~phone.sendMsg("/vibrate");
            0.5.wait;
        };
        0.9.wait;
    }

});

Tdef(\ring).play
Tdef(\ring).stop

(
Tdef(\randomRing, {
    20.rrand(120).postln.wait;
    Tdef(\ring).play;
    15.wait;
    Tdef(\ring).stop;
})
)

Tdef(\randomRing).play
Tdef(\randomRing).stop

Ndef(\sin3).stop

{ SoundIn.ar(0) }.play

(
Tdef(\randomRingLoop, {
    {
        20.rrand(120).postln.wait;
        Tdef(\ring).play;
        (10.rrand(20)).wait;
        Tdef(\ring).stop;
    }.loop
})
)

Tdef(\randomRingLoop).play(quant:0)
Tdef(\randomRingLoop).stop

