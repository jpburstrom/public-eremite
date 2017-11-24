

SFCue.fromFile("/Volumes/HD2/projects/eremite/render/bell.wav", \bell,
    {
        ~volume = 0.5;
        ~quant = 0.5
});

q.lastRenderedToCue(
    "hihatloop", \hihatloop,  {
        ~volume = 12;
        ~quant = 1;
        ~stopQuant = 0;
        ~loop = true;
        ~mixerChannel = q.ch.lamp
});

q.lastRenderedToCue(
    "bebopdrums", \bebopdrums,  {
        ~volume = 6;
        ~quant = 1;
        ~stopQuant = 0;
        ~mixerChannel = q.ch.bebop;
});


q.lastRenderedToCue(
    "bebop-oneshot", \bebop_oneshot,  {
        ~volume = 1;
        ~quant = 0;
        ~stopQuant = 1;
        ~fadeOut = 1;
        ~mixerChannel = q.ch.bebop;
});


q.lastRenderedToCue(
    "bebop", \bebopmusic,  {
        ~volume = 1;
        ~quant = 0.5;
        ~stopQuant = 0.5;
        ~fadeOut = 0;
        ~mixerChannel = q.ch.table
});

q.lastRenderedToCue(
    "bebop-audience", \bebopAudience,  {
        ~volume = -6.dbamp;
        ~quant = 0.5;
        ~fadeOut = 30;
        ~mixerChannel = nil;
        ~outbus = 0
});

q.lastRenderedToCue(
    "question", \collectQuestionnaires,  {
        ~volume = -17.dbamp;
        ~quant = 0.5;
        ~fadeOut = 10;
        ~mixerChannel = q.ch.stereo
});

q.lastRenderedToCue(
    "share-b", \shareB,  {
        ~volume = -8.dbamp;
        ~quant = 1;
        ~fadeIn = 40;
        ~fadeOut = 0;
        ~preWait = 0;
        ~mixerChannel = q.ch.stereo
});

q.lastRenderedToCue(
    "sorting", \sorting,  {
        ~volume = 12.dbamp;
        ~quant = 1;
        ~fadeIn = 20;
        ~fadeOut = 1;
        ~stopQuant = 0;
        ~preWait = 0;
        ~mixerChannel = q.ch.stereo
});

q.lastRenderedToCue(
    "sortingdrone2", \sortingdrone,  {
        ~volume = 6.dbamp;
        ~quant = 0;
        ~fadeOut = 10;
        ~preWait = 0;
        ~outbus = 0;
});

q.lastRenderedToCue(
    "sorting-drone", \sortingdroneonly,  {
        ~volume = 3.dbamp;
        ~quant = 0;
        ~fadeIn = 20;
        ~fadeOut = 10;
        ~preWait = 0;
        ~outbus = 0;
});

q.lastRenderedToCue(
    "string-filler", \stringFiller,  {
        ~volume = -6.dbamp;
        ~quant = 0;
        ~fadeOut = 10;
        ~mixerChannel = q.ch.table
});

q.lastRenderedToCue(
    "happy-strings", \happyStrings,  {
        ~volume = -3.dbamp;
        ~quant = 0;
        ~fadeOut = 2;
        ~mixerChannel = q.ch.stereo
});

q.lastRenderedToCue(
    "happy-strings", \happyStrings2,  {
        ~volume = -3.dbamp;
        ~quant = 0;
        ~fadeOut = 20;
        ~mixerChannel = q.ch.stereo
});

q.lastRenderedToCue(
    "happy-strings-harp", \happyStringsHarp,  {
        ~volume = 18.dbamp;
        ~quant = 0;
        ~fadeOut = 30;
        ~mixerChannel = nil;
        ~outbus = 0;
});


q.lastRenderedToCue(
    "happyharp-papers", \happyStringsHarpPapers,  {
        ~volume = 0.dbamp;
        ~quant = 0;
        ~fadeOut = 30;
        ~mixerChannel = nil;
        ~outbus = 0;
});


q.lastRenderedToCue(
    "happy-strings-harp", \happyStringsHarpForest,  {
        ~volume = 16.dbamp;
        ~preWait = 22;
        ~quant = 0;
        ~fadeOut = 30;
        ~mixerChannel = q.ch.forest_monitor
});

q.lastRenderedToCue(
    "zimmer-ny", \zimmer,  {
        ~volume = 3.dbamp;
        ~quant = 0;
        ~fadeOut = 1;
        ~mixerChannel = q.ch.zimmer
});

q.lastRenderedToCue(
    "zimmerharp", \zimmerharp,  {
        ~volume = 0.dbamp;
        ~quant = 0;
        ~fadeOut = 0;
        ~mixerChannel = q.ch.stereo
});
q.lastRenderedToCue(
    "shareb-end", \shareEnd,  {
        ~volume = -12.dbamp;
        ~quant = 0;
        ~fadeOut = 25;
        ~mixerChannel = nil;
        ~outbus = 0;
});

q.lastRenderedToCue(
    "wildpig", \wildpig,  {
        ~volume = 1;
        ~quant = 0;
        ~fadeOut = 5;
        ~loop = true;
        ~mixerChannel = q.ch.tower
});

q.lastRenderedToCue(
    "wildpig", \wildpig_last,  {
        ~volume = -24.dbamp;
        ~quant = 0;
        ~loop = true;
        ~mixerChannel = q.ch.tower
});

q.lastRenderedToCue(
    "crickets", \crickets,  {
        ~volume = 1;
        ~quant = 0;
        ~fadeOut = 5;
        ~loop = true;
        ~mixerChannel = q.ch.forest_lamp
});

q.lastRenderedToCue(
    "crickets", \crickets_last,  {
        ~volume = -18.dbamp;
        ~quant = 0;
        ~loop = true;
        ~mixerChannel = q.ch.forest_lamp
});


