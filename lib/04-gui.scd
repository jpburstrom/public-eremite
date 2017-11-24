
q.on(\init, {

    u = Proto({
        ~makeUI = {
            ~boards = [MixingBoard("Outputs", nil, q.ch.outs.collect( { arg x; q.ch[x[0]] }))];
        };
        ~free = {
            ~boards !? { ~boards.do(_.free) };
        };

        ~rebuild = {
            ~free.(); ~makeUI.();
        }

    });

    u.makeUI;

});



q.on(\boot, {
    u !? {
        u.rebuild;
    }
});

