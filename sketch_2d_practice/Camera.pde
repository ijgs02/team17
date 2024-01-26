class Camera{
  float x;
  float y;
  int speed;
  
  Camera(int startingx, int startingy){
    x = (float)startingx;
    y = (float)startingy;
  }
  
  void move(int px, int py){
    float delx = x-(float)px;
    float dely = y-(float)py;
/*
    if(delx<3 && delx>-3){
      x = (float)px;
      y = (float)py;
      return;
    }
     if(dely<3 && dely>-3){
      x = (float)px;
      y = (float)py;
      return;
    }
*/
    x-=delx/10;
    y-=dely/10;
  }
}
