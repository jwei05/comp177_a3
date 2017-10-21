class Arc{
  float r;
  float center_x;
  float center_y;
  float start;
  float stop;
  float portion;
  float arc_len;
  float temp_center_x;
  float temp_center_y;
  float temp_portion;
  float temp_start;
  float temp_stop;
  
  public Arc(float x, float y, float Start, float End, float Portion){
     center_x = x;
     center_y = y;
     r = .4 * min(canvas_height, canvas_width);
     start = Start;
     stop = End;
     portion = Portion;
     getArcLen();
  }
  
  void drawArc(){
     ellipseMode(CENTER);
     arc(center_x, center_y, r*2, r*2, start, stop); 
  }
  
  void getArcLen() {
    float circumference = 2*PI*r;
    arc_len = circumference * portion;
  }
  
  
  // TODO: initialize all the temps
  
  
}