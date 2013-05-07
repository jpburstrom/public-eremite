//The sad and demanding dog
(
Tdef(\sadDemandingDog, {
    loop {
        Ndef(\high, { SinOsc.ar(68.0.rrand(70).midicps, 0, 0.4) }).play;
        1.rrand(1.5).wait;
        Ndef(\high).stop;
        1.rrand(4).wait;
    }
}).play;
)

Tdef(\sadDemandingDog).stop;

Ndef(\triThing, { RLPF.ar(Saw.ar(LFNoise1.kr(1).range(4, 24), 0.3), LFNoise1.kr(1).range(10, 10055), 1) } ).play;

Ndef(\triThing).stop;