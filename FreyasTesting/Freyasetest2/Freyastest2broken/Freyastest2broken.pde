import oscP5.*;
import netP5.*;
import java.util.Random;
OscP5 oscP5;
NetAddress myBroadcastLocation;
OscMessage attack;
OscMessage roll;
import processing.awt.PGraphicsJava2D;

Player p1;
Spawning spawn;
UI user;
public levelManager management;

float x,y;
public float scale;
boolean[] keyspressed = new boolean[5];
long ptime;
public long tick;
ArrayList<Enemy> enemylist;

PImage testimage;
PImage player;
PImage asymbol;
Random rand = new Random();

Camera cam;
PMatrix2D camMat = new PMatrix2D();

void setup(){

 ellipseMode(RADIUS);
 size(1500,1000,P2D);
 x = width/2;
 y = height/2;
 scale = .05;
 cam = new Camera(x,y);
 ptime = millis();
 tick = 0;
 player = loadImage("atsymbol.png");
 player.resize(1000,1000);
 asymbol = loadImage("asymbol.png");
 asymbol.resize(1000,1000);
 p1 = new Player(0,0,player);
 management = new levelManager();
 enemylist = new ArrayList<Enemy>();
 spawn = new Spawning();
 user = new UI(p1);
// spawn.firstspawn(enemylist);
//
 frameRate(50);
 
  oscP5 = new OscP5(this, 6500);
  myBroadcastLocation = new NetAddress("127.0.0.1", 6449);
  attack = new OscMessage("/foo/notes");
  attack.add(1);
  roll = new OscMessage("/foo/notes");
  roll.add(2);
  loop();
}

void setticks(){
 tick +=floor((millis() - ptime)/10);
 ptime = millis();
}

void restart(){
  loop();
  tick = 0;
  management = new levelManager();
  p1 = new Player(0,0,player);
  enemylist = new ArrayList<Enemy>();
  spawn = new Spawning();
  user = new UI(p1);
  cam = new Camera(x,y);
  ptime = millis();
}

void draw(){
  if(!user.paused && !user.dead){
  setticks();
  background(42);
  cam.move(p1.x,p1.y);
  camera(camMat, cam.x,cam.y,scale,scale);
  for(int i=enemylist.size()-1;i>=0;i--){
     Enemy en = enemylist.get(i);
     en.updateVector(p1);
     en.chase();
     en.collideTest(p1);
     if(en.shouldRemove){
       enemylist.remove(en);
     }
     else{
       en.render();
     }
  } 
  
  p1.updatecds();
  p1.move(keyspressed);
  p1.render();
  user.update(p1);
  user.healthbar(cam);
  user.cooldowns(cam);
  user.score(cam);
  spawn.randspawn(p1,enemylist);
//  println("%i",frameRate);
  management.checknext();
  
  }
  if(user.dead){
     background(42);
     camera(camMat, cam.x,cam.y,scale,scale);
     user.deathscreen(cam); 
   }
  if(user.paused){
     camera(camMat, cam.x,cam.y,scale,scale);
     user.pausescreen(cam);
  }
}


void mousePressed(){
  if(mouseButton == LEFT && !p1.bAoncd && !p1.rolling && !p1.attacking && (tick - p1.aTick > p1.bAcd)){
     println("click registered");   
     oscP5.send(attack, myBroadcastLocation);
     float mpx = ((mouseX-(width/2))/scale)+p1.x;
     float mpy = ((mouseY-(height/2))/scale)+p1.y;
     p1.basicAttack(mpx,mpy);
  } 
  
}


void keyPressed(){
  if(key == 'w'){
    keyspressed[0] = true;
  }
  if(key == 'a'){
    keyspressed[1] = true;
  }  
  if(key == 's'){
    keyspressed[2] = true;
  }
  if(key == 'd'){
    keyspressed[3] = true;
  }
  if(key == 'r'){
    if(user.dead||user.paused){
      restart();
    }
  }
  if(keyCode ==TAB){
    keyspressed[4] = true;  
  }
  if(keyCode == ESC){
    key = 0;
    if(user.dead){
      exit(); 
    }
    user.paused = !user.paused;
    if(!user.paused){
       loop();
    }
  }
  if(key == ' '){
    p1.roll(keyspressed); 
  }
}

void keyReleased(){
  if(key == 'w'){
    keyspressed[0] = false;
  }
  if(key == 'a'){
    keyspressed[1] = false;
  }
  if(key == 's'){
    keyspressed[2] = false;
  }
  if(key == 'd'){
    keyspressed[3] = false;
  }
   if(keyCode ==TAB){
    OscMessage lowpass = new OscMessage("/foo/notes");
    lowpass.add(2);
    println("we have sent a signal! %s");
    oscP5.send(lowpass, myBroadcastLocation);     
    keyspressed[4] = false;
  }
}

void oscEvent(OscMessage themessage){
  themessage.print();
  
}


PVector translation(PMatrix2D m, PVector out){
  return out.set(m.m02,m.m12,0.0);
}

PVector scaling(PMatrix2D m, PVector out){
 float magx = sqrt(m.m00 * m.m00 + m.m10 * m.m10);
 float magy = sqrt(m.m01 * m.m01 + m.m11 * m.m11);
 if(m.determinant()<0.0){
   magy = -magy;
 }
 return out.set(magx,magy);  
}

PMatrix2D decompose(PMatrix2D m, PVector pos,PVector eul, PVector scl){
 translation(m,pos); 
 scaling(m,scl);
 eul.set(0.0,0.0,atan2(-m.m01,m.m00));
 return m;
}

PMatrix2D camera(PMatrix2D cameraMatrix, float tx, float ty, float zoomW, float zoomH){
  cameraMatrix.set(1.0,0.0,width*0.5,0.0,1.0,height* 0.5);
  cameraMatrix.scale(zoomW,zoomH);
  cameraMatrix.translate(-tx,-ty);
  setMatrix(cameraMatrix);
  return cameraMatrix;
}
