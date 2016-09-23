var functionChange = 0
var square = 0

var xLeft1 = 100;
var yLeft1 = 300;
var xRight1 = 300;
var yRight1 = 300;

var xLeft2 = 100;
var yLeft2 = 200;
var xRight2 = 200;
var yRight2 = 200;

var xLeft3 = 150;
var yLeft3 = 100;
var xRight3 = 200;
var yRight3 = 100;

var xTop1 = 300;
var yTop1 = 100;
var xBottom1 = 300;
var yBottom1 = 200;

var xTop2 = 100;
var yTop2 = 100;
var xBottom2 = 100;
var yBottom2 = 150;

var xTop3 = 200;
var yTop3 = 125;
var xBottom3 = 200;
var yBottom3 = 150;

//inflate square coordinates
var xLeftTop = 150
var yLeftTop = 125
var xRightTop = 175
var yRightTop = 125
var xLeftBottom = 150
var yLeftBottom = 150
var xRightBottom = 175
var yRightBottom = 150


function setup() {
  createCanvas(400, 400)
  background('pink')
}

function resetVar() {
  xLeft1 = 100;
  yLeft1 = 300;
  xRight1 = 300;
  yRight1 = 300;

  xLeft2 = 100;
  yLeft2 = 200;
  xRight2 = 200;
  yRight2 = 200;

  xLeft3 = 150;
  yLeft3 = 100;
  xRight3 = 200;
  yRight3 = 100;

  xTop1 = 300;
  yTop1 = 100;
  xBottom1 = 300;
  yBottom1 = 200;

  xTop2 = 100;
  yTop2 = 100;
  xBottom2 = 100;
  yBottom2 = 150;

  xTop3 = 200;
  yTop3 = 125;
  xBottom3 = 200;
  yBottom3 = 150;
  
  xLeftTop = 150
  yLeftTop = 125
  xRightTop = 175
  yRightTop = 125
  xLeftBottom = 150
  yLeftBottom = 150
  xRightBottom = 175
  yRightBottom = 150
}

function inflateSquare() {
  beginShape()
  vertex(xLeftTop, yLeftTop)
  vertex(xRightTop, yRightTop)
  vertex(xRightBottom, yRightBottom)
  vertex(xLeftBottom, xRightBottom)
  endShape(CLOSE)
    //expand square
  if ((xLeftTop >= 100) && (xLeftBottom >= 100)) {
    xLeftTop -= 1
    xLeftBottom -= 1
  }
  if ((xRightTop <= 300) && (xRightBottom <= 300)) {
    xRightTop += 2
    xRightBottom += 2
  }
  if ((yLeftTop >= 102) && (yRightTop >= 102)) {
    yLeftTop -= 2
    yRightTop -= 2
  }
  if ((yLeftBottom <= 300) && (yRightBottom <= 300)) {
    yLeftBottom += 1
    yRightBottom += 2.3
  }
  if ((yRightBottom >= 300) && (xRightBottom >= 300)) {
    functionChange = 7
  }
}

function fold6() {
  rect(150, 125, 25, 25)
  beginShape()
  vertex(175, 125)
  vertex(175, 150)
  vertex(xBottom3, yBottom3)
  vertex(xTop3, yTop3)
  endShape(CLOSE)
    //movement for fold
  var borderLeft3 = 150
  var borderRight3 = 175
  var xChange6 = 2
  var yChange6 = 0.5
    //before halfway fold
  if ((xTop3 >= borderRight3) && (xBottom3 >= borderRight3)) {
    xTop3 -= xChange6
    yTop3 -= yChange6
    xBottom3 -= xChange6
    yBottom3 += yChange6
    xChange6 -= 2
  }
  //after halfway fold
  if ((xTop3 <= borderRight3) && (xTop3 >= borderLeft3) &&
    (xBottom3 <= borderRight3) && (xBottom3 >= borderLeft3)) {
    xTop3 -= xChange6
    yTop3 += yChange6
    xBottom3 -= xChange6
    yBottom3 -= yChange6
    xChange6 += 2
  }
  if (xTop3 == borderLeft3) {
    functionChange = 6
    square = 1
  }

}

function fold5() {
  rect(150, 125, 50, 25)
  beginShape()
  vertex(150, 125)
  vertex(200, 125)
  vertex(xRight3, yRight3)
  vertex(xLeft3, yLeft3)
  endShape(CLOSE)
    //movement for fold
  var borderTop3 = 125
  var borderBottom3 = 150
  var xChange5 = 0.5
  var yChange5 = 2
    //before halfway fold
  if ((yLeft3 <= borderTop3) && (yRight3 <= borderTop3)) {
    xLeft3 -= xChange5
    yLeft3 += yChange5
    xRight3 += xChange5
    yRight3 += yChange5
    yChange5 -= 2
  }
  if ((yLeft3 >= borderTop3) && (yLeft3 <= borderBottom3) &&
    (yRight3 >= borderTop3) && (yRight3 <= borderBottom3)) {
    xLeft3 += xChange5
    yLeft3 += yChange5
    xRight3 -= xChange5
    yRight3 += yChange5
    yChange5 += 2
  }

  if (yRight3 == borderBottom3) {
    functionChange = 5
  }
}

function fold4() {
  rect(150, 100, 50, 50)
  beginShape()
  vertex(150, 100)
  vertex(150, 150)
  vertex(xBottom2, yBottom2)
  vertex(xTop2, yTop2)
  endShape(CLOSE)

  //movement for fold
  var borderLeft2 = 150
  var borderRight2 = 200
  var xChange4 = 2
  var yChange4 = 0.5
    //before halfway fold
  if ((xTop2 <= borderLeft2) && (xBottom2 <= borderLeft2)) {
    xTop2 += xChange4
    yTop2 -= yChange4
    xBottom2 += xChange4
    yBottom2 += yChange4
    xChange4 -= 2
  }
  //after halfway fold //before halfway fold
  if ((xTop2 <= borderRight2) && (xTop2 > borderLeft2) &&
    (xBottom2 <= borderRight2) && (xBottom2 > borderLeft2)) {
    xTop2 += xChange4
    yTop2 += yChange4
    xBottom2 += xChange4
    yBottom2 -= yChange4
    xChange4 += 2
  }
  if (xTop2 == borderRight2) {
    functionChange = 4
  }

}

function fold3() {
  rect(100, 100, 100, 50)
  beginShape()
  vertex(100, 150)
  vertex(200, 150)
  vertex(xRight2, yRight2)
  vertex(xLeft2, yLeft2)
  endShape(CLOSE)
    //movement for fold
  var borderBottom2 = 150
  var borderTop2 = 100
  var xChange3 = 0.5
  var yChange3 = 2
    //before halfway fold
  if ((yLeft2 >= borderBottom2) && (yRight2 >= borderBottom2)) {
    xLeft2 -= xChange3
    yLeft2 -= yChange3
    xRight2 += xChange3
    yRight2 -= yChange3
    yChange3 -= 2
  }
  //after halfway fold
  if ((yLeft2 <= borderBottom2) && (yLeft2 > borderTop2) &&
    (yRight2 <= borderBottom2) && (yRight2 > borderTop2)) {
    xLeft2 += xChange3
    yLeft2 -= yChange3
    xRight2 -= xChange3
    yRight2 -= yChange3
    yChange3 += 2
  }
  if (yRight2 == borderTop2) {
    functionChange = 3
  }
}


function fold2() {
  rect(100, 100, 100, 100)
  beginShape()
  vertex(200, 100)
  vertex(200, 200)
  vertex(xBottom1, yBottom1)
  vertex(xTop1, yTop1)
  endShape(CLOSE)

  //movement for fold
  var borderLeft1 = 100
  var borderRight1 = 200
  var xChange2 = 2
  var yChange2 = 0.5
    //before halfway fold
  if ((xTop1 >= borderRight1) && (xBottom1 >= borderRight1)) {
    xTop1 -= xChange2
    yTop1 -= yChange2
    xBottom1 -= xChange2
    yBottom1 += yChange2
    xChange2 -= 2
  }
  //after halfway fold
  if ((xTop1 <= borderRight1) && (xTop1 > borderLeft1) &&
    (xBottom1 <= borderRight1) && (xBottom1 > borderLeft1)) {
    xTop1 -= xChange2
    yTop1 += yChange2
    xBottom1 -= xChange2
    yBottom1 -= yChange2
    xChange2 += 2
  }
  if (xTop1 == borderLeft1) {
    functionChange = 2
  }

}

function fold1() {
  rect(100, 100, 200, 100)
  beginShape()
  vertex(100, 200)
  vertex(300, 200)
  vertex(xRight1, yRight1)
  vertex(xLeft1, yLeft1)
  endShape(CLOSE)
    //movement for fold

  var borderBottom1 = 200
  var borderTop1 = 100
  var xChange1 = 0.5
  var yChange1 = 2
    //before halfway fold
  if ((yLeft1 >= borderBottom1) && (yRight1 >= borderBottom1)) {
    xLeft1 -= xChange1
    yLeft1 -= yChange1
    xRight1 += xChange1
    yRight1 -= yChange1
    yChange1 -= 2
  }
  //after halfway fold
  if ((yLeft1 <= borderBottom1) && (yLeft1 > borderTop1) &&
    (yRight1 <= borderBottom1) && (yRight1 > borderTop1)) {
    xLeft1 += xChange1
    yLeft1 -= yChange1
    xRight1 -= xChange1
    yRight1 -= yChange1
    yChange1 += 2
  }
  if (xLeft1 == borderTop1) {
    functionChange = 1
  }
}



function draw() {
  fill(255,200,0)
  stroke('red')
    if (functionChange == 0) {
      fold1()
    }
    if (functionChange == 1) {
      fold2()
    }
    if (functionChange == 2) {
      fold3()
    }
    if (functionChange == 3) {
      fold4()
    }
    if (functionChange == 4) {
      fold5()
    }
    if (functionChange == 5) {
      fold6()
    }
    if ((square == 1) && (functionChange == 6)){
      inflateSquare()
    }
    if (functionChange == 7) {
      square = 0
      resetVar()
      functionChange = 0
    }
}