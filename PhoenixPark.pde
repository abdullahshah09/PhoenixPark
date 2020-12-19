PImage bg;

void setup()
{
  size(500, 500);
  
  loadData();
  calculateSums();
  println(sums);
  bg = loadImage("rain.jpg");
}

ArrayList<ArrayList<Float>> data = new ArrayList<ArrayList<Float>>();

int flag = 0;
ArrayList<Float> sums = new ArrayList<Float>();


// Ive added these to a separate file, so students dont have to do this for the first part of the lab
void calculateSums()
{
  for(ArrayList<Float> lineData:data)
  {
    float sum = 0;
    for (float f:lineData)
    {
      sum += f;
    }
    sums.add(sum);
  }
}

void drawTrendLineGraph(ArrayList<Float> data, String title)
{
  background(bg);
  float border = width * 0.1;
  // Print the text 
   textAlign(CENTER, CENTER);   
   float textY = (border * 1.1); 
   text("Phoenix Park rainfall data 2007 - 2015", width * 0.5, textY);
   
  drawAxis(data, 10, 10, 1200, border);   
  float windowRange = (width - (border * 2.0f));
  float dataRange = 1200;      
  float lineWidth =  windowRange / (float) (data.size() - 1) ;
  
  stroke(72, 245, 12);
  for (int i = 1 ; i < data.size() ; i ++)
  {
    float x1 = map(i - 1, 0, data.size(), border, border + windowRange);
    float x2 = map(i, 0, data.size(), border, border + windowRange);
    float y1 = map(data.get(i - 1), 0, dataRange, height - border, (height - border) - windowRange);
    float y2 = map(data.get(i), 0, dataRange, height - border, (height - border) - windowRange);
    line(x1, y1, x2, y2);
  }  
  
  flag = 2;
}

void drawAxis(ArrayList<Float> data, int horizIntervals, int verticalIntervals, float vertDataRange, float border)
{
  stroke(231, 140, 10);
  fill(248, 248, 248);  
  
  // Draw the horizontal azis  
  line(border, height - border, width - border, height - border);
  
  float windowRange = (width - (border * 2.0));  
  float tickSize = border * 0.2;
      
  for (int i = 0 ; i <= horizIntervals ; i ++)
  {   
   // Draw the ticks
   float x = map(i, 0, horizIntervals, border, border + windowRange);
    line(x, height - (border - tickSize)
      , x, (height - border));    
      
   textAlign(CENTER, CENTER);   
   float textY = height - (border * 0.5f); 
   text((int) map(i, 0, horizIntervals, 2005, 2015), x, textY);
   
  } 
  
  // Draw the vertical axis
  line(border, border , border, height - border);
  
  for (int i = 0 ; i <= verticalIntervals ; i ++)
  {
    float y = map(i, 0, verticalIntervals, height - border,  border);
    line(border - tickSize, y, border, y);
    float hAxisLabel = map(i, 0, verticalIntervals, 0, 1200);
        
    textAlign(RIGHT, CENTER);  
    text((int)hAxisLabel, border - (tickSize * 2.0f), y);
  }    
}


void draw()
{
  
  String a = "Press '1' to view Trend Graph";
  String b = "Press '2' to view Piechart";
  textSize(14);
  fill(0);
  text(a, 50, 100, 200, 200);
  text(b, 50, 200, 200, 200);
  if(keyPressed) {
   if(key == '1') {
     flag = 1;
   }
  }
  
  if(flag == 1) {
    drawTrendLineGraph(sums, "2005");
  }
}

void loadSums()
{
  String[] strings = loadStrings("sum.csv");
  
  for(String s:strings)
  {
    sums.add(parseFloat(s));
  }
  
}

void loadData()
{
  String[] strings = loadStrings("phoenixparkrain.csv");
  
  for(String s:strings)
  {
    println(s);
    String[] line = s.split(",");
    
    ArrayList<Float> lineData = new ArrayList<Float>();
    
    // Start at 1, so we skip the first one 
    for (int i = 1 ; i < line.length ; i ++)
    {
      lineData.add(Float.parseFloat(line[i]));              
    }
    data.add(lineData);
  }
}
