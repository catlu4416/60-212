Table allRidesTable;

//int[] bikeCount;
int bikeDiversity;

//stores bikes temporarily while checking for diversity
IntList bikes;
//intlist of final bikeDiversity for every station
IntList finalBikeDiversities;

IntList endStationTest;

String stations[] = {
  "1000", 
  "1001", 
  "1002", 
  "1003", 
  "1004", 
  "1005", 
  "1006", 
  "1007", 
  "1008", 
  "1009", 
  "1010", 
  "1011", 
  "1012", 
  "1013", 
  "1014", 
  "1015", 
  "1016", 
  "1017", 
  "1018", 
  "1019", 
  "1020", 
  "1021", 
  "1022", 
  "1023", 
  "1024", 
  "1025", 
  "1026", 
  "1027", 
  "1028", 
  "1029", 
  "1030", 
  "1031", 
  "1032", 
  "1033", 
  "1034", 
  "1035", 
  "1036", 
  "1037", 
  "1038", 
  "1039", 
  "1040", 
  "1041", 
  "1042", 
  "1043", 
  "1044", 
  "1045", 
  "1046", 
  "1047", 
  "1048", 
  "1049"
};

//JSON stuff
JSONArray bikeStuff;
String jsonFinal;

int count = 0;
int count2 = 0;

void setup() {
  
  allRidesTable = loadTable("HealthyRideRentals2016Q3.csv", "header");
  //Trip id, Starttime, Stoptime, Bikeid, Tripduration, From station id, From station name, To station id, To station name, Usertype
  //println(allRidesTable.getRowCount());


  println(stations.length);
  println(allRidesTable.getRowCount());

  int nRows = allRidesTable.getRowCount();
  int nStations = stations.length;
  bikes = new IntList();

  //final list of bike diversities
  finalBikeDiversities = new IntList();
  
  endStationTest = new IntList();

  //for every station (48 stations);
  for (int sadness = 0; sadness < nStations; sadness++) {
    count++;
    bikeDiversity = 0;

    //temporary list to get bike diversity
    bikes.clear();
    int stationID = int(stations[sadness]);
    
    //for every row of the table (27635 trips)
    for (int i = 0; i < nRows; i++) {
      count2++;
      TableRow ithRow = allRidesTable.getRow(i);

      //String fromStationID = ithRow.getString("From station name");
      int bikeID = int(ithRow.getString("Bikeid"));
      int endStation = int(ithRow.getString("To station id"));
      


      if (bikes.hasValue(bikeID)) {
        //do nothing
      } else {
        if (stationID == endStation) {
          bikes.append(bikeID);
          bikeDiversity++;
        }
      }
      //end 2nd for loop 
    }
    finalBikeDiversities.append(bikeDiversity);
    
  }
  println(finalBikeDiversities);
}