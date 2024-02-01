class Spawning{
  long pspawn;
  int spawncd;
  
  
  
  Spawning(){ 
    pspawn = 0;
    spawncd = 500;
  }
  
  
  void randspawn(Player p1, ArrayList<Enemy> enemylist){

    if(tick-pspawn > spawncd){
       int r =abs(rand.nextInt())%4;
       println(r);
       int x = 0;
       int y = 0;
       switch(r){
         case 0:
           x = rand.nextInt()%15000;
           y = -8000;
           break;
         case 1:
           x = -10000;
           y = rand.nextInt()%10000;
           break;
         case 2:
           x =rand.nextInt()%15000;
           y = 8000;
           break;
         case 3:
           x = 10000;
           y = rand.nextInt()%10000;
           break;
       }
       println(x,y);
       enemylist.add(new Enemy((int)(p1.x+x),(int)(p1.y+y),p1));
       println(" A new Challenger approaches");
       pspawn = tick;
    }
  }
  
  void addenemy(ArrayList<Enemy> enemylist, int x, int y){
     enemylist.add(new Enemy(x,y,p1));
  }
  
  void firstspawn(ArrayList<Enemy> enemylist){
    int dist = 2500;
    for(int i=0; i< 9; i++){
      enemylist.add(new Enemy(0,dist*i,p1));
    }
    for(int i=0; i< 9; i++){
      enemylist.add(new Enemy(dist*i,0,p1));
    }
    for(int i=0; i< 9; i++){
      enemylist.add(new Enemy(dist*i,dist*10,p1));
    }  
    for(int i=0; i< 9; i++){
      enemylist.add(new Enemy(dist*10,dist*i,p1));
    }  
  }
 
 
}
