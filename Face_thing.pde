//
// a template for receiving face tracking osc messages from
// Kyle McDonald's FaceOSC https://github.com/kylemcdonald/ofxFaceTracker
//
// 2012 Dan Wilcox danomatika.com
// for the IACD Spring 2012 class at the CMU School of Art
//
// adapted from from Greg Borenstein's 2011 example
// http://www.gregborenstein.com/
// https://gist.github.com/1603230
//
import oscP5.*;
OscP5 oscP5;

// num faces found
int found;

//pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();

//gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;

//mouth fixed place
float mouthX = 0;
float mouthY = 20;

//actual measurements while changing facial expression
float activateMouthHeight;
float activateMouthWidth;

//particle stuff
float particleSize = 5;
int numParticles = 3000;
int mouthOpen = 0;
//makes it so that particles will start out on screen using mouthOpen = 0
int mouthOpenEdgeCase = 0;
Particle[] particles = new Particle[numParticles];

//beam stuff
float beamCheckCount = 0;
float beamSize = 50;
float beamResetCount = 0;


void setup() {
  size(600, 600, P3D);
  frameRate(30);

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseScale", "/pose/scale");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");

  //creating particle array
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(particleSize);
  }
}

/*void drawFeatures() {

  activateMouthHeight = mouthHeight * 3;
  activateMouthWidth = mouthWidth * 3;

  if (found > 0) {
    translate(posePosition.x, posePosition.y);
    scale(poseScale);
    stroke(77, 252, 255);
    noFill();
    //eyes
    ellipse(-20, eyeLeft * -9, 20, 7);
    ellipse(20, eyeRight * -9, 20, 7);
    //mouth
    ellipse(mouthX, mouthY, activateMouthWidth, activateMouthHeight);
    fill(0);
  }
}*/

void drawFeatures() {

  activateMouthHeight = mouthHeight * 3;
  activateMouthWidth = mouthWidth * 3;

  if (found > 0) {
    translate(posePosition.x, posePosition.y);
    scale(poseScale);
    noStroke();
    fill(255,0,0);
    //eyes
    beginShape();
    vertex(-30, eyeLeft*-9);
    vertex(-20, ((eyeLeft*-9)-5));
    vertex(-10, eyeLeft*-9);
    vertex(-20, ((eyeLeft*-9)+5));
    endShape(CLOSE);
        
    beginShape();
    vertex(30, eyeRight*-9);
    vertex(20, ((eyeRight*-9)-5));
    vertex(10, eyeRight*-9);
    vertex(20, ((eyeRight*-9)+5));
    endShape(CLOSE);
    //mouth
    ellipse(mouthX, mouthY, activateMouthWidth, activateMouthHeight);
    fill(0);
  }
}
class Particle {
  float x;
  float y;
  float x2;
  float y2;
  float r;
  float changeX;
  float changeY;
  float changeXBack;
  float changeYBack;
  float speed;

  Particle(float tempR) {
    x = random(-125, 125);
    y = random(-125, 125);
    x2 = random(-125, 125);
    y2 = random (-125, 125);
    r = tempR;
  }
  void display() {
    stroke(255);
    strokeWeight(0.2);
    //fill(0, 255, 191);
    fill(255);
    ellipse(x, y, r, r);

  }
  void wiggle() {
    y += random(-1, 1);
    x += random (-1, 1);
  }

  void shrink() {
    if (r >= 1) {
      r -= 0.5;
    }
  }
  
  void beamShrink() {
    if (r >= 10) {
      r -= 5;
    }
  }

  void grow() {
    if (r <= 10) {
      r += 0.1;
    }
  }
  
  void beamGrow() {
    if (r <= 100) {
      r += 5;
    }
  }

  void travel() {
    speed = random(5);
    changeX = (abs(mouthX - x)/20) * speed;
    changeY = (abs(mouthY - y)/20) * speed;
    if ((x <= 0) && (y <= 20)) {
      x += changeX;
      y += changeY;
    }
    if ((x >= 0) && (y <= 20)) {
      x -= changeX;
      y += changeY;
    }
    if ((x <= 0) && (y >= 20)) {
      x += changeX;
      y -= changeY;
    }
    if ((x >= 0) && (y >= 20)) {
      x -= changeX;
      y -= changeY;
    }
  }

  void travelBack() {
    //x2 = random(-100, 100);
    //y2 = random (-100,100);
    speed = 1;
    changeX = (abs(mouthX - x)/20) * speed;
    changeY = (abs(mouthY - y)/20) * speed;
    if ((x <= 0) && (y <= 20) && (x >= x2) && (y >= y2)) {
      x -= changeX;
      y -= changeY;
    }
    if ((x >= 0) && (y <= 20)&& (x <= x2) && (y >= y2)) {
      x += changeX;
      y -= changeY;
    }
    if ((x <= 0) && (y >= 20)&& (x >= x2) && (y <= y2)) {
      x -= changeX;
      y += changeY;
    }
    if ((x >= 0) && (y >= 20)&& (x <= x2) && (y <= y2)) {
      x += changeX;
      y += changeY;
    }
  }

  void beamShoot() {
    speed = 100;
    changeX = (abs(mouthX - x)/20) * speed;
    changeY = (abs(mouthY - y)/20) * speed;
    if ((x <= 0) && (y <= 20) && (x >= x2) && (y >= y2)) {
      x -= changeX;
      y -= changeY;
    }
    if ((x >= 0) && (y <= 20)&& (x <= x2) && (y >= y2)) {
      x += changeX;
      y -= changeY;
    }
    if ((x <= 0) && (y >= 20)&& (x >= x2) && (y <= y2)) {
      x -= changeX;
      y += changeY;
    }
    if ((x >= 0) && (y >= 20)&& (x <= x2) && (y <= y2)) {
      x += changeX;
      y += changeY;
    }

  }

//Particle class closing bracket
}


void mouthTest() { 
  //test if not open
  if ((activateMouthHeight <= 10) && (mouthOpenEdgeCase == 1)) {
    mouthOpen = 2;
  }
  //test if open
  if (activateMouthHeight > 10) {
    mouthOpen = 1;
    beamResetCount = 0;
    mouthOpenEdgeCase = 1;
  }
}

void beamCheck() {
  if (beamCheckCount >= 80) {
    mouthOpen = 3;
  }
}

void beamResetCheck() {
  if (beamResetCount >= 5) {
    beamCheckCount = 0;
    mouthOpen = 0;

  }
}


void draw() {  
  background(0);
  stroke(0);
  stroke(255);
  drawFeatures();
  mouthTest();
  beamCheck();
  beamResetCheck();

  if (mouthOpen == 0) {
    for (int i = 0; i < particles.length; i++) {
      particles[i].wiggle();
      particles[i].display();
      particles[i].beamShrink();
    }
  }
  if (mouthOpen == 1) {
    for (int i = 0; i < particles.length; i++) {
      particles[i].wiggle();
      particles[i].travel();
      particles[i].shrink();
      particles[i].display();
    }
    beamCheckCount += 1;
  }
  if (mouthOpen == 2) {
    for (int i = 0; i < particles.length; i++) {
      particles[i].wiggle();
      particles[i].travelBack();
      particles[i].grow();
      particles[i].display();
    }
    beamCheckCount = 0;
    //fill(0);    
    //rect(0,0,20,20);
  }
  if (mouthOpen == 3) {
    for (int i = 0; i < particles.length; i++) {
      particles[i].beamShoot();
      particles[i].display();
      particles[i].beamGrow();
    }
    beamResetCount += 1;
  }
}

// OSC CALLBACK FUNCTIONS

public void found(int i) {
  //println("found: " + i);
  found = i;
}

public void poseScale(float s) {
  //println("scale: " + s);
  poseScale = s;
}

public void posePosition(float x, float y) {
  //println("pose position\tX: " + x + " Y: " + y );
  posePosition.set(x, y, 0);
}

public void poseOrientation(float x, float y, float z) {
  //println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientation.set(x, y, z);
}

public void mouthWidthReceived(float w) {
  //println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  //println("mouth height: " + h);
  mouthHeight = h;
}

public void eyeLeftReceived(float f) {
  //println("eye left: " + f);
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  //println("eye right: " + f);
  eyeRight = f;
}

public void eyebrowLeftReceived(float f) {
  //println("eyebrow left: " + f);
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  //println("eyebrow right: " + f);
  eyebrowRight = f;
}

public void jawReceived(float f) {
  //println("jaw: " + f);
  jaw = f;
}

public void nostrilsReceived(float f) {
  //println("nostrils: " + f);
  nostrils = f;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if (m.isPlugged() == false) {
    //println("UNPLUGGED: " + m);
  }
}