class Player{
  int health;
  int points;
  float x;
  float y;
  float r;
  float control = 10;
  float xmom;
  float ymom;

  long ptick;
  
  boolean vuln;
  long dTick;
  int grace;
  
  float rollboost;
  int rolllength; 
  int Rcd;
  long rollstart;
  boolean rolling;
  boolean rw;
  boolean ra;
  boolean rs;
  boolean rd;

  boolean bAoncd;
  boolean attacking;
  int bAcd;
  long aTick;
  int bAlen;

  PImage player;
  
  Player(float startingX, float startingY,PImage inplayer){
    x = startingX;
    y = startingY;
    xmom = 0.0;
    ymom = 0.0;
    r = 500.0;
    points = 0; 
    grace = 100;
    vuln = true;
    bAoncd = false;
    attacking = false;
    ptick=0;
    aTick = 0;
    bAcd = 75;
    bAlen = 20;
    rollboost =30;
    rolllength = 50;
    Rcd = 100;
    player = inplayer;
    health = 3;
  }
  
  void render(){
    if(attacking){
      fill(255,0,0);
    }
    if(rolling){
      fill(0,255,255);
    }
//    ellipse(x,y,r,r);
    fill(255);

    image(player,x-500,y-500);
  }
  
  void move(boolean[] keyspressed){
    //i think we might need vector/momementum based movement 
    //momemtum mode???

    x +=xmom;
    y +=ymom;
    if(!rolling){
      if(keyspressed[0]){
        ymom -= control;
      }
      if(keyspressed[1]){
        xmom -= control;
      }
      if(keyspressed[2]){
        ymom += control;
      }
      if(keyspressed[3]){
        xmom += control;
      }
    }
    else{
      if(rw){
        ymom -= rollboost;
      }
      if(ra){
        xmom -= rollboost;
      }
      if(rs){
        ymom += rollboost;
      }
      if(rd){
        xmom += rollboost;
      }
     if(tick - rollstart >=rolllength){
        rolling = false;
      }
    }
    xmom = 0.9*xmom;
    ymom = 0.9*ymom;
    if(xmom<0.1 && xmom>-0.1){
      xmom = 0;
    }
    if(ymom<0.1 && ymom>-0.1){
      ymom = 0;
    }
   }
    
  void updatecds(){
     if(attacking){
       if(tick-aTick > bAlen){
         attacking = false;
       }
     }
     if(!vuln){
       if(tick-dTick > grace){
         vuln = true;
       }
     }
     
  }
  
  void damaged(int dam){
    health-=dam;
    vuln = false;
    dTick = tick;
    println("you took damage! health remaining: ",health); 
       
  }
  
  void kill(int point){
    points += point;
    println("Nice job! Current points:",points);
  }
    
  
  void roll(boolean[] keyspressed){
    if(tick-Rcd >rollstart){
      rollstart = tick;
      rolling = true;
      rw = keyspressed[0];
      ra = keyspressed[1];
      rs = keyspressed[2];
      rd = keyspressed[3];
//      xmom = 5*xmom;
//      ymom = 5*ymom;
    }
  }
  
  void basicAttack(float mpx, float mpy){
      xmom = (mpx-x)/10;
      ymom = (mpy-y)/10;
      aTick = tick;
      attacking = true;
  }
  

}
