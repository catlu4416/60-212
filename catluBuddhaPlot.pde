//Golan's PDF code
// see https://processing.org/reference/libraries/pdf/index.html
import processing.pdf.*;
boolean bRecordingPDF;
int pdfOutputCount = 0;

//global variables
float x;
float y;
float faceX1;
float faceY1;
float faceX2;
float faceY2;
float faceX3;
float faceY3;
float faceX4;
float faceY4;
float faceX5;
float faceY5;
float faceX6;
float faceY6;
float faceX7;
float faceY7;
float faceX8;
float faceY8;

float gridSpaceX = 200;
float gridSpaceY = 200;
float gridTransMidX = 100;
float gridTransMidY = 75;
float t = 50;

void setup() {
  size(700, 1500);
  bRecordingPDF = true;
}

void mouseClicked() {
  beginRecord(PDF, "myName_" + pdfOutputCount + ".pdf");
  strokeWeight(2);
  background(255);
  for (int gridX = 0; gridX<=2; gridX++) {
    for (int gridY = 0; gridY <= 4; gridY++) {
      x = gridSpaceX * gridX + gridTransMidX;
      y = gridSpaceY * gridY + gridTransMidY;

      fill(255);
      //rect(x, y, 100, 100);

      ellipse(x+50, y+40, 140, 140);
      noFill();
      //curve(faceX1, faceY1, faceX2, faceY2, faceX3, faceY3, faceX4, faceY4);
      stroke(0);

      //face random vertex calculation
      faceX1 = x + random(20, 40);
      faceY1 = y + 10;
      faceX2 = x + random(5, 25);
      faceY2 = y + random(30, 45);   
      faceX3 = x + random(20, 35);
      faceY3 = y + random(55, 80);
      faceX4 = x + random(40, 60);
      faceY4 = y + 95;
      faceX5 = x + random(65, 80);
      faceY5 = y + random(55, 80);
      faceX6 = x + random(75, 100);
      faceY6 = y + random(30, 45);
      faceX7 = x + random(60, 80);
      faceY7 = y + 10;
      faceX8 = x + 50;
      faceY8 = y + 2;

      //hair bun
      fill(0);
      float hairX = random(faceX2+30, faceX6-30);
      float hairY = faceY1-30;
      float hairW = random(15, 35);
      float hairH = random(20, 40);

      rect(hairX, hairY, hairW, hairH, 180);
      stroke(255);

      //reset stroke to black after hair tie
      stroke(0);

      //rectangle hair
      fill(0);
      rect(faceX2, faceY1-10, faceX6-faceX2, 30, 180);


      //ears
      fill(255);

      ellipse(faceX2+2, faceY2+5, 15, 40);
      ellipse(faceX6-2, faceY6+5, 15, 40);


      //draw faces
      fill(255);
      beginShape();
      curveVertex(faceX8, faceY8);
      curveVertex(faceX1, faceY1);
      curveVertex(faceX2, faceY2);
      curveVertex(faceX3, faceY3);
      curveVertex(faceX4, faceY4);
      curveVertex(faceX5, faceY5); 
      curveVertex(faceX6, faceY6);
      curveVertex(faceX7, faceY7);
      curveVertex(faceX8, faceY8);
      endShape(CLOSE);


      //2 eyes
      int eyeNum = floor(random(1, 4));
      fill(255);
      float eyeLevel = random(y+30, y+40);
      float eyeSizeW = random(15, 20);
      float eyeSizeH = random(5, 10);
      float eyeballX1 = random(faceX2+10, faceX6-55);
      float eyeballY1 = eyeLevel;
      float eyeballX2 = random(eyeballX1+20, faceX6-10);
      float eyeballY2 = eyeLevel;
      ellipse(eyeballX1, eyeballY1, eyeSizeW, eyeSizeH);
      ellipse(eyeballX2, eyeballY2, eyeSizeW, eyeSizeH);

      //nose
      float noseX = random(eyeballX1+20, eyeballX2-20);
      line(noseX, y+45, noseX, y+60);

      //buddha dot
      fill(0);
      float dotX = eyeballX1+((eyeballX2-eyeballX1)/2);
      ellipse(dotX, y+20, 4, 4);

      //lips
      float lipX = random(eyeballX1+20, eyeballX2-20);
      float lipY = random(y+65, y+85);
      float lipWidth = random(10, 20);
      fill(0);
      ellipse(lipX, lipY, lipWidth, random(5, 10));
      line(lipX-(lipWidth/2)-5, lipY, lipX+(lipWidth/2)+5, lipY);
    }
  }
  endRecord();
  bRecordingPDF = false;
  pdfOutputCount++;
}

void draw() {
  //drawGrid();
  //background(255);
  //curveTightness(t);
}