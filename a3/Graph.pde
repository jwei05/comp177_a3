class Graph{
  //axis information
  float x_margin;
  float y_margin;//0 for x value, 1 for y
  float x_ax_l; //length of x axis
  float y_ax_l; //length of y axis
  float x_unit_l; //x axis unit length
  float y_unit_l; //y axis unit length
  float y_num_marks;
  float y_increment;
  //states for different data representaiton
  String state; //state of the graph, i.e. bar, line, pie
  String toState;
  
  //Data storage
  ArrayList<Bar> Bar_List = new ArrayList<Bar>();
  
  
  public Graph(float x_start, float y_start, float x_len, float y_len,
                                  float x_unit, float y_unit, String st){
      x_margin = x_start;
      y_margin = y_start;
      x_ax_l = x_len;
      y_ax_l = y_len;
      x_unit_l = x_unit;
      y_unit_l = y_unit;
      state = st;
      toState = st;
      y_num_marks = y_ax_l/y_spacing;
      y_increment = max(temperatures)/(int)y_num_marks;
  }
  
  public void drawGraph(){
  //draw the axis
    if (state != "Pie"){
      drawaxis();
    }
  }
  
  //draws the axis of the graph
  void drawaxis(){
    //x axis
    line(x_margin, canvas_height - y_margin, canvas_width - x_margin,
                                           canvas_height - y_margin);
   //line(x_margin, canvas_height - y_margin, x_ax_l + x_margin,
   //                                         canvas_height - y_margin);
    //y axis
    line(x_margin, canvas_height - y_margin, x_margin, y_margin); 
    
    //draw increments
    // x label
    for (int i = 0; i < hours.length; i++) {
      float curr_x = x_margin + (i+1)*x_unit_l;
      float curr_y = canvas_height - y_margin;
      line(curr_x, curr_y - 2, curr_x, curr_y + 2);
      textSize(12);
      text(hours[i], x_margin + (i+1)*x_unit_l, canvas_height - y_margin + 15);
    }
    // y label
    for (int i = 0; i < (int)y_num_marks; i++) {
      float curr_x = x_margin;
      float curr_y = canvas_height - y_margin - (i+1)*y_spacing;
      line(curr_x - 2, curr_y, curr_x + 2, curr_y);
      text((i+1)*y_increment, x_margin - 30, canvas_height -
                                       y_margin -(i+1)*y_spacing);
    }
  }
  
  void initData(){
    //initialize bars
    float x_pos;
    float y_pos;
    float h;
    float w;
    for(int i = 0; i < temperatures.length; i++){
      x_pos = x_margin + (i+0.66) * x_unit_l;
      y_pos= canvas_height - y_margin - temperatures[i]*y_unit_l;
      h = temperatures[i] * y_unit_l -1;
      w = 0.66 * x_unit_l;
      Bar B = new Bar(x_pos, y_pos, w, h, temperatures[i], 
                       (x_pos + w + x_pos)/2, y_pos);
      Bar_List.add(B);
    }
    
  }
  
  void drawBars(){
    for (Bar b : Bar_List){
      b.drawBar();
    }
  }
  
  
}