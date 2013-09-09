SynthDef(\test, { arg freq=440, amp=0.2;
    Out.ar(0, MdaPiano.ar(freq, \gate.kr, amp / 127));
}).add

Synth(\help_mdapiano)


//instatiate object
~sfrand = SFRand.new((1..12)/12, 1.2);
~sfrand2 = SFRand.new((1,2.1..12) ++ [15], 1.2);
~sfrand3 = SFRand.new((1..3)/3, 1.2);
~sfrand4 = SFRand.new((1,2.1..12), 1.2);

~sfrand2.values

//...and again, now taking history into account
b = ~sfrand.next;

(
Pbind(\instrument, \help_mdapiano, \note, Pfunc { ~sfrand2.next.postln}, \dur, Pfunc { ~sfrand.next } ).play;
Pbind(\instrument, \help_mdapiano, \note, Pfunc { [-12 + ~sfrand4.next]}, \dur, Pfunc { ~sfrand3.next } ).play
)


~sfrand.next
    ~sfrand.probByValue(12)
    ~sfrand.weights
    