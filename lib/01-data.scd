
q.make({

    q.dbg("Loading data");

    //SPECS
    //Overwriting default gate, this can be used for release
    Spec.specs[\gate] = NoLagControlSpec(0, 127);
    Spec.specs[\susLevel] = \amp.asSpec;
    Spec.specs[\attack] = \slope.asSpec;
    Spec.specs[\decay] = \slope.asSpec;
    Spec.specs[\release] = \slope.asSpec;
    Spec.specs[\dur] = \slope.asSpec;
    Spec.specs[\curve] = NoLagControlSpec(-20, 20);

    //Mix down 2>1
    MixerChannelDef(\mix2x1, 2, 1,
        SynthDef("mixers/Mxb2x1", {
            arg busin, busout, level;
            var in;
            in = In.ar(busin, 2) * level;
            in = Mix(in);
            // so that mixerchan bus can be used as postsendbus
            ReplaceOut.ar(busin, in);
            Out.ar(busout, in);
        }),
        (level: (spec: \amp, value: 0.75)),
        MixerChannelDef.at(\mix1x1).guidef
    );


    ~data = ();


    //--------Song-specific data

    ().at(~song).value;

    ~envs = ().make {
        ~grain = ().make {
            //Envelopes, all scaled to 1 second
            ~rect = Env.linen(0.02, 0.96, 0.02); //almost, let's have some fade in and out
            ~tri = Env([0,1,0], [0.5,0.5]);
            ~hann = Env([0,1,0], [0.5,0.5], curve:\sin);
            ~tukey = Env.linen(0.25, 0.5, 0.25, curve: \sin);
            ~expodec = Env([0, 1, 0], [0.02, 0.98], curve: \cub);
            ~rexpodec = Env([0, 1, 0], [0.98, 0.02], curve: \cub);
            //approximate sinc
            ~sinc = Env([ 0, -0.0909, 0.1273, -0.2122, 1.0, -0.2122, 0.1273, -0.0909, 0 ],
                [ 0.0625, 0.125, 0.125, 0.1875, 0.1875, 0.125, 0.125, 0.0625 ],
                \sin);
        }
    };

    //Persistent storage thing, at q.store
    if (File.exists(q.path.storage)) {
        var z = ZArchive.read(q.path.storage);
        ~store = z.readItem(Event);
        z.close;
    }{
        ~store = (
            autoscale: (),
            revertFromFile: {
                q.make {
                    var z = ZArchive.read(q.path.storage);
                    ~store = z.readItem(Event);
                    z.close;

                }
            },
            writeToFile: {
                var z = ZArchive.write(q.path.storage);
                z.writeItem(q.store);
                z.writeClose;
            }
        )
    }

});
