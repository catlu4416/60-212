void setup() {
  size(640, 480);
}

///////////////////////////////////////////////////////////////////////////////////////////////////


void mouseClicked() {
  
  //variables
  float[][] lineArray = new float[12][4];
  float[][] dotCoordArray = new float[12][6];
  int numLines = 12;
  float x1;
  float y1;
  float x2;
  float y2;
  
  //resets background
  background(158,221,217);

  
 float rw = 640;
 float rh = 480;
  
  //creates coordinate array
  for (int lineCount = 0; lineCount<numLines; lineCount++) {
    lineArray[lineCount][0] = random(640);
    lineArray[lineCount][1] = random(480);
    lineArray[lineCount][2] = random(640);
    lineArray[lineCount][3] = random(480);
  }
  
  //draws lines from lineArray  
  for (int lineCount2 = 0; lineCount2<numLines; lineCount2++) {
    x1 = lineArray[lineCount2][0];
    y1 = lineArray[lineCount2][1];
    x2 = lineArray[lineCount2][2];
    y2 = lineArray[lineCount2][3];

    line(x1,y1,x2,y2);
    
    //stores line equations and points in array
    float slope = ((y2 -y1)/(x2-x1));
    float yIntercept = y1-(slope*x1);
    dotCoordArray[lineCount2][0] = slope;
    dotCoordArray[lineCount2][1] = yIntercept;
    dotCoordArray[lineCount2][2] = x1;
    dotCoordArray[lineCount2][3] = y1;
    dotCoordArray[lineCount2][4] = x2;
    dotCoordArray[lineCount2][5] = y2;
  } 

  //uses algebra to get intersection coordinates
  for (int lineCount3 = 0; lineCount3<numLines; lineCount3++) {
    for (int lineCount4 = 1; lineCount4<numLines; lineCount4++) {
      float combinedX = dotCoordArray[lineCount3][0] - dotCoordArray[lineCount4][0];
      float combinedY = dotCoordArray[lineCount4][1] - dotCoordArray[lineCount3][1];
      float intersectX = (combinedY/combinedX);
      float intersectY = ((dotCoordArray[lineCount4][0])*intersectX)+(dotCoordArray[lineCount4][1]);
      
      //sets bounding box coordinates from coordinates stored in array
      float boundX1 = dotCoordArray[lineCount3][2];
      float boundY1 = dotCoordArray[lineCount3][3];
      float boundX2 = dotCoordArray[lineCount3][4];
      float boundY2 = dotCoordArray[lineCount3][5];
      
      float boundX3 = dotCoordArray[lineCount4][2];
      float boundY3 = dotCoordArray[lineCount4][3];
      float boundX4 = dotCoordArray[lineCount4][4];
      float boundY4 = dotCoordArray[lineCount4][5];
       
      //sets bounding box   
      if ((((boundX1<=intersectX && boundX2>=intersectX) || (boundX1>=intersectX && boundX2<=intersectX)) &&
           ((boundY1<=intersectY && boundY2>=intersectY) || (boundY1>=intersectY && boundY2<=intersectY))) &&
          
          (((boundX3<=intersectX && boundX4>=intersectX) || (boundX3>=intersectX && boundX4<=intersectX)) &&
           ((boundY3<=intersectY && boundY4>=intersectY) || (boundY3>=intersectY && boundY4<=intersectY)))) {
             //if coordinates within both bounding boxes, circle is drawn, Catherine is happy
             fill(255,255,153);
             ellipse(intersectX,intersectY,5,5);
          }
    }
  }
}   

void draw() {
} 