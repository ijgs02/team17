int x,y;
boolean[] keys = new boolean[128];
int[][] terrain = new int[1000][1500];

 //This is a decent proof of concept - if we were to do this we would create a tool that can draw terrain,
 //And save one background draw file, and one array of valid positions. This current method is slow to do and
 //inneficient to draw.




void setup() {
  size(1500, 1000);
  x = width/2;
  y = height/2;
  init_terrain();
}

void init_terrain(){
  for(int i=0; i<height;i++){
    terrain[i][100] = 5;
  }
  for(int i=0; i<width;i++){
    terrain[0][i] = 5;
  }
  
  for(int i=0; i<height;i++){
    terrain[i][0] = 5;
  }
  
  for(int i=0; i<height;i++){
    terrain[i][width-10] = 5;
  }

  for(int i=0; i<width;i++){
    terrain[height-10][i] = 5;
  }

}

void keyPressed(){
  keys[keyCode] = true;
}

void keyReleased(){
  keys[keyCode] = false;
}
      
void draw() {
  drawTerrain();
  drawkey();
  handlekeypress();
}

void drawTerrain(){
  background(0);
  for(int i=1;i<1490;i++){
    for(int j=1;j<990;j++){
      if(terrain[j][i]>0){
        rect(i,j,5,5,255);
      }
    }
  } 
}

void drawkey(){
  int size = 10;
  triangle(x+size,y,x-size,y-size,x-size,y+size);
}

void handlekeypress(){
  int speed = 10;
  if(keys['W']||keys['w']){
    if(moveValY(-speed)){
      y-=speed;
    }
  }
  if(keys['A']||keys['a']){
    if(moveValX(-speed)){
      x-=speed;
    }
  }
  if(keys['S']||keys['s']){
    if(moveValY(speed)){
      y+=speed;
    }
  }
  if(keys['D']||keys['d']){
    if(moveValX(speed)){
      x+=speed;
    }
  }
}

boolean moveValY(int b){
  if(b<0){
    for(int i=0; i>b;i--){
      if(terrain[y+b][x]>0){
        return false;
      }
    }
  }
  if(b>0){
    for(int i=0; i<b;i++){
      if(terrain[y+b][x]>0){
        return false;
      }
    }
  }
  return true;
}

boolean moveValX(int b){
  if(b<0){
    for(int i=0; i>b;i--){
      if(terrain[y][x+b]>0){
        return false;
      }
    }
  }
  if(b>0){
    for(int i=0; i<b;i++){
      if(terrain[y][x+b]>0){
        return false;
      }
    }
  }
  return true;
}
