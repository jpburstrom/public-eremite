n = NetAddr("192.168.1.122", 12345)
n.sendMsg("/freq", 250)
n.sendMsg("/amp", 1)
n.sendMsg("/on", 1)
n.sendMsg("/off", 1)

n = NetAddr("169.254.190.121", 12345)




~setOff = { [p,q,r,z].do(_.sendMsg("/off")) }



k = NetAddr("127.0.0.1", 12345)
k.sendMsg("/freq", 440)
k.sendMsg("/amp", 1)


x = NetAddr("192.168.1.102", 12345)
x.sendMsg("/freq", 259)
x.sendMsg("/amp", 1)
x.sendMsg("/on", 1)
x.sendMsg("/off", 1)


p = NetAddr("169.254.57.252", 12345);
q = NetAddr("169.254.124.73", 12345);
r = NetAddr("169.254.7.16", 12345);
z = NetAddr("169.254.193.132", 12345);

[p,q,r,z].do(_.sendMsg("/off"))
(
Tdef(\phone1, {
    loop {
        var w;
        p.sendMsg("/freq", [52, 48, 47].choose.midicps);
        p.sendMsg("/amp", (-12).rrand(12).dbamp);
        p.sendMsg("/on");
        w = 0.1.rrand(0.2);
        w.wait;
        p.sendMsg("/off");
        p.sendMsg("/vibrate");
        (0.3-w).wait;
    }
}).play;

Tdef(\pod1, {
    loop {
        var w;
        q.sendMsg("/freq", [60, 56, 55].choose.midicps);
        q.sendMsg("/amp", (-12).rrand(12).dbamp);
        q.sendMsg("/on");
        w = 0.1.rrand(0.2);
        w.wait;
        q.sendMsg("/off");
        q.sendMsg("/vibrate");
        (0.3-w).wait;
    }
}).play;

Tdef(\pod2, {
    loop {
        var w;
        r.sendMsg("/freq", [69, 65, 64].choose.midicps);
        r.sendMsg("/amp", (-12).rrand(12).dbamp);
        r.sendMsg("/on");
        w = 0.1.rrand(0.2);
        w.wait;
        r.sendMsg("/off");
        r.sendMsg("/vibrate");
        (0.3-w).wait;
    }
}).play;
Tdef(\pod3, {
    loop {
        var w;
        z.sendMsg("/freq", [69, 62, 64].choose.midicps * 2);
        z.sendMsg("/amp", (-12).rrand(12).dbamp);
        z.sendMsg("/on");
        w = 0.1.rrand(0.2) * 2;
        w.wait;
        z.sendMsg("/off");
        z.sendMsg("/vibrate");
        (0.3-w * 2).wait;
    }
}).play
)
Tempo.bpm = 60
