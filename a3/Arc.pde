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
  // variables for curved arc from line
  float arc_cent_xpos;
  float arc_cent_ypos;
  float arc_mid_x;
  float arc_mid_y;
  float arc_start_x;
  float arc_start_y;
  float arc_end_x;
  float arc_end_y;

  float accum_angle;
  float temp_angle;
  boolean translate = false;
  boolean completePie = false;

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
  }
  
  void drawArc(){
     ellipseMode(CENTER);
     noFill();
     if(!completePie){
       println("
       if (translate) {
         pushMatrix();
         translate(arc_mid_x, arc_mid_y);
         rotate( -temp_angle);
         arc(arc_cent_xpos - arc_mid_x, arc_cent_ypos - arc_mid_y, temp_r*2, temp_r*2, temp_start, temp_stop);
         popMatrix();
       }
       else {
         arc(temp_center_x, temp_center_y, temp_r*2, temp_r*2, temp_start, temp_stop); 
       }
    } else {
        println("actual pie");
        arc(center_x, center_y, r*2, r*2, start, stop); 
    }
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
    float circumference = 2 * temp_r * PI;
    temp_portion = arc_len / circumference;
    temp_start = -2 * PI * temp_portion/2;
    temp_stop = 2 * PI * temp_portion/2;
  }
  
  void calc_arctopie_pos(float Accum_Angle) {
      arc_mid_x = center_x + r * cos(Accum_Angle);
      arc_mid_y = center_y - r * sin(Accum_Angle);
      arc_cent_xpos = arc_mid_x - r; 
      arc_cent_ypos = arc_mid_y;
      accum_angle = Accum_Angle;
      float curr_angle = 2 * PI * portion;
      
      //start and end of the arc on the pie
      arc_start_x = center_x + r * cos(Accum_Angle - curr_angle/2);
      arc_start_y = center_y - r * sin(Accum_Angle - curr_angle/2);
      arc_end_x = center_x + r * cos(Accum_Angle + curr_angle/2);
      arc_end_y = center_y - r * sin(Accum_Angle + curr_angle/2);

  }
  
  
}