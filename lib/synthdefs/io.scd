Instr("io.soundIn1", { arg ch=0;
    //1-channel SoundIn
    SoundIn.ar(ch)
}, [ControlSpec(0, 127, \linear, 1, 0, "Bus")]);

Instr("io.soundIn2", { arg ch=0;
    //2-channel SoundIn
    SoundIn.ar([\ch.kr, \ch.kr + 1])
}, [ControlSpec(0, 127, \linear, 1, 0, "Bus")]);

Instr("io.in1", { arg ch=16;
    //1-channel In
    In.ar(ch)
}, [ControlSpec(0, 127, \linear, 1, 0, "Bus")]);

Instr("io.in2", { arg ch=16;
    //2-channel In
    In.ar([\ch.kr, \ch.kr + 1])
}, [ControlSpec(0, 127, \linear, 1, 0, "Bus")]);


q.reaperIn = Patch("io.soundIn2", [0]).play

q.reaperIn.release

Patch("io.soundIn1", [0]).play

Patch("io.soundIn1", [1]).play
