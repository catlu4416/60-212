import processing.pdf.*;

import rita.*;


String captions[];

int rand1;
int rand2;
String myth1;
String myth2;

String mythsTitlePart1;
String mythsTitlePart2; 
String mythsTitle;

//lexicon initialization
RiLexicon lexicon = new RiLexicon();

//markov initialization
RiMarkov markov;
String mythText = "click to (re)generate!";
int x = 160, y = 240;

//array of myth types
String[] mythTypes = {"africanMyths.txt", "nativeAmericanMyths.txt", "asianMyths.txt", "arabianMyths.txt", 
  "celticMyths.txt", "egyptianMyths.txt", "norseIcelandicMyths.txt", "polynesianMyths.txt", "classicalMyths.txt"};

String[] mythTypesText = {"African", "Native American", "Asian", "Arabian", 
  "Celtic", "Egyptian", "Icelandic", "Polynesian", "Classical"};


//caption stuff
String captionPull;
//caption stuff try 2
String mythCaption1;
String mythCaption2;

String searchNoun;

int foundCount = 0;
IntList picNumbers;

//JSON stuff
JSONArray bookStuff;
String jsonFinal;



void setup()
{
  size(500, 800);

  beginRecord(PDF, "everything.pdf");

  fill(0);
  textFont(createFont("times", 16));
  bookStuff = new JSONArray();
}

void captions() {
  //caption stuff//Golan

  picNumbers = new IntList();

  String captionsFilename = "SBU_captioned_photo_dataset_captions.txt"; 
  String captions[] = loadStrings(captionsFilename); 

  int answerCount = 0; 
  String wordsIWant[] = { searchNoun }; 
  for (int i=0; i<captions.length; i++) {
    String aCaption = captions[i]; 
    aCaption = aCaption.toLowerCase(); 

    boolean bFoundAll = true; 
    for (int j=0; j<wordsIWant.length; j++) {
      String jthWordIWant = " " + wordsIWant[j] + " "; 
      if (aCaption.contains(jthWordIWant)) {
        // don't worry
      } else {
        bFoundAll = false;
      }
    }
    if (bFoundAll) {
      //println(i + "\t" + aCaption); 
      answerCount++;
      picNumbers.append(i);
    }
  }
  //println("---------------------" + answerCount);
}

void getPic() {
  int randomPic = (int) (floor(random(picNumbers.size())));
  int mythPicMinus1 = picNumbers.get(randomPic);
  int mythPicFinal = mythPicMinus1;
  //to get length of int
  int picNumLength = String.valueOf(mythPicFinal).length();
  //add zeros
  if (picNumLength == 6) {
    jsonFinal = "0" + mythPicFinal;
  }
    if (picNumLength == 5) {
    jsonFinal = "00" + mythPicFinal;
  }  if (picNumLength == 4) {
    jsonFinal = "000" + mythPicFinal;
  }  if (picNumLength == 3) {
    jsonFinal = "0000" + mythPicFinal;
  }  if (picNumLength == 2) {
    jsonFinal = "00000" + mythPicFinal;
  }  if (picNumLength == 1) {
    jsonFinal = "000000" + mythPicFinal;
  }
    if (picNumLength == 0) {
    jsonFinal = "0000000";
  }
  
  
  println(jsonFinal);
}

void mythDeclare() {
  mythsTitlePart1 = mythTypesText[rand1];
  mythsTitlePart2 = mythTypesText[rand2];
  mythsTitle = (mythsTitlePart1 + "  x  " + mythsTitlePart2);
  text(mythsTitle, 50, 600, 400, 30);
}

void draw()
{ 
  textAlign(LEFT);
  background(250);
  text(mythText, x, y, 400, 400);
  mythDeclare();
}

void mouseClicked()
{ 
  for (int jsonNum = 0; jsonNum <= 49; jsonNum ++) {

    textAlign(LEFT);

    while (myth1 == myth2) {
      int nMythTypes = mythTypes.length;
      rand1 = (int) floor(random(nMythTypes));
      myth1 = mythTypes[rand1];

      rand2 = (int) floor(random(nMythTypes));
      myth2 = mythTypes[rand2];
    }


    //if (myth1 != myth2) {

    String[] files = { myth1, myth2 };
    markov = new RiMarkov(5);
    markov.loadFrom(files, this);

    if (!markov.ready()) return;

    x = 50;
    y = 150;

    String[] mythTextLines = markov.generateSentences(20);
    mythText = RiTa.join(mythTextLines, " ");
    //println(mythText);

    String[] mythTextPieces = split(mythText, ' ');

    String captionsFilename2 = "SBU_captioned_photo_dataset_captions.txt"; 
    String captions2[] = loadStrings(captionsFilename2);

    int nWordsToSearchForNoun = 16; 
    for (int i=0; i<nWordsToSearchForNoun; i++) {
      String ithWordOfMythText = mythTextPieces[i];
      String[] partsOfSpeechOfIthWord = RiTa.getPosTags(ithWordOfMythText, true);
      if ((partsOfSpeechOfIthWord[0].equals("n")) && (lexicon.containsWord(ithWordOfMythText))) {

        //copy code from above in void caption
        for (int v=0; v<captions2.length; v++) {
          String aCaption2 = captions2[v]; 
          aCaption2 = aCaption2.toLowerCase(); 

          if (aCaption2.contains(ithWordOfMythText)) {
            searchNoun = ithWordOfMythText;
            //println("yay!");
            //println(ithWordOfMythText);
          }
        }
      }
      //println(""); 

      int captionRand1 = (int) (floor(random(12)));
      int captionRand2 = (int) (floor(random(12)));

      mythCaption1 = mythTextPieces[captionRand1];
      mythCaption2 = mythTextPieces[captionRand2];
      //mythDeclare();

      //println(myth1 + "*" + myth2);
      
    }
    captions();
    getPic();
    myth1 = "restart";
    myth2 = "restart";

    mythDeclare();

    //JSON
    JSONObject book = new JSONObject();
    book.setString("image", jsonFinal);
    book.setString("title", mythsTitle);
    book.setString("caption", mythText);

    bookStuff.setJSONObject(jsonNum, book);
  }
  saveJSONArray(bookStuff, "data/new.json");
  println(picNumbers);
}