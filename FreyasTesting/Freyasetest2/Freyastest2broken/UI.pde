class UI{
  int health;
  int score;
  long aTick;
  long rollstart;
  int Rcd;
  int bAcd;

  boolean paused;
  boolean dead;
  
  UI(Player p1){
    health = p1.health;
    score = p1.points;
    bAcd = p1.bAcd;
    Rcd = p1.Rcd;
    paused = false;
    dead = false;
  }
    
  void update(Player p1){
    health = p1.health;
    score = p1.points;
    rollstart = p1.rollstart;
    aTick = p1.aTick;
    if(health <= 0){
      dead = true;
    }
  }
  
  void healthbar(Camera cam){
    for(int i=0;i<health;i++){
       fill(0,255,255);
       ellipse(cam.x - 7200,cam.y-4700 + i*750,250,250);
    }
  } 
  
  void score(Camera cam){
    textAlign(CENTER);
    textSize(1000);
    text( score,cam.x,cam.y+4700);
  }
  
  void deathscreen(Camera cam){
    text("You're Dead", cam.x,cam.y);
  }
  
  void pausescreen(Camera cam){  
    text("Paused", cam.x,cam.y);
    textSize(200);
    text("press r to restart", cam.x, cam.y+500);
    textSize(1000);
    noLoop();
  }
  
  void cooldowns(Camera cam){
    float aBright = ((float)(tick - aTick))/(float)bAcd;
    if(aBright>1){
      aBright = 1;
    }
    fill((int)((float)255*aBright),0,0);
    rect(cam.x + 7200,cam.y-4700,250,250);
    
    float rBright = ((float)(tick - rollstart))/(float)Rcd;
    if(rBright>1){
      rBright = 1;
    }
    fill(0,0,(int)((float)255*rBright));
    rect(cam.x + 7200,cam.y-4700 + 750,250,250);
      
  }
}
