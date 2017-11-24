q.ch.do(_.free);
q.mixingboard.free;

q.ch = (
    fl: MixerChannel(\FL, s, 1, 1, 1, outbus: 0),
    fr: MixerChannel(\FR, s, 1, 1, 1, outbus: 1),
    bl: MixerChannel(\BL, s, 1, 1, 1, outbus: 2),
    br: MixerChannel(\BR, s, 1, 1, 1, outbus: 3),
    room: MixerChannel(\room, s, 1, 1, outbus: 4),
    table: MixerChannel(\bord, s, 1, 1, outbus: 5),
    lamp: MixerChannel(\lampa, s, 1, 1, outbus: 6),
    audience: MixerChannel(\publik, s, 1, 1, outbus: 7),
    horn: MixerChannel(\horn, s, 1, 1, outbus: 8),
);

//Set mixerchannel levels


q.mixingboard = MixingBoard(mixers: [q.ch.fl, q.ch.fr, q.ch.bl, q.ch.br, q.ch.room, q.ch.table, q.ch.lamp, q.ch.audience, q.ch.horn])

