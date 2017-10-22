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
  ArrayList<Point> Point_List = new ArrayList<Point>();
  ArrayList<Arc> Arc_List = new ArrayList<Arc>();
  //boolean states
  boolean toconnect = false;
  boolean growBar = false;
  boolean toArc = false;
  boolean moveArcs = false;
  
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
    if (state == "Line") {
      drawPoints(true);
    } else if (state == "Bar") {
      drawBars();
    } else {
      drawArcs();
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
    float pie_centerx = canvas_width/2;
    float pie_centery = canvas_height/2;
    float h;
    float w;
    float sum = get_sum();
    float start_angle = 0;

    for(int i = 0; i < temperatures.length; i++){
      x_pos = x_margin + (i+0.66) * x_unit_l;
      y_pos= canvas_height - y_margin - temperatures[i]*y_unit_l;
      h = temperatures[i] * y_unit_l -1;
      w = 0.66 * x_unit_l;
      
      Bar B = new Bar(x_pos, y_pos, w, h, temperatures[i], 
                       (x_pos + w + x_pos)/2, y_pos);
      Point P = new Point((x_pos + w + x_pos)/2, y_pos, temperatures[i], hours[i]);
      
      //Calculate values to populate arc object
      float curr_angle = 2 * PI * (temperatures[i]/sum);
      float portion = temperatures[i]/sum;
      Arc A = new Arc(pie_centerx, pie_centery, start_angle, start_angle + curr_angle, portion, (x_pos + w + x_pos)/2, y_pos);
      start_angle += curr_angle;
      //A.calc_arctopie_pos();
      
      //populate arrays
      Arc_List.add(A);
      Bar_List.add(B);
      Point_List.add(P);
    } 
    //popoulates arc class with the position it should be on the pie
      float accum_angle = 0;
      for (int i = 0; i < Arc_List.size(); i++) {
        Arc c = Arc_List.get(i);
        if (i != Arc_List.size() - 1){
          Arc next = Arc_List.get(i + 1);
          c.calc_arctopie_pos(accum_angle);
          float curr_angle = c.portion * 2 * PI;
          float next_angle = next.portion * 2 * PI;
          accum_angle = accum_angle + curr_angle/2 + next_angle/2;
        } else {
          c.calc_arctopie_pos(accum_angle); 
        }
           //line(c.arc_cent_xpos, c.arc_cent_ypos, c.arc_mid_x, c.arc_mid_y);
      }
  }
  
  void drawBars(){
    for (Bar b : Bar_List){
      b.drawBar();
    }
  }
  
  void drawArcs(){
    for(Arc a : Arc_List){
       a.drawArc(false); 
       line(a.arc_cent_xpos, a.arc_cent_ypos, a.arc_mid_x, a.arc_mid_y);
    }
  }
  
  void drawPoints(boolean withline){
     for(Point p : Point_List){
        p.drawPoint(); 
     }
     if (withline){
       connectPoints();
     }
  }
  
  void connectPoints(){
    float curr_x;
    float curr_y;
    float next_x;
    float next_y;
    
     for(int i = 0; i < Point_List.size() - 1; i++){
        Point curr = Point_List.get(i);
        Point next = Point_List.get(i+1);
        curr_x = curr.x_pos;
        curr_y = curr.y_pos;
        next_x = next.x_pos;
        next_y = next.y_pos;
        //connect points
        line(curr_x, curr_y, next_x, next_y);
     }
  }
  void line_bar(){
    Bar model_b = Bar_List.get(0);
    Point model_p = Point_List.get(0);
    float bar_w = model_b.bar_width;
    float x, y, h;
    float w = model_p.pt_dimension;
    
    //disconnect all points
    if (state == "Line") {
      drawPoints(false);
    }
    state = "Bar";
    if (state == "Bar"){
        for(Bar b : Bar_List){
          if (b.temp_w < b.bar_width){
             b.temp_w = b.temp_w + 1;
             b.temp_x = b.temp_x - .5;
          } else {
            growBar = true;
          }
        }
    }
    int total_bars = Bar_List.size();
    
    if(growBar == true) {
      for(Bar b : Bar_List){
        if(b.bar_temp_h < b.bar_height){
          b.bar_temp_h = b.bar_temp_h + 2;
        } else{
          total_bars--;
        }
      } 
    }
    //reset when all bars reach their full height
    if (total_bars == 0) {
      resettransitions(); 
    }
  }
  
  //transition from bar to line
  void bar_line() {
     int num_bars = Bar_List.size();
     for (Bar b : Bar_List){  
       if (b.bar_temp_h >= 2.5)  {
         b.bar_temp_h = b.bar_temp_h - 2;
       } else{
         num_bars--;
       }
     }
     
     if (num_bars == 0) {
       for (Bar b : Bar_List){
          if(b.temp_w >= 2.5) {
             b.temp_w = b.temp_w - 1;
             b.temp_x = b.temp_x + .5;
          } else {
            toconnect = true;
          }
       }
     }
     if (toconnect){
         state = "Line";
         resettransitions();
     }
  }
  
  //transition from bar to pie
  void bar_pie(){
    // shrink all the bars to arc's length
    int num_bars = Bar_List.size();
    int size = Bar_List.size();
     for (int i = 0; i < size; i++){  
       Arc a = Arc_List.get(i);
       Bar b = Bar_List.get(i);

       if (b.bar_temp_h > a.arc_len)  {
         b.temp_y += 2;
         b.bar_temp_h = b.bar_temp_h - 2;
       } else{
         num_bars--;
       }
     }
     
     // shrink to lines
     if (num_bars == 0) {
       for (Bar b : Bar_List){
          if(b.temp_w >= 1.5) {
             b.temp_w = b.temp_w - 1;
             b.temp_x = b.temp_x + .5;
          } else {
            toArc = true;
          }
       }
     }
     //curves all the arc
     if (toArc){
         state = "Pie";
         for (Arc a : Arc_List) {
           if (a.temp_r > a.r) {
             a.temp_r -= 100;
             a.temp_center_x = a.x_pos - a.temp_r;
             float x_axis_y = canvas_height - y_margin;
             a.temp_center_y = (x_axis_y - a.arc_len + x_axis_y) /2;
             float circumference = 2 * a.temp_r * PI;
             a.temp_portion = a.arc_len / circumference;
             a.temp_start = -2 * PI * a.temp_portion/2;
             a.temp_stop = 2 * PI * a.temp_portion/2;
           }
           else {
             moveArcs = true;
           }
         }
     }
     
     int num_arcs = Arc_List.size();
     if (moveArcs == true) {
       // move the arcs!!
       for( int i = 0; i < Arc_List.size(); i++) {
          Arc temp = Arc_List.get(i);
          float x_dist = temp.arc_cent_xpos - temp.temp_center_x;
          float y_dist = temp.arc_cent_ypos - temp.temp_center_y;
          
          // TODO: temp.x_dist not moving why??
          if (x_dist < 0) {
            if (temp.arc_cent_xpos < temp.temp_center_x ) {
              temp.temp_center_x -=1;
            }
          } else {
            if (temp.arc_cent_xpos > temp.temp_center_x ) {
              temp.temp_center_x +=1;
            }
          }
          
          if (y_dist < 0) {
            if (temp.arc_cent_ypos < temp.temp_center_y ) {
              temp.temp_center_y -=1;
            }
          } else {
            if (temp.arc_cent_ypos > temp.temp_center_y ) {
              temp.temp_center_y +=1;
            }
          }
          
          if (abs(x_dist) < 1 && abs(y_dist) < 1) {
            num_arcs -= 1;
          }
       }
     }
     
     if (num_arcs == 0) {
       for (Arc a : Arc_List) {
         //a.drawArc(true);
       }
     }
  }
  
  float get_sum(){
    float sum = 0;
    for (int i = 0; i < temperatures.length; i++) {
      sum += temperatures[i];
    }
    return sum;
  } 
}