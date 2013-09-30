x = CV(); y = CV()

x.value = 0.5

x.gui
y.value


QWindow().layout_(VLayout(DragSource().object_(x).string_("X"), DragSink().object_(y).canReceiveDragHandler_({View.currentDrag.isKindOf(CV)}).receiveDragHandler_({ y.value = View.currentDrag.value} ))).front


))

//GC är en variant på GenericGlobalControl
Pbind(\dur, GC(\pdur, 0.1, [0.1, 1, \exp])).play
//
GC(\pdur).gui
GCM(\pdur, 0, 1)


Event

[0,10].asChannelIndex

