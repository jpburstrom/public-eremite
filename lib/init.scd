//Init paths and load all the other lib files.
//TODO: make it possible to use other interpreter variables
// (using this.interpret("whatever"))
var initFunc = { arg settings;

    var make = {

        u !? { u.free };
        q !? { q.freeAll };

        q = Setup({

            ~song = settings.song ? "setup";
            ~settings = settings;

            ~path = ().make({
                //This is meant to be executed from main file, so
                //base is relative to that.
                ~base = settings.basePath ?? { "".resolveRelative };

                ~lib = ~base +/+ "lib";
                ~instr = ~base +/+ "instr";
                ~patterns = ~base +/+ "patterns";
                ~samples = ~base +/+ "samples";
                ~data = ~base +/+ "data";
                ~storage = ~data +/+ "store-" ++ q.song.asString ++ ".zarchive";

                Instr.dir = ~instr;
                Sample.dir = ~samples;
                SFP.dir = ~samples;
            });

            ~find = { arg what, path;
                q.path.at(what) +/+ path
            };

            topEnvironment.use({
                (q.path.lib +/+ "*").pathMatch
                .reject({ |x| x == thisProcess.nowExecutingPath })
                .do{ arg x;
                    if (settings.verbose == true) { q.dbg("Load", x) } ;
                    x.load;
                };
            });

            //Library.put(\brstrm, \tmpDocDir, ~path.base +/+ "sandbox");

            ~lastCall = Setup({
                if(q.settings.resetStorage != true) {
                    q.dbg("Loading settings");
                    q.store.revertFromFile;
                }
            });


        });

        Toolbar.replace('-Q-');
        Toolbar.replace('Init', { initFunc.( q.settings.make { ~basePath = q.path.base } ) });
        Toolbar.replace('Store', { q.store.writeToFile });
        Toolbar.replace('Recall', { q.store.revertFromFile });
        Toolbar.replace('Store', { "Writing file".postln; q.store.writeToFile });
        Toolbar.replace('-!!!-');
        Toolbar.replace('Reboot', {
            s.quit;
            initFunc.( q.settings.make { ~basePath = q.path.base } );
        });
        Toolbar.replace('-!!!!-');
    };



    make.value;


};

initFunc
