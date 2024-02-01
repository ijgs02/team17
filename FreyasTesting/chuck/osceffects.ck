OscIn oin;
6449 => oin.port;
OscMsg msg;
oin.addAddress( "/foo/notes" );



fun int scale(int a, int sc[]) {
  sc.cap() => int n; //number of degrees in scale
  a/n => int o; //octave being requested, number of wraps
  a%n => a; //wrap the note within first octave

  if ( a<0 ) { //cover the negative border case
    a + 12 => a;
    o - 1 => o;
  }
  //each octave contributes 12 semitones, plus the scale
  return o*12 + sc[a];
}

[0,0,6,0,6,7,0,6,0,4,0,5,5,4,3,4] @=> int mel[]; //sequence data
[0,2,3,5,7,8,10,12] @=> int minor[]; //minor scale
            
spork ~beat();

fun void beat(){
   SawOsc i => Gain g1 => LPF lf => ADSR en => dac;
   1.2 => g1.gain;
   en.set(10::ms, 50::ms,0.3, 500::ms);
   lf.set(150,0.8);
   110 => i.freq;
   while(true){
     en.keyOn();
     100:: ms => now;
     en.keyOff();
     500::ms =>now;
   }   
}

fun void riff(){
   150::ms => dur T;
 //  T - (now % T) => now;
   StifKarp inst=>SinOsc overdrive=>LPF l =>Gain g=> ADSR e => dac;
   1 => overdrive.sync;
   1.5 => g.gain;
   e.set( 10::ms, 8::ms, .5, 500::ms );
   e.keyOn();
   for (0=>int i;i<2 ; i++) {
     Std.mtof(  3*12 + 9 + scale( mel[Math.random2(0,15)], minor )) => inst.freq; //set the note
     inst.noteOn( 1 ); //play a note at half volume
     T => now; //compute audio for 0.3 sec
  }
  e.keyOff();
  3::second => now;

}

while(true){
    float i;

    oin => now;
    
    oin.recv(msg);
    msg.getInt(0) => i;

    if(i == 1){        
        spork ~ riff();
    }
    if(i == 2){   
    }
}


