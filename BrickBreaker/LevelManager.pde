class LevelManager {
  
  String[] levelMapping = new String[]{"easy", "medium", "hard"};
  color[] colorMapping = new color[]{color(255, 0, 0), color(255, 255, 0)};
  
  int screenWidth;
  int screenHeight;
  
  public LevelManager(int screenWidth, int screenHeight) {
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
  }

  Brick[] loadLevel(int level) {
    Brick[] bricks;
    String path = sketchPath("levels\\" + levelMapping[level - 1]);
    System.out.println(path);
    //Manual selection, redo with random number later
    String[] fileNames = listFileNames(path);
    System.out.println(Arrays.toString(fileNames));
    //int rand = int(random(fileNames.length));
    int rand = 0;
    String[] levelInfo = loadStrings(path + "\\" + fileNames[rand]); 
    System.out.println(Arrays.toString(levelInfo));
    
    int columns = Integer.parseInt(levelInfo[0]);
    int colWidth = screenWidth / columns;
    System.out.println("Column Width " + colWidth);
    bricks = new Brick[Integer.parseInt(levelInfo[1])];
    int brickCounter = 0;
    int rowHeight = 20;
    int sizeMetadata = 2;
    System.out.println();
    
    for (int i = 0; i < levelInfo.length - sizeMetadata; i++) {
      String row = levelInfo[i + sizeMetadata];
      System.out.println("On row " + row);
      int brickStart = 0;
      char prev = '0';
      char cur = '0';
      for (int col = 0; col < row.length(); col++) {
        prev = cur;
        cur = row.charAt(col);
        System.out.println("On char " + int(cur));
        if (int(cur) >=49 && int(cur) <= 57) { //cur is 1-9
          if (prev != cur) {
            brickStart = col;
          }
        } else if (cur == '/') {
          //End brick
          System.out.println("prev " + prev + " width " + (col - brickStart + 1) + " col " + col + " brickstart " + brickStart);
          bricks[brickCounter] = new Brick(new Vector(col * colWidth, i * rowHeight),
                                           colWidth * (col - brickStart + 1),
                                           rowHeight,
                                           colorMapping[Character.getNumericValue(prev) - 1],
                                           Character.getNumericValue(prev));
          prev = '0';
          brickCounter++;
          System.out.println("Created brick at " + (col*colWidth) + " " + (i*rowHeight));
        } 
      }
    }
    
    return bricks;
  }
  
  // This function returns all the files in a directory as an array of Strings  
  String[] listFileNames(String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      String names[] = file.list();
      return names;
    } else {
      // If it's not a directory
      return null;
    }
  }

}