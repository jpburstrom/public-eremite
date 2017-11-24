/*
TODOS
Watch phones fix
"Space for myself"
*/
(
q !? { q.do(_.free) } ?? ();
Server.default.options.hardwareBufferSize = 256;
s.waitForBoot {

    "/Volumes/HD2/projects/eremite/kod/lib/patterns/birds.scd".load;

    q.listgui ??  { q.listgui.remove };

    q.renderdir = "../render".resolveRelative;

    "mixerChannels.scd".loadRelative;
    q.ch.zimmer.doWhenReady {


        "cues/*".loadRelative;
        OneShotCue(\init, {
            "initing".postln;
            q.ch.bebop.level = 1;
            q.ch.bebop.preSends[0].level = 0;
            q.ch.zimmer.level = 1;
            q.ch.zimmer.preSends[0].level = 0;
            OneShotCue('SWITCH MONITOR->AUDIENCE', {});
            //SFCue(\hihatloop).stop;
            AbstractCue.all.do(_.reset);
            Ndef.all.localhost.do(_.end(0, true))
        });
        OneShotCue('Switch Monitor->Audience', { "Thank you".postln });
        OneShotCue('Check phones', { MyPhones.watch.makeGui });
        OneShotCue('Ok, done', { MyPhones.unwatch });
        OneShotCue('----', {"Ready".postln});



        (
            q.list = CueList[
                //Checklist
                'Check phones',
                'Ok, done',
                \lastForest,
                'SWITCH MONITOR->AUDIENCE',
                \hihatloop, //Hihat lamp should be turned off
                \stop -> \hihatloop,
                \vox_audience,
                \stop -> \vox_audience,
                '----',

                \init, //Init, see above
                \recorder, //Start recording, 8 channels + incoming mic
                \forest1, // Before audience entering
                \vox_audience, //I'll be there in two minutes
                \stop -> \vox_audience, //Stop after replik
                [\stop -> \forest1, \vox_audience, \happyStrings], // After doing small dance, L comes back to pult
                \stop -> \vox_audience, //L turns around, grabs smth
                \stop -> \happyStrings, //After a while, L walks away, turns head to audience
                \hihatloop, //Asap -- lamp is off
                \bebopdrums, //On L pushing button on table
                \changeBebopOut, //L standing on table making large hand movement
                \stop->\bebopdrums, //L pushing button on table
                \hackbell, //After "Globe of fire... might seem a bit..."
                \vox_audience, //L at pult, "Then she walked to the drawer"
                \stop -> \vox_audience, //After line
                \vox_audience, //After "but not quite"
                \stop -> \vox_audience, // After "dealing with private stuff"
                \stop->\hihatloop, //ASAP after L has turned off lamp
                \bebopAudience, // L pushes button on table
                [\collectQuestionnaires, \stop -> \bebopAudience],  //When L starts to collect Q
                \vox_share, //After private questions
                \shareBitch, //Right before last question, L at the table
                \sorting, //In the end of SB
                \stop -> \vox_share, //After L stops talking, grabs stack of papers
                \parus, // In the middle of the paper stack
                \stop -> \parus, //After a few peeps
                [\sortingdrone, \stop -> \sorting], //After L walks away when having sorted the papers
                \vox_audience_headset, //Lotta brings papers to pult, drar fram dem under armen
                \stop -> \vox_audience_headset, //After "I leave them in the forest"
                \pentaLove, //A while after L has done tillstånd
                \hackspett, //After a while
                \stop->\hackspett, //When the mole exits
                \hackbell, //When the mole has exited, wait a while
                [\stop -> \sortingdrone], //Right before next cue
                [\happyStringsHarp, \forest2, \happyStringsHarpForest, \stop->\pentaLove], //When backpack guy is raising with back to audience
                [\stop -> \happyStringsHarp, \sortingdroneonly], //Almost right away after first harp chorus
                \stop -> \sortingdroneonly, //Almost right away again
                \stop -> \forest2, //When L removes backpack
                //Stoppa fåglar
                \processing, //Start processing sound when L starts moving liggunderlag
                \bebop, //When taking 2nd stack of papers
                \processingResume, //Almost at the end of bebop, or when needed
                [\processingPause, \vox_audience_processing, \happyStrings], //When L lutar sig ner vid pult
                [\processingResume, \stop->\vox_audience_processing, \stop->\happyStrings], //When story is done
                [\processingStop, \zimmer], //When L pushes button
                \changeZimmerOut, //When L is ready with reading
                //FIXME: play zimmer in speaker
                [\happyStringsHarpPapers, \stop->\zimmer], //When L tosses papers
                \forest3, //After 2 lines of harp
                \stop -> \happyStringsHarpPapers, //After harp
                \stop -> \forest3, //When L has settled by fireplace
                [\vox_audience, \happyStrings2], //When L takes box
                \stop -> \vox_audience, //After last line
                \stop -> \happyStrings2, //Around L framing audience 2nd time
                [\stringFiller, \happyStrings], //After L saying "1,2,3 steps to the left"
                OneShotCue('SWITCH AUDIENCE->MONITOR', { "Thank you".postln }), //ASAP
                [\shareEnd, \stop -> \stringFiller, \stop -> \happyStrings, \forest4], //Before L comes to table
                //\vox_share,
                //\stop->\vox_share,
                [\stop -> \forestnoise4, \stop -> \shareEnd], //When L exits
                \forest4StopBirds, //The End
                //Forest 4
                \lastForest, //When audience starts to applaud
                \stop -> \recorder

            ];

            defer {
                q.listgui = q.list.gui;
            }
        );
        defer {
            MixingBoard(mixers:[q.ch.stereo, q.ch.table, q.ch.lamp, q.ch.audience, q.ch.forest_monitor, q.ch.forest_lamp, q.ch.sub, q.ch.tower])
        }
    }

}
)
RedSFPlayerDisk
MyPhones.watch.makeGui
MyPhones.unwatch

CueListGui

Pdef(\hackspett).play;
Pdef(\hackspett).stop;
Pdef(\parus).play;
Pdef(\parus).stop;
Pdef(\parus2).play;
Pdef(\parus2).stop;
Pdef(\cuculus).play;
Pdef(\cuculus).stop

StopCue(\parus).play

StopCue(\parus2).play
StopCue(\cuculus).play

AbstractCue(\hackspett).play
AbstractCue(\hackspett).stop

AbstractCue(\forest2).play

AbstractCue(\vox_share).play
AbstractCue(\vox_share).stop

StopCue(\vox_table1).play
AbstractCue(\vox_table2).stop

Ndef(\forestamb).play(fadeTime:2);
Ndef(\forestamb).stop(fadeTime:40);
MyPhones.reload
