MIDIIn.connectAll

s.latency = 0.05
MIDIdef.noteOn(\test2, { ().play } )

MIDIdef(\test).free

48.asMIDINote


MIDIdef.cc(\test, { arg ... args; args.postln } )


~renoise = NetAddr("localhost", 8000)

~renoise.sendMsg('/renoise/transport/stop')


~stealer = Proto({
    ~playing = Set[];
    ~notes = (
        \c4: Proto({ ~play = {~test = Synth(\default)}; ~stop = {~test.release}})
    );
    ~play = { |num, vel|
        if (currentEnvironment.playing.includes(num).not) {
            currentEnvironment.playing.add(num);
            currentEnvironment.notes[num].play;
        } {
            "Already playing".postln;
        }
    };

    ~stop = { |num|
        currentEnvironment.notes[num].stop;
        currentEnvironment.playing.remove(num);
    }
})

z = SpawnerCue(\test3, { ~player = Pbind(\dur, 0.05, \note, Pwhite(0, 11)) } )
z.player = Pbind(\dur, 0.25, \note, Pwhite(0, 11))
z.play
z.quant = 0

z.stop(true); z.play
z.stop

Pbind().play

MIDIdef.noteOn(\reNoteOn, { arg vel, note;
    ~stealer.play((note + 12).asMIDINote.toLower.asSymbol, vel)
});

MIDIdef.noteOff(\reNoteOff, { arg vel, note;
    ~stealer.stop((note + 12).asMIDINote.toLower.asSymbol)
})

~stealer.play(\c4)
~stealer.stop(\c4);
~stealer.play(\c4)
~stealer.notes[\c4] = z
~stealer.playing
stop(\c4)

Voic
