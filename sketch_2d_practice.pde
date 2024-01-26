import processing.awt.PGraphicsJava2D;

int x,y;
Player p1;
Terrain t1;
Terrain[] mapTerrain = new Terrain[420];
Camera cam;
Map map;
boolean[] keyspressed = new boolean[5];
long stime;
public long tick;

PMatrix2D camMat = new PMatrix2D();

void setup(){
 size(1500,1000);
 
 x = width/2;
 y = height/2;
 p1 = new Player(x,y);
 cam = new Camera(x,y);
 t1 = new Terrain(100,100);
 map = new Map();
 map.initMap("test.png");
 mapToTerrain();
 stime = millis();
 tick = 0;
 frameRate(50);
}


void mapToTerrain() {
 for (int i = 0; i < map.mapPixelData.length; i++) {
   mapTerrain[i] = new Terrain(0, 0); 
   if (map.mapPixelData[i] != -1) {
       mapTerrain[i].x = (i % 20) * 10;
       mapTerrain[i].y = (i / 20) * 10;
       mapTerrain[i].render();
    }
 }
}

void setticks(){
 tick =floor((millis() - stime)/10);
 //println("%i",tick);
}

void draw(){
  setticks();
  background(42);
  for (int i = 0; i < mapTerrain.length; i++) {
    p1.checkcollision(mapTerrain[i]);
  }
  p1.move(keyspressed);
  cam.move(p1.x,p1.y);
  camera(camMat, cam.x,cam.y,1.0,1.0);
  p1.render();
  for (int i = 0; i < mapTerrain.length; i++) {
     mapTerrain[i].render(); 
  }
  t1.render();
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

void render() {
  
}

PMatrix2D camera(PMatrix2D cameraMatrix, float tx, float ty, float zoomW, float zoomH){
  cameraMatrix.set(1.0,0.0,width*0.5,0.0,1.0,height* 0.5);
  cameraMatrix.scale(zoomW,zoomH);
  cameraMatrix.translate(-tx,-ty);
  setMatrix(cameraMatrix);
  return cameraMatrix;
}
