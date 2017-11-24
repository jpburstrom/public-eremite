AsyncCue(\changeMixerOut, {
    ~mixerChannel = m;

    ~loader = e {
        ~destination = [topEnvironment[\right], topEnvironment[\left]].choose;
        ~send = ~mixerChannel.newPreSend(~destination, 0);
    };
    ~player = e {
        fork {
            ~send.level = ~mixerChannel.level;
            ~mixerChannel.level = 0;
            ~mixerChannel.outbus = ~destination;
            ~server.latency.wait;
            //
            ~mixerChannel.level = ~send.level;
            ~send.level = 0;
            ~send.free;
            currentEnvironment.stop;
        }
    }
});

StatefulCue(\changeMixerOut2).stop
StatefulCue(\changeMixerOut2).load
StatefulCue(\changeMixerOut2)
StatefulCue(\changeMixerOut2).play


~null = Bus.audio(s, 2);
m = MixerChannel("Test", s, 1, 1, outbus:~null)
~left = MixerChannel("Test", s, 1, 1, outbus: 0)
~right = MixerChannel("Test", s, 1, 1, outbus: 1)

m.play { SinOsc.ar * 0.1 }
m.level
m.preSends


m.newPreSend(~left, 0)
m.newPreSend(~right, 0)


~switch = { arg dest;
    fork {
        var send, level = m.level;
        var bundle = List.new;

        send = m.newPreSend(dest, 0);
        (s.latency + 0.01).wait;
        m.level = 0;
        send.level = level;
        m.outbus = dest;
        s.latency.wait;
        send.level = 0;
        m.level = level;
        send.free;
    }
}


send

~switch.(~left)

~switch.(~right)

~dest = ~right
~level = 1
~send = m.newPreSend(~dest, 0);
0.5.wait;
m.level = 0;
~send.level = 1;
0.5.wait;
m.outbus = ~dest;
~send.level = 0;
m.level = 1;
0.5.wait;
~send.free;

x = m.preSends
