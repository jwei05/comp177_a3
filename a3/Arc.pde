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
  float temp_r;
  float temp_start;
  float temp_stop;
  float x_pos;
  float y_pos;
  float arc_cent_xpos;
  float arc_cent_ypos;
  float arc_mid_x;
  float arc_mid_y;
  
  public Arc(float x, float y, float Start, float End, float Portion, float bar_x_pos, float bar_y_pos){
     center_x = x;
     center_y = y;
     r = .4 * min(canvas_height, canvas_width);
     start = Start;
     stop = End;
     portion = Portion;
     getArcLen();
     x_pos = bar_x_pos;
     y_pos = bar_y_pos;
     init_temps();
     calc_arctopie_pos();
     
  }
  
  void drawArc(){
     ellipseMode(CENTER);
     noFill();
     arc(temp_center_x, temp_center_y, temp_r*2, temp_r*2, temp_start, temp_stop); 
  }
  
  void getArcLen() {
    float circumference = 2*PI*r;
    arc_len = circumference * portion;
  }
  
 
  void init_temps() {
    float x_axis_y = canvas_height - y_margin;
    temp_r = 10300;
    temp_center_x = x_pos - temp_r;
    temp_center_y = (x_axis_y - arc_len + x_axis_y) /2;
    float circumference = 2*temp_r*PI;
    temp_portion = arc_len / circumference;
    temp_start = -2*PI*temp_portion/2;
    temp_stop = 2*PI*temp_portion/2;
  }
  
  void calc_arctopie_pos(float accum_angle) {
      arc_mid_x = center_x + sin(accum_angle/2);
      arc_mid_y = center_y - cos(accum_angle/2);
      arc_cent_xpos = arc_mid_x - r; 
      arc_cent_ypos = arc_mid_y;
  }
  
  
}