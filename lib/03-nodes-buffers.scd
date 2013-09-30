
q.make({
    "Loading server stuff".postln;

    //Buses
    q.makeSetup(\bus, {

        //~anaIn = Bus.audio(s, 1)

        //Buses
        //Map first 8 channels to names (q.bus.left etc)
        #[left, right, table, audience, forest1, forest2, forest3, forest4]
        .do({ arg x, i; currentEnvironment[x] = Bus(\audio, i) });


        ~test = Bus.audio(s, 2); //TEST


        //Jack outputs
        /*
        ~out1 = Bus(\audio, 0);
        ~out2 = Bus(\audio, 2);
        ~out3 = Bus(\audio, 4);
        ~out4 = Bus(\audio, 6);

        //Other useful buses
        ~in1L = Bus.audio(s, 1); // mono busses
        ~in1R = Bus.audio(s, 1);
        ~in1 = Bus.audio(s, 2); //Stereo busses
        ~in2 = Bus.audio(s, 2);
        ~in3 = Bus.audio(s, 2);
        ~in4 = Bus.audio(s, 2);
        */


    }, \boot);

    q.makeSetup(\ch, {
        ~main = MixerChannel(\main, s, 2, 2);
        ~table = MixerChannel(\table, s, 2, 2);
        ~table.newPostSend(q.bus.test, 1); //TEST



        ~makeBoard = {
            ~mb.free;
            ~mb = MixingBoard("CH", nil, ~mixerChannels.().asArray)
        };

        ~mixerChannels = {
            currentEnvironment.select(_.isKindOf(MixerChannel));
        };

        ~saver = SimpleController(q).put(\store, e { arg s, wh, store;
            store.ch = ();
            ~mixerChannels.().keysValuesDo { arg k, v;
                store.ch[k] = (
                    controls: v.controls.collect(_.value),
                    pre: ~table.preSends.collectAs({arg s; s.outbus.index -> s.level }, Event),
                    post:~table.postSends.collectAs({arg s; s.outbus.index -> s.level }, Event)
                )

            };
        }).put(\recall, e { arg s, wh, store;
            ~mixerChannels.().keysValuesDo { arg k, v;
                var env = store.ch[k];
                env !? {
                    v.setControls(env[\controls]);
                    v.preSends.do({ |x|
                        var lvl = env[\pre][x];
                        lvl !? { x.level = lvl };
                    });
                    v.postSends.do({ |x|
                        var lvl = env[\post][x];
                        lvl !? { x.level = lvl };
                    });
                }
            };
        });
    });

    //Buffers
    q.makeSetup(\buf, {
        ~envs = ().make {
            ~grain = ().make {
                q.envs.grain.keysValuesDo { arg label, env;
                    currentEnvironment[label] = Buffer.sendCollection(s, env.discretize);
                }
            }
        };

        /*
        (
            snickargladje: {
                q.smpLoad('banks/hits');
            }

        ).at(q.song).value
        */

    }, \boot);



    //Server Groups
    q.makeSetup(\grp, {
        //We set up 5 main buses
        [\in, \ctl, \syn, \ins, \fx].do { arg sym;
            currentEnvironment[sym] = Group.tail;
        };


    }, \tree);

    //inputs (
    /*
    q.makeSetup(\inputs, {

        Synth(\soundIn, [\bus, 0, \outbus, q.bus.anaIn], q.grp.in);

    }, \tree);

    //FX (
    q.makeSetup(\ins, {

    }, \tree);

    q.makeSetup(\fx, {

    }, \tree);

    //Controls (

    q.makeSetup(\ctl, {
        q.makeCtl(\onsets, \anaOnsets, [\bus, q.bus.anaIn], 1);
        q.makeCtl(\pitch, \anaPitch, {[\bus, q.bus.anaIn, \trig, q.bus.ctl_onsets.asMap]}, 2);
        q.makeCtl(\amplitude, \anaAmp, {[\bus, q.bus.anaIn, \trig, q.bus.ctl_onsets.asMap]});
        q.makeCtl(\spectral, \anaSpectral,
            {[\bus, q.bus.anaIn, \trig, q.bus.ctl_onsets.asMap]}, 2);

    }, \tree);
    */

});