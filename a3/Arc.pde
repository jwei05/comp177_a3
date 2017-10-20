class Arc{
  float r;
  float center_x;
  float center_y;
  float start;
  float stop;
  
  public Arc(float x, float y, float Start, float End){
     center_x = x;
     center_y = y;
     r = .4 * min(canvas_height, canvas_width);
     start = Start;
     stop = End;
  }
  
  void drawArc(){
     ellipseMode(CENTER);
     arc(center_x, center_y, r*2, r*2, start, stop); 
  }
  
  
}