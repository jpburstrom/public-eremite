MarkovModel

ContextSnake

(
var out, sen = "Akustisk rundgång (eng. Acoustic feedback) är en ton som kan uppstå då en mikrofon tar in det en högtalare ger ut, då denna högtalare ger ut mikrofonens signal. Ljudet hamnar då i en cirkel genom att gå från högtalaren till mikrofonen till högtalaren igen tills man drar ned mikrofonens signal via mixerbordet, eller mikrofonen flyttas bort från högtalaren. Rundgång karaktäriseras oftast som ett snabbt växande tjut och kan vara öronbedövande. Vid tillräckligt lång tidsfördröjning, exempelvis i telefonisystem, uppfattas inte rundgången som en ton inom det hörbara frekvensområdet, utan som ett snabbt växande eko.";
sen = sen.split($.);
sen = sen.collect{ arg x; ( x ++ "." ) };
sen = sen.collect{ arg x; x.split($,) }.flatten;
sen = sen.collect(_.stripWhiteSpace);



out = 20.collect { |i|
    c = ContextSnake(sen, "då", i.fold(1, 2));	// try longer context again
    c.asStream.all.join;			// collect all next values until stream ends
};

out = out.join(Char.nl);


)

" asd".stripWhiteSpace

