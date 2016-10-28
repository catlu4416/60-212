#includepath "~/Documents/;%USERPROFILE%Documents";
#includepath "D:\\Documents";
#include "basiljs/bundle/basil.js";

// Load a data file containing your book's content. This is expected
// to be located in the "data" folder adjacent to your .indd and .jsx. 
// In this example (an alphabet book), our data file looks like:
// [
//    {
//      "title": "A",
//      "image": "a.jpg",
//      "caption": "Ant"
//    }
// ]
var jsonString = b.loadString("book.json");
var jsonData;
var imageFolder;
var anImageFilename;
var anImage;

//--------------------------------------------------------
function setup() {

  // Clear the document at the very start. 
  b.clear (b.doc());
  
  // Make a title page. 
  b.fill(0,0,0);
  b.textSize(24);
  b.textFont("Garamond"); 
  b.textAlign(Justification.CENTER_ALIGN); 
  b.text("MythMash", 72,72,360,36);
  b.textSize(16);
  b.text("Is a journey into the many mythologies of our world; a whimsical examination of their similarities and differences through generative mashup myth.", 72,108,360,300);

  
  // Parse the JSON file into the jsonData array
  jsonData = b.JSON.decode( jsonString );
  b.println("Number of elements in JSON: " + jsonData.length);
  b.println(jsonData);


  // Initialize some variables for element placement positions.
  // Remember that the units are "points", 72 points = 1 inch.
  var titleX = 320; 
  var titleY = 415;
  var titleW = 150;
  var titleH = 50;

  var captionX = 54; 
  var captionY = 54;
  var captionW = 396;
  var captionH =396;

  var imageX = 72; 
  var imageY = 72-30; 
  var imageW = 72*3; 
  var imageH = 72*3;


  // Loop over every element of the book content array
  // (Here assumed to be separate pages)
  for (var i = 0; i < jsonData.length; i++) {

    // Create the next page. 
    b.addPage();

    // Load an image from the "images" folder inside the data folder;
    // Display the image in a large frame, resize it as necessary. 
    b.noStroke();  // no border around image, please.
    
    

    //6 digits (hundreds of thousands)
    if (b.floor((jsonData[i].image/1000000)) == 0) {
        imageFolder = "00" + b.floor((jsonData[i].image/1000));
    }
    //5 digits (tens of thousands)
    if (b.floor((jsonData[i].image/100000)) == 0) {
        imageFolder = "000" + b.floor((jsonData[i].image/1000));
    }
    //4 digits (thousands)
    if (b.floor((jsonData[i].image/10000)) == 0) {
        imageFolder = "0000" + b.floor((jsonData[i].image/1000));
    }
    //first 1000
    if (b.floor((jsonData[i].image/1000)) == 0) {
        imageFolder = "0000" + b.floor((jsonData[i].image/10000));
    }

    
    
    var anImageFilename = "images/" + imageFolder + "/" + jsonData[i].image + ".jpg";
    var anImage = b.image(anImageFilename, imageX, imageY, imageW, imageH);
    anImage.fit(FitOptions.PROPORTIONALLY);
   
    

    // Create textframes for the "title" field.
    // Draw an ellipse with a random color behind the title letter.
    //b.noStroke(); 
    //b.fill(b.random(180,220),b.random(180,220),b.random(180,220)); 
    //b.ellipseMode(b.CORNER);
    //b.ellipse (titleX,titleY,titleW,titleH);
    
    b.addPage();
    
    b.fill(0);
    b.textSize(10);
    b.textFont("Garamond"); 
    b.textAlign(Justification.CENTER_ALIGN, VerticalJustification.CENTER_ALIGN );
    b.text(jsonData[i].title, titleX,titleY,titleW,titleH);
    //b.println(jsonData[i].title);

    // Create textframes for the "caption" fields
    b.fill(0);
    b.textSize(12);
    b.textFont("Garamond"); 
    b.textAlign(Justification.LEFT_ALIGN, VerticalJustification.TOP_ALIGN );
    b.text(jsonData[i].caption, captionX,captionY,captionW,captionH);

  };
}

// This makes it all happen:
b.go(); 