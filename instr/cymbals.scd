//TODO: Free cymbals when done.
Instr([\cymbals,	\tibetanCymbals2],{
		arg trig=0.0,  freqScale = 1, timeScale = 1, decay=0.001,  freqOffset=300;

		var amps, freqs, freqsDetune, ringTimes;
		var lFreqs, rFreqs, rTimes;

		freqs = #[2913, 2916.1, 2940, 2942, 2973, 2978, 6796, 6832, 6912, 9711, 9776, 9814, 9960, 12090, 12199];
		freqsDetune = #[ 0, -10, 10, 0.1, 0, -10, 10, 0.1, 0, -10, 10, 0.1, 0, -10, 10, 0.1, 0, -10, 10] ;
		ringTimes = #[9, 8.2, 6, 8.6, 10, 14, 2.2, 1.9, 2.5, 0.9, 1.7, 0.75, 0.5, 0.45, 0.4];
		amps =  #[ 1.0, 0, 2, 0.01, 1.0, 0, 2, 0.01, 1.0, 0, 2, 0.01, 1.0, 0, 2];
		lFreqs = 	freqs;
		rFreqs = 	lFreqs + freqsDetune;	// r channel klank gets freqOffsetd.

			Klank.ar(						// extended to two channels:
				[ 	`[ lFreqs , amps, ringTimes] ,
					// left: original resonator
					`[ rFreqs, amps, ringTimes ]
				],		// right: slightly freqOffsetd freqs,
				Decay.ar(Impulsar.ar(trig), decay),
					// attack with an envelope.
				freqScale,
				freqOffset,
				timeScale
			)
},[
	\trig,
	[0.1,4.0],
	[0.1,3.0],
	[0.0001,0.2],
	[-4000,300]

],
	\audio
);



Instr([\cymbals,	\tibetanCymbals3],{
		arg trig=0.0,  freqScale = 1, timeScale = 1, decay=0.001,  freqOffset=300;

		var amps, freqs, freqsDetune, ringTimes;
		var lFreqs, rFreqs, rTimes;

		//random
		freqs = #[ 699.615, 1523.95, 4651.27, 639.54, 566.455, 1040.9, 554.62, 514.324, 4835.18, 2518.03,  830.627, 11601.9, 958.062, 949.916, 2454.64 ];
		freqsDetune = #[ 0, -10, 10, 0.1, 0, -10, 10, 0.1, 0, -10, 10, 0.1, 0, -10, 10, 0.1, 0, -10, 10] ;
		ringTimes = #[9, 8.2, 6, 8.6, 10, 14, 2.2, 1.9, 2.5, 0.9, 1.7, 0.75, 0.5, 0.45, 0.4];
		amps =  #[ 1.0, 0, 2, 0.01, 1.0, 0, 2, 0.01, 1.0, 0, 2, 0.01, 1.0, 0, 2];
		lFreqs = 	freqs;
		rFreqs = 	lFreqs + freqsDetune;	// r channel klank gets freqOffsetd.

			Klank.ar(						// extended to two channels:
				[ 	`[ lFreqs , amps, ringTimes] ,
					// left: original resonator
					`[ rFreqs, amps, ringTimes ]
				],		// right: slightly freqOffsetd freqs,
				Decay.ar(Impulsar.ar(trig), decay),
					// attack with an envelope.
				freqScale,
				freqOffset,
				timeScale
			)
},[
	\trig,
	[0.1,4.0],
	[0.1,3.0],
	[0.0001,0.2],
	[-4000,300]

],
	\audio
);






Instr([\cymbals, \tonal],{
		arg trig=0.0,  freqScale = 1, timeScale = 1,   freqOffset=300,decay=0.001,excite=0.1;

		var env,exc;
		env=Env.perc(0.0,0.05 );

		z =[ `([ [ 1327.36, 1171.43, 1141.97, 1429.71 ], nil, [ 1.21146, 1.9158, 1.42798, 1.9487 ] ]),
			 `([ [ 1569.68, 1565.56, 1219.64, 1310.97 ], nil, [ 1.75512, 1.30389, 1.87559, 1.80242 ] ]) ];

	exc = Enveloper2.ar(WhiteNoise.ar(excite), trig,env);

		Klank.ar(z, exc,
			freqScale,freqOffset,timeScale
			);


},#[
	\trig,
	[0.1,4.0],
	[0.1,3.0],
	[-4000,300],
	[0.0001,0.01]

],
	\audio
);



// does an okay snare brush too
Instr("cymbals.brushcow",{
		arg trig=0.0,  freqScale = 1, timeScale = 1,   freqOffset=300,decay=0.001,excite=0.1;

		var env,exc;
		env=Env.perc(0.0,0.05 );

	exc = Enveloper2.ar(WhiteNoise.ar(excite), trig,env);

		z =`(#[
			[ 180.629, 189.432, 482.667, 502.677, 883.861, 1354.51, 1364.28, 2238.14, 2248.95, 2366.12 ]
			,[ 0.358213, 0.0428016, 0.0129798, 0.0561569, 0.0149706, 0.0101553, 0.0141629, 0.0231704, 0.0314388, 0.0863477 ]
			// supposed to be bandwiths
			,[ 0.20078 ]//, 0.0871534, 0.224972, 1.05556, 0.581926, 0.460071, 0.315656, 1.13698, 1.57918, 2.12936
			]);

		Klank.ar(z,
			exc,
			freqScale,freqOffset,timeScale
			);

},#[
	\trig,
	[0.1,4.0],
	[0.1,3.0],
	[-4000,300],
	[0.0001,0.01]

],
	\audio
);

