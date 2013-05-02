//The sad and demanding dog
(
fork {
    loop {
        Ndef(\high, { SinOsc.ar(68.0.rrand(70).midicps, 0, 0.1) }).play;
        1.rrand(1.5).wait;
        Ndef(\high).stop;
        1.rrand(4).wait;
    }
}
)