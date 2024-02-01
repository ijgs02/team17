class UI{
  int health;
  int score;
  long aTick;
  long rollstart;
  int Rcd;
  int bAcd;

  
  
  
  UI(Player p1){
    health = p1.health;
    score = p1.points;
    bAcd = p1.bAcd;
    Rcd = p1.Rcd;
  }
    
  void update(Player p1){
    health = p1.health;
    score = p1.points;
    rollstart = p1.rollstart;
    aTick = p1.aTick;
  }
  
  void healthbar(Camera cam){
    for(int i=0;i<health;i++){
       fill(0,255,255);
       ellipse(cam.x - 7200,cam.y-4700 + i*750,250,250);
    }
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
