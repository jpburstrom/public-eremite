Instr("balance.amp", { arg in, amp=1;
    in * amp;
}, [\audio], \audio);

Instr("balance.panamp", { arg in, pan=0, amp=1;
    Pan2.ar(in, pan, amp);
}, [\mono], \stereo);

Instr("balance.spanamp", { arg in, pan=0, amp=1;
    var h, v;
    #h, v = in;
    Pan2.ar(v, min(0, max(-1, pan - 1))) + Pan2.ar(h, min(1, max(0, pan + 1)));
});

(
Instr("balance.balamp", { arg in, pan=0, amp=1;
    Balance2.ar(in[0], in[1], pan.poll, amp);
}, [\mono], \stereo);
)
