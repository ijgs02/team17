class Terrain{
  int x;
  int y;
  int w;
  int h;
  
  Terrain(int startingX, int startingY){
    x = startingX;
    y = startingY;
    w = 50;
    h = 100;
  }
  
  void render(){
    rect(x,y,w,h);
  }  
}
