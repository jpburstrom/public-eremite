//Specs are set in 01-data.scd
Instr("envgen.triangle",{ arg dur=1.0;
	Env.triangle(dur)
}, nil, \envtriangle);

Instr("envgen.sine",{ arg dur=1.0;
	Env.sine(dur)
}, nil, \envsine);

Instr("envgen.perc",{ arg attack=0.01, release=1.0, curve = -4.0;
	Env.perc(attack, release,1.0,curve)
}, nil,\envperc);

Instr("envgen.linen",{ arg attack=0.01, sustain=1.0,release=1.0, curve = -4.0;
	Env.linen(attack, sustain, release,1.0,curve)
}, nil,\envperc);


Instr("envgen.cutoff", { arg in, release=0.1, curve=-4, gate=1;
    in * EnvGen.kr(Env.cutoff(release, 1, 0, curve), gate, doneAction:2)
}, [\audio], \audio);

Instr("envgen.asr", { arg in, attack=0.02, susLevel=1, release=0.02, curve=-4, gate=1;
    in * EnvGen.kr(Env.asr(attack, susLevel, release, curve), gate, doneAction:2)
}, [\audio], \audio);

Instr("envgen.adsr", { arg in, attack=0.02, decay=0.3, susLevel=0.5, release=0.02, curve=-4, gate=1;
    in * EnvGen.kr(Env.adsr(attack, decay, susLevel, release, curve:curve), gate, doneAction:2)
}, [\audio], \audio);



