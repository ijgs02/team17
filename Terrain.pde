class Terrain{
  public int x;
  public int y;
  int w;
  int h;
  
  
  
  Terrain(int startingX, int startingY){
    x = startingX;
    y = startingY;
    w = 10;
    h = 10;
  }
  
  public void render(){
    //println("Rendering terrain at " + x + ", " + y);
    rect(x,y,w,h);
  }  
}
