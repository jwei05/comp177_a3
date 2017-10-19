class Bar{
   float x_pos; //x pos. for rect. drawing
   float y_pos; //y pos. for rect. drawing
   float bar_width;
   float bar_height;
   float bar_val;
   float bar_id; //corresponds to the hour
   float data_x;
   float data_y;
   
   public Bar(float _x_pos, float _y_pos, float bar_w, float bar_h, float bar_v,
                                       float x, float y) {
          x_pos = _x_pos;
          y_pos = _y_pos;
          bar_width = bar_w;
          bar_height = bar_h;
          bar_val = bar_v;
          data_x = x;
          data_y = y; 
   }
   
   void drawBar() {
       rect(x_pos, y_pos, bar_width, bar_height);
       
   }
  
}