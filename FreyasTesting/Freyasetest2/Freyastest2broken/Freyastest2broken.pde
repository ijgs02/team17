import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myBroadcastLocation;

import processing.awt.PGraphicsJava2D;

Player p1;
float x,y;
float scale;
boolean[] keyspressed = new boolean[5];
long ptime;
public long tick;
ArrayList<Enemy> enemylist;

PImage testimage;
PImage player;
PImage overlay;

Camera cam;
PMatrix2D camMat = new PMatrix2D();

void setup(){
  ellipseMode(RADIUS);
//  ellipseMode(CENTER);
 size(1500,1000,P2D);
 x = width/2;
 y = height/2;
 scale = .1;
 cam = new Camera(x,y);
 ptime = millis();
 tick = 0;
 testimage = loadImage("background2.jpg");
 testimage.resize(19200,19200);
 player = loadImage("at1.png");
// player.resize(45,45);
 overlay = loadImage("darkness.png");
 overlay.resize(7500,5000);
 p1 = new Player(5000,5000,player);
 enemylist = new ArrayList<Enemy>();
// enemylist.add(new Enemy(0,0,p1));
 spawnenemies();
 frameRate(50);
 
  oscP5 = new OscP5(this, 6500);
  myBroadcastLocation = new NetAddress("127.0.0.1", 6449);
}

void setticks(){
 float mod;
 if(keyspressed[4]){
   mod = 0.5;
 }
 else{
   mod = 1;
 }
 tick +=floor((millis() - ptime)/10) * mod;
 ptime = millis();
}

void spawnenemies(){
  for(int i=0; i< 9; i++){
    enemylist.add(new Enemy(0,5000*i,p1));
  }
  for(int i=0; i< 9; i++){
    enemylist.add(new Enemy(5000*i,0,p1));
  }
  for(int i=0; i< 9; i++){
    enemylist.add(new Enemy(5000*i,50000,p1));
  }  
  for(int i=0; i< 9; i++){
    enemylist.add(new Enemy(50000,5000*i,p1));
  }  
}



void draw(){
  setticks();
  background(42);
  cam.move(p1.x,p1.y);
  camera(camMat, cam.x,cam.y,scale,scale);
  image(testimage,0.0,0.0);
  for(int i=enemylist.size()-1;i>=0;i--){
     Enemy en = enemylist.get(i);
     en.updateVector(p1);
     en.chase();
//     en.move();
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

//  println("%i",frameRate);
}

void mousePressed(){
  if(mouseButton == LEFT && !p1.bAoncd && !p1.rolling && !p1.attacking && (tick - p1.aTick > p1.bAcd)){
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
  if(keyCode ==TAB){
    println("we have sent a signal!");
    OscMessage lowpass = new OscMessage("/foo/notes");
    lowpass.add(1);
    oscP5.send(lowpass, myBroadcastLocation);
    keyspressed[4] = true;  
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
