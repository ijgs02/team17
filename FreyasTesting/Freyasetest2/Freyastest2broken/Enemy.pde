class Enemy{
  int x;
  int y;
  int r;
  int speed;
  long ptick;
  boolean shouldRemove;
  //movement path
  float delx;
  float dely;
  float dist;
  
  Enemy(int startingX, int startingY,Player p1){
   x = startingX;
   y = startingY;  
   r = 500;
   speed = 50;
   ptick=0;
   shouldRemove = false;
   updateVector(p1);
  }
  
  void updateVector(Player p1){
     delx = x-p1.x;
     dely = y-p1.y;
     dist = sqrt(delx*delx + dely*dely);
  }
      
  void render(){
//    ellipse(x,y,r,r);
    image(asymbol,x-500,y-500);
  }
  
  void chase(){
    x -= (delx/dist) * speed;
    y -= (dely/dist) * speed;
  }
  
  
//Still only works for if the player is smaller than the object, we need to make another one for if the object is smaller. 
  void collideTest(Player p1){

    if(dist < (r + p1.r)){
      //Collision detected
      p1.xmom -= delx * 1/dist * 100 ;
      p1.ymom -= dely * 1/dist * 100 ;
      if(p1.rolling || p1.attacking){
         shouldRemove = true;
         p1.kill(1);
         return;
      }
      if(p1.vuln){
        p1.damaged(1);
      }
    }
  }
}
