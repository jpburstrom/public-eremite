// See "http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/Arrays-as-SynthDef-arguments-for-the-birds-td7061974.html"

SynthDef("billbird", { arg dur, freq, freqskew, amp, t_gate;
       var freqenv, ampenv, freqenvctl, ampenvctl, sig;

       // make an empty 10 segment envelope
       freqenv = Env.newClear(10);
       ampenv = Env.newClear(10);

       // create a control argument array
       freqenvctl = NamedControl.kr(\freqenv, freqenv.asArray);
       ampenvctl = NamedControl.kr(\ampenv, ampenv.asArray);
       sig = SinOsc.ar(
           EnvGen.kr(freqenvctl, t_gate, freqskew, freq, dur), // freq
           0, // phase
           //amp);
           EnvGen.kr(ampenvctl, t_gate, amp, timeScale: dur, doneAction:
2)); // amplitude
       Out.ar(0, sig);
}).add;

SynthDef("billbigbird", { arg dur, freq, freqskew, amp, t_gate;
   var howmany = 20; // hard wire max number of partials
   var pnum = Array.fill(howmany, 0).postln; // partial numbers (zero =
'silent' partials as default);
   var pamp = Array.fill(howmany, 1).normalizeSum.postln; // partial amps
   var pnumctl = NamedControl.kr(\partialNumbers, pnum.asArray);
   var pampctl = NamedControl.kr(\partialAmps, pamp.asArray);
   var freqenv = Env.newClear(51);
   var ampenv = Env.newClear(51);
   var freqenvctl = NamedControl.kr(\freqenv, freqenv.asArray);
   var ampenvctl = NamedControl.kr(\ampenv, ampenv.asArray);

   var sig = DynKlang.ar(`[pnumctl, pampctl, nil], // KLANG: partials,
amplitudes, phases
                          EnvGen.kr(freqenvctl, t_gate, freqskew, freq,
dur), // KLANG: fundamental frequency
                       0) // KLANG: offset
                       * EnvGen.kr(ampenvctl, t_gate, amp, timeScale: dur,
doneAction: 2); // amplitude envelope

   Out.ar(0, sig);
 }).add;
)

~main_amp = Env([0, 1, 0.7, 1, 0], [0.25, 0.35, 0.15, 0.25], 'sine');
~main_amp.plot

// Rearrange breakpoint envelops from Bill
(
~getLevels = {arg array; array.clump(2).flop.at(1)};
~getTimes = {arg array; array.clump(2).flop.at(0).differentiate.drop(1)};
~getPartials = {arg array; array.clump(2).flop.at(0)}; // same as ~getLevels
~getPartialAmps = {arg array; array.clump(2).flop.at(1)};
)
(
var chipup = [0, 0.8, 0.15, 1, 0.75, 0.3, 1, 0]; // original chip-up freq-envelope from bill
var freqenv = Env(~getLevels.value(chipup), ~getTimes.value(chipup),
'sine');
~getLevels.value(chipup).postln;
~chipping_sparrow = Task({
   10.do({ // do this 17 times

       x = Synth("billbird", [
           \t_gate, 1,
           \amp, 0.05,
           \freqenv, freqenv,
           \freqskew, 2400,
           \freq, 2000,
           \dur, 0.05,
           \ampenv, ~main_amp,
       ]);
       0.02.wait;
   })});
)
~chipping_sparrow.start; // play it!