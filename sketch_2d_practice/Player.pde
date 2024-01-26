class Player{
  int x; 
  int y;
  int size;
  int speed;
  
  int rolllength; 
  int cooldown;
  long rollstart;
  boolean rolling;
  boolean rw;
  boolean ra;
  boolean rs;
  boolean rd;
  
  boolean canmoveU;
  boolean canmoveL;
  boolean canmoveD;
  boolean canmoveR;
  
  Player(int startingX, int startingY){
    x = startingX;
    y = startingY;
    size = 20;
    speed = 1;
    rolllength = 20;
    cooldown = 100;
    canmoveU = true;
    canmoveL = true;
    canmoveD = true;
    canmoveR = true;
    
  }
  
 d
  
  void move(boolean[] keyspressed){
    if(keyspressed[0]&&canmoveU){
      y-=speed;
    }
    if(keyspressed[1]&&canmoveL){
      x-=speed;
    }
    if(keyspressed[2]&&canmoveD){
      y+=speed;
    }
    if(keyspressed[3]&&canmoveR){
      x+=speed;
    }
    if(rolling){
    if(rw&&canmoveU){
      y-=speed;
    }
    if(ra&&canmoveL){
      x-=speed;
    }
    if(rs&&canmoveD){
      y+=speed;
    }
    if(rd&&canmoveR){
      x+=speed;
    }
      if(tick - rollstart >=rolllength){
        rolling = false;
        speed = 1;
        return;
      }
    }
  }  
  
  void roll(boolean[] keyspressed){
    if(tick-cooldown >rollstart){
      rollstart = tick;
      speed = 12;
      rolling = true;
      rw = keyspressed[0];
      ra = keyspressed[1];
      rs = keyspressed[2];
      rd = keyspressed[3];
    }
  }
  
  void checkcollision(Terrain t1){
    canmoveU = true;
    canmoveL = true;
    canmoveD = true;
    canmoveR = true;
    boolean ain = x>=t1.x && x<=t1.x+t1.w && y>=t1.y && y<=t1.y+t1.h;
    boolean bin = x+size>=t1.x && x+size<=t1.x+t1.w && y>t1.y && y<=t1.y+t1.h;
    boolean cin = x>=t1.x && x<=t1.x+t1.w && y+size>=t1.y && y+size<=t1.y+t1.h;
    boolean din = x+size>=t1.x && x+size<=t1.x+t1.w && y+size>=t1.y && y+size<=t1.y+t1.h;
    if(!(ain||bin||cin||din)){
      return;
    }
    if(ain&&bin){
      canmoveU = false;
      y = t1.y + t1.h;
      return;
    }
    if(ain&&cin){
      canmoveL = false;
      x = t1.x + t1.w;
      return;
    }
    if(bin&&din){
      canmoveR = false;
      x = t1.x -size;
      return;
    }
    if(cin&&din){
      canmoveD = false;
      y = t1.y-size;
      return;
    }
    if(ain){
      if(x-t1.x+t1.h>y-t1.y+t1.w){
        canmoveL = false;
        x = t1.x + t1.w;    
      return;
      }
      else{
        canmoveU = false;
        y = t1.y + t1.h;
        return;
      }
    }
    if(bin){
      if(x+size-t1.x>t1.y+t1.h-y){
        canmoveU = false;
        y = t1.y + t1.h;    
        return;
      }
      else{
        canmoveR = false;
        x  = t1.x - size;
        return;
      }
    }
    if(cin){
      if(t1.x+t1.w-x<y-t1.y+size){
        canmoveL = false;
        x = t1.x + t1.w;    
        return;
      }
      else{
        canmoveD = false;
        y = t1.y-size;
        return;
      }
    }
    if(din){
      if(x-t1.x+size>y-t1.y+size){
        canmoveD = false;
        y = t1.y - size;    
        return;
      }
      else{
        canmoveR = false;
        x = t1.x-size;
        return;
      }
    }
  }
}
