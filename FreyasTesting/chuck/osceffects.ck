OscIn oin;
6449 => oin.port;
OscMsg msg;
oin.addAddress( "/foo/notes" );
OscOut xmit;
xmit.dest("processing",6500);
xmit.start("/foo/notes");
3 => xmit.add;


global Gain gall => dac;
0.5 => gall.gain;
Event attack;

[220.0,249.94,277.18,293.66,329.63,369.99,415.3,440.0] @=> float notes[];
            
spork ~beat();
spork ~riff(attack);

fun void beat(){
   SawOsc i => Gain g1 => LPF lf => ADSR en => global Gain gall;
   1.2 => g1.gain;
   en.set(10::ms, 50::ms,0.3, 500::ms);
   lf.set(150,0.8);
   110 => i.freq;
   while(true){
     en.keyOn();
 //    xmit.send();
     100:: ms => now;
     en.keyOff();
     500::ms =>now;
     xmit.dest("processing",6500);
     xmit.start("/foo/notes");
     3 => xmit.add;

   }   
}

fun void riff(Event attack){
  while(true){
   150::ms => dur T;
 //  T - (now % T) => now;
   TriOsc source =>SinOsc overdrive=>Gain g=>LPF l => ADSR e => dac;
   1 => overdrive.sync;
   1 => overdrive.gain;
   2 => g.gain;
   150 => l.freq;
   e.set( 1::ms, 8::ms, .5, 500::ms );
   attack => now;
   for (0=>int i;i<2 ; i++) {
      e.keyOn();
      notes[Math.random2(0,7)] => source.freq;    
      T => now; //compute audio for 0.3 sec
  }
  e.keyOff();

 }
}

while(true){
    float i;

    oin => now;
    
    oin.recv(msg);
    msg.getInt(0) => i;

    if(i == 1){        
        attack.signal();
    }
    if(i == 2){   
    }
}


