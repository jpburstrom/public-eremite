(
s.waitForBoot {
    Instr("sampletest3", { arg sample, gate=1, rate=1;
        PlayBuf.ar(sample.numChannels, sample.bufnumIr, sample.bufRateScaleKr * rate) * EnvGen.kr(Env.cutoff, gate, doneAction:2);
    }, [\sample, NoLagControlSpec(), \rate]);
    a = Sample("/Volumes/HD2/projects/eremite/samples/birds/Björktrast 10_bjorktrast_-_turdus_pilar_32b3e86_a96.wav");
    Ppatch(Patch("sampletest3", [a]), Pbind(\dur, Pn(1,2))).trace.play()
}
x = Ppatch(Patch("sample-help", [a]), Pbind(\rate, 2.pow(Pwhite(-1.0, 1))))
)
Pfset({"Func".postln}, Pbind(\dur, Pn(1,2)), {"Cleanup".postln}).trace.play
Ppatch(Patch("sampletest3"), Pbind(\instrument, \default, \dur, Pn(1,2))).trace.play()

Pdef(\testhtsets
InstrSynthDef.clearCache
z = Patch("sampletest2", [a]);
z.server
x = Ppatch(Patch("sampletest2", [a]), Pbind(), false);
p = x.play
s.queryAllBuffers
y = Ppatch(Patch("sampletest3", [a]), Pbind(\instrument, \default, \dur, Pseq([2, 2, 0.5]), \rate, 2.pow(Pwhite(-1, 1.0))), false);
o = y.trace.play
2.pow(-1)
o.stop

y.patch.asSynthDef.add

p.stop
s.queryAllBuffers
y.free

s.queryAllBuffers

a.load

Pbind(\dur, Pseq([2, 2, 0.5]), \rate, 2.pow(Pwhite(-1, 1.0))).play


