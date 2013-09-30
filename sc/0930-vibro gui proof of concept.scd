var x, w = Window();
var values = ($1:[1,0,0], $2:[0,1,0], $3:[0,0,1]);
var current = [1, 0, 0];
var target = nil;
var positions = ($1:[0.5, 1], $2:[0, 1], $3:[0.5,0.2]);
var pcur = positions[$1].copy;
var ptar = nil;
w.layout_(VLayout(
    y = StaticText().string_("Hello"),
    x = Slider().step_(0.02).shift_scale_(0.5).alt_scale_(2).action_({ arg x;
        z.setXY(*pcur.blend(ptar, x.value));

        if (x.value == 1) {
            current = current.blend(target, 1);
            pcur = pcur.blend(ptar, 1);
            x.enabled = false;
            x.value = 0;
        }
    }).orientation_(\vertical).enabled_(false),
    z = Slider2D(),
));

w.view.keyDownAction = { arg ... args;
    var c = args[1];
    if (c == $q) {
        current = current.blend(target, x.value);
        pcur = pcur.blend(ptar, x.value);
        x.value = 0;
        x.enabled = false;
    };

    if (values[c].notNil) {
        y.string_("Doing %".format(args[1]));
        target = values[c];
        ptar = positions[c];
        x.enabled_(true).focus(true);
        x.value = 0;
    }
};

w.front

