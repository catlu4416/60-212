

function setup() {
  createCanvas(700, 700)
}


function lineArray() {
  //make array of lines
  var prevRowX = 0
  var prevRowY = 0
  var angleRandom;
  var choice = floor(random(0,1))
  for (var rowCount = 0; rowCount < 100; rowCount++) {
    for (var lineCount = 0; lineCount < 1000; lineCount++) {
      //sets line bounding blocks
      var rowX = 12 * lineCount
      var rowY = 15 * rowCount - 5
      var x1 = random((prevRowX + 5), (rowX - 5))
      var y1 = random(prevRowY, rowY)
      prevRowX = rowX
      prevRowY = rowY
      var length = 20
      angleRandom = floor(randomGaussian(270, 20))
      if (lineCount / 3 === 0) {
        angleRandom = floor(random(200, 50))
      }
      if (lineCount / 2 === 0) {
        angleRandom = floor(random(220, 320))
      }
      var angle = angleRandom * (PI / 180)
      var x2 = (x1 + length * cos(angle))
      var y2 = (y1 + length * sin(angle))
      if (choice == 0) {
        line(x1,y1,x2,y2)
      }
  }
    lineCount = 0
  }
}


function mouseClicked() {
  background(250)
  lineArray()
}

function draw() {

}