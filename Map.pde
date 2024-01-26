class Map {
  
  public int mapPixelData[] = new int[420];
  
  public PImage openFile(String inputFilepath) {
    PImage mapImage = loadImage(inputFilepath);
    return mapImage;
  }
  
  public void getMapData(PImage inputImage) {
    int mapWidth = inputImage.width;
    int mapHeight = inputImage.height;
    int i = 0;
    for (int y = 0; y < mapHeight; y++) {
       for (int x = 0; x < mapWidth; x++) {
         mapPixelData[i] = inputImage.pixels[y*mapWidth+x];
         i++;
       }
    }
  }
  
  public void generateTerrain() {
    for (int i = 0; i < mapPixelData.length; i++) {
      println((mapPixelData[i]));
    }
    
  }
  
  public void initMap(String inputFilePath) {
    for (int i = 0; i < mapPixelData.length; i++) {
      mapPixelData[i] = 0;
    }
    
     PImage mapImage = openFile(inputFilePath); 
     getMapData(mapImage);
     generateTerrain();
  }
  
  
  
}
