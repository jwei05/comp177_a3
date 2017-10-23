class Bar{
   float x_pos; //x pos. for rect. drawing
   float y_pos; //y pos. for rect. drawing
   float bar_width;
   float bar_height;
   float temp_x;
   float temp_y;
   float bar_temp_h;
   float temp_w;
   
   float bar_val;
   float bar_id; //corresponds to the hour
   float data_x;
   float data_y;
   int c;
   
   public Bar(float _x_pos, float _y_pos, float bar_w, float bar_h, float bar_v,
                                       float x, float y, int colr) {
          x_pos = _x_pos;
          y_pos = _y_pos;
          temp_x = _x_pos;
          temp_y = _y_pos;
          temp_w = bar_w;
          bar_width = bar_w;
          bar_height = bar_h;
          bar_val = bar_v;
          data_x = x;
          data_y = y;
          bar_temp_h = bar_height;
          c = colr;
   }
   
   void drawBar() {
      fill(c);
       rect(temp_x, temp_y, temp_w, bar_temp_h);
   }
  
}