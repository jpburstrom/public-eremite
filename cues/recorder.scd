SynthDef("cue-recorder", {arg bufnum, bus;
    DiskOut.ar(bufnum, In.ar(bus));
}).send(s);


AsyncCue(\recorder, {
    ~loader = {
        //Assuming 7 outputbuschannels + 1 input bus
        ~buffers = 9.collect { Buffer.alloc(s, 262144, 1) };
    };
    ~play = {
        var path = "/Volumes/Mega/PublicEremiteRec/PublicEremite_" ++ Date.localtime.stamp ++ "%.wav";
        ~synths = ~buffers.collect { |buf, i|
            buf.write( path.format(i), "wav", "int24", 0, 0, true);
            Synth.tail(0, "cue-recorder", ["bufnum", buf, "bus", i]);
        };
        ~rout = fork {
            var i=0;
            loop {
                "Recorded % seconds".format(i).postln;
                5.wait;
                i = i + 5;
            }
        };

        ~addToCleanup = e {
            ~synths.do(_.free);
            ~buffers.do { |x| x.close; x.free };
            ~rout.stop;
        }
    };

});


