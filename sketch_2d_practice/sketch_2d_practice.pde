import processing.awt.PGraphicsJava2D;

Player p1;
int x,y;
boolean[] keyspressed = new boolean[5];
long stime;
public long tick;
ArrayList<Terrain> terrainlist;
PImage testimage;
PImage player;
Camera cam;
PMatrix2D camMat = new PMatrix2D();

void setup(){
 size(1500,1000,P2D);
 x = width/2;
 y = height/2;
 cam = new Camera(x,y);
 stime = millis();
 tick = 0;
 testimage = loadImage("background1.png");
 player = loadImage("player1.png");
 p1 = new Player(x,y,player);
 frameRate(50);
}

void setticks(){
 tick =floor((millis() - stime)/10);
}

void draw(){
  setticks();
  background(42);
//  p1.checkcollision(t1);
//  for(Terrain tn : terrainlist){
//     p1.checkcollision(tn);
//  } 
//  for(Terrain tn : terrainlist){
//      tn.render();
//  }
  p1.move(keyspressed);
  cam.move(p1.x,p1.y);
  camera(camMat, cam.x,cam.y,10,10);
  image(testimage,0.0,0.0);
  p1.render();
  println("%i",frameRate);
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
