//PREP
(

SynthDef(\bd, {
    Out.ar(0, (SinOscFB.ar(\freq.kr(80), 0.4) * XLine.ar(6 * \amp.kr(1), 0.01, \sustain.kr(0.2), doneAction:2)).dup)
}).add;

Pdef(\bd, Pbind(
    \instrument, \bd,
    \dur, Pseq([3, 4, 5, 2, 6, 3, 4, 2], inf) * 0.25,
    \amp, Pwhite(0.2, 0.5, inf) * 0.05,
    \timingOffset, 0.05,
    \sustain, Pwhite(0.1, 0.6),
    \freq, Pwhite(60, 80)
));

)


//BDBDBDBD

Pdef(\bd).play;
Pdef(\empty, Pbind(\amp, Pseries(0, 0.01).fold(0, 0.1))).play;
Pdef(\empty).stop;
Pdef(\bd).stop


//VIBRO
(
~vibro = Proto({

    var slider, inc = 0.05, values = [0,0,0], win = Window.new;

    ~pSpace = ProxySpace();

    3.do { arg i;
        ~pSpace[i] = { Mix.fill(10, { SinOsc.ar(LFNoise2.kr(1).range(50, 60)) * 0.05 }) + (Mix(Decimator.ar(SinOsc.ar([1000, 850] + SinOsc.kr(LFNoise2.kr(0.1).range(3, 8), 0, 5)), 44100, 2)) * 0.005) };
        ~pSpace[i].vol = 0;
        ~pSpace[i].fadeTime = 1;
        ~pSpace[i].play(i);
    };

    win.view.keyDownAction = e { arg view, char, modifiers, unicode, keycode, key;
        var boo = { arg i;
            var temp = values[i];
            values = (values - inc).max(0);
            if (i >= 0) {
                values[i] = (temp + inc).min(1);
            }

        };
        switch(char,
            $0, { boo.(-1) },
            $1, { boo.(0) },
            $2, { boo.(1) },
            $3, { boo.(2) }
        );
        values.do({ |v, i| ~pSpace[i].vol = v; });
        slider.value_(values);
    };

    slider = MultiSliderView(win.view).size_(3).indexThumbSize_(40).value_(values);
    win.front;

    ~win = win;

});


)