//Find all phones on local network
(
var list = ("bash" + thisProcess.nowExecutingPath.dirname ++  "/find-hosts.sh").unixCmdGetStdOutLines;
~clients = ();
list = list.collect({ |str| str.split($ )[0].asSymbol; }).asSet;
list = (list & [
    'podx.local',
    'pod1.local',
    'pod2.local',
    'pod3.local',
    'phone1.local'
]).asList;

list.do { |key|
    ~clients[key.asString.split($.)[0].asSymbol] = NetAddr(key.asString, 12345);
}

~clients;

)


~clients.podx.sendMsg("/hello")