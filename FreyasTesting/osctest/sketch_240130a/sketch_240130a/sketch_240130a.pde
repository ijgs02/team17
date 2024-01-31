import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myBroadcastLocation;

void setup(){
  oscP5 = new OscP5(this, 6500);
  myBroadcastLocation = new NetAddress("127.0.0.1", 6449);
}

void draw(){
 if (mousePressed && mouseButton==LEFT){
    OscMessage lowpass = new OscMessage("/foo/notes");
    lowpass.add(1);
    oscP5.send(lowpass, myBroadcastLocation);
    println("we have sent a signal!");
 }
 if (mousePressed && mouseButton==RIGHT){

    OscMessage lowpass = new OscMessage("/foo/notes");
    lowpass.add(2);
    println("we have sent a signal! %s");
    oscP5.send(lowpass, myBroadcastLocation);
 } 
}
