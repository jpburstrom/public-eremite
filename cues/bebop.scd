

OneShotCue(\changeBebopOut, {

    var mixerChannel =  { q.ch.bebop }.value;
    var send = { q.ch.bebop.preSends[0] }.value;

    send.level = mixerChannel.level;
    mixerChannel.level = 0;

});



OneShotCue(\bebopStop, {
    SFCue(\hihatloop).stop;
    SFCue(\bebopdrums).stop;
});



OneShotCue(\bebop_oneshot_stop, {
    fork {
        0.01.wait;
        SFCue(\bebop_oneshot).stop;
    }
});

