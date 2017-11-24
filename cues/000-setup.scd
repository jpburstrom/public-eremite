
StatefulCue(\changeZimmerOut, {
    ~player = {
        var mixerChannel =  { q.ch.zimmer }.value;
        var send = { q.ch.zimmer.preSends[0] }.value;

        var target = mixerChannel.level;
        fork {
            101.do { |i|
                var lvl = ((i * 0.01) * target);
                send.level = lvl;
                mixerChannel.level = target - lvl;
                0.01.wait;
            }
        }
    };

});


q.lastRenderedToCue = { arg ev, search, name, func;
    var file = (q.renderdir +/+ search ++ "-20*.wav").pathMatch.last;
    if (file.notNil) {
        SFCue.fromFile(file, name, func);
    } {
        ("Rendered file % not found".format(search).warn)
    }
};

fork {
    101.do { |i|
        ((i * 0.01) * 1).postln;
        (1/100).wait;
    }
}