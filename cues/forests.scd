[\parus, \parus2, \hackspett, \sparrow, \cuculus].do { |item|
    SpawnerCue(item, {
        ~player = Pdef(item);
    });
};

NodeProxyCue(\forestnoise1, {
    ~player = Ndef(\forestamb1, { Pan2.ar(HPF.ar( PinkNoise.ar, LFNoise2.ar(1).exprange(440, 880)) * 0.013, -1) });
    ~fadeIn = 2;
    ~fadeOut = 40;
    ~out = 0;
    ~vol = -3.dbamp;
});

NodeProxyCue(\forestnoise2, {
    ~player = Ndef(\forestamb2, { Pan2.ar(HPF.ar( PinkNoise.ar, LFNoise2.ar(1).exprange(440, 880)) * 0.013, -0.6) });
    ~fadeIn = 2;
    ~fadeOut = 40;
    ~out = 0;
    ~vol = -3.dbamp;
});

NodeProxyCue(\forestnoise3, {
    ~player = Ndef(\forestamb3, { Pan2.ar(HPF.ar( PinkNoise.ar, LFNoise2.ar(1).exprange(440, 880)) * 0.013, -0.6) });
    ~fadeIn = 2;
    ~fadeOut = 40;
    ~out = 0;
    ~vol = -3.dbamp;
});

NodeProxyCue(\forestnoise4, {
    ~player = Ndef(\forestamb4, { Pan2.ar(HPF.ar( PinkNoise.ar, LFNoise2.ar(1).exprange(440, 880)) * 0.013, -0.6) });
    ~fadeIn = 15;
    ~fadeOut = 30;
    ~out = 0;
    ~vol = -3.dbamp;
});

NodeProxyCue(\forestAudience, {
    ~player = Ndef(\forestamb5, { HPF.ar( PinkNoise.ar, LFNoise2.ar(1).exprange(440, 880)) * 0.013 });
    ~fadeIn = 2;
    ~fadeOut = 40;
    ~out = q.ch.audience.outbus.index;
    ~vol = 0.dbamp;
});

OneShotCue('Reload phones', { "Reloading phones".postln; MyPhones.reload });

GroupCue(\forest1, {
    ~cues = CueList['Reload phones', \forestnoise1, \forestAudience, \cuculus];
});

GroupCue(\forest2, {
    ~cues = CueList['Reload phones', \forestnoise2, \sparrow, \cuculus, \hackspett, \parus, \parus2];
});

GroupCue(\forest3, {
    ~cues = CueList['Reload phones', \forestnoise3,  \sparrow, \cuculus, \hackspett, \parus2];
});

GroupCue(\forest4, {
    ~cues = CueList['Reload phones', \forestnoise4, \sparrow, \cuculus, \hackspett, \parus2, \crickets];
});

GroupCue(\forest4StopBirds, {
    ~cues = CueList[\stop-> \sparrow, \stop->\cuculus, \stop->\hackspett, \stop->\parus2, \stop->\crickets];
});

GroupCue(\lastForest, {
    ~cues = CueList['Reload phones', \cuculus, \sparrow, \hackspett, \parus2, \crickets_last, \wildpig_last];
});

NodeProxyCue(\forest).play