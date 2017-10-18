int[] hours;
float[] temperatures;
//Bar_chart bar_chart;
//Line_chart line_chart;
//Pie_chart pie_chart;

Button b_line, b_bar, b_pie;
float panel_x;
float panel_y;
float panel_width;
float panel_height;
float canvas_x;
float canvas_y;
float canvas_width;
float canvas_height;
static int y_spacing = 25;
 
String state = "line";

void setup(){
  size(900, 600);
  background(255);
  panel_x = 0;
  panel_y = 5 *height/6;
  panel_width = width;
  panel_height = height/6;
  canvas_x = 0;
  canvas_y = 0;
  canvas_width = width;
  canvas_height = 5 *height/6;
  
  parseData();
}

void draw() {
  clear();
  background(255);
  renderPanel();
  renderButtons();
  renderChart();
}

void parseData() {
  String[] lines = loadStrings("./data.csv");
  hours = new int[lines.length -1];
  temperatures = new float[lines.length -1];
  for (int i = 1; i < lines.length; i++) {
    String[] data = split(lines[i], ",");
    String[] time = split(data[0], ":");
    hours[i-1] = int(time[0]);
    temperatures[i-1] = float(data[1]);
  }
}

void renderPanel() {
  color c = color(219, 205, 177);
  fill(c);
  noStroke();
  rect(panel_x, panel_y, panel_width, panel_height);
}

void renderButtons(){
  color c = color(255);
  float x_margin = panel_width / 13;
  float y_margin = panel_height / 5;
  
  b_line = new Button(c, "Line Chart", panel_x + x_margin, panel_y + y_margin*1.5, x_margin * 3, y_margin * 2);
  b_bar = new Button(c, "Bar Chart", panel_x + 5*x_margin, panel_y + y_margin*1.5, x_margin * 3, y_margin * 2);
  b_pie = new Button(c, "Pie Chart", panel_x + 9*x_margin, panel_y + y_margin*1.5, x_margin * 3, y_margin * 2);
  
  b_line.render();
  b_bar.render();
  b_pie.render();
}

void renderChart() {
  if (state == "line") {
    renderLineChart();
  }
  else if (state == "bar") {
    renderBarChart();
  }
  else {
    renderPieChart();
  }
}

void renderAxises(float x_margin, float y_margin, float x_unit_len, float y_num_marks, float y_increment) {
  // x axis
  line(x_margin, canvas_height - y_margin, canvas_width - x_margin, canvas_height - y_margin);
  // y axis
  line(x_margin, canvas_height - y_margin, x_margin, y_margin); 
  
  // x label
  for (int i = 0; i < hours.length; i++) {
    float curr_x = x_margin + (i+1)*x_unit_len;
    float curr_y = canvas_height - y_margin;
    line(curr_x, curr_y - 2, curr_x, curr_y + 2);
    textSize(12);
    text(hours[i], x_margin + (i+1)*x_unit_len, canvas_height - y_margin + 15);
  }
  // y label
  for (int i = 0; i < (int)y_num_marks; i++) {
    float curr_x = x_margin;
    float curr_y = canvas_height - y_margin - (i+1)*y_spacing;
    line(curr_x - 2, curr_y, curr_x + 2, curr_y);
    text((i+1)*y_increment, x_margin - 30, canvas_height - y_margin -(i+1)*y_spacing);
  }
}

void renderLineChart() {
  float x_margin = canvas_width / 12;
  float y_margin = canvas_height / 7.5;
  float x_axis_len = canvas_width - 2*x_margin;
  float y_axis_len = canvas_height - 2*y_margin;
  float y_num_marks = y_axis_len/y_spacing;
  float x_unit_len = x_axis_len / (hours.length + 1);
  float y_unit_len = y_num_marks*y_spacing / max(temperatures);
  float y_increment = max(temperatures) / (int)y_num_marks;
 
  renderAxises(x_margin, y_margin, x_unit_len, y_num_marks, y_increment);
  
  // draw data
  for (int i = 0; i < temperatures.length; i++) {
    float curr_x = x_margin + (i+1)*x_unit_len;
    float curr_y = canvas_height - y_margin - temperatures[i]*y_unit_len;
    fill(red(i*10000000), green(i*50000000), blue(i*10000000));
    ellipse(curr_x, curr_y, 6, 6);
    if (i+1 != temperatures.length) {
      float next_x = x_margin + (i+2)*x_unit_len;
      float next_y = canvas_height - y_margin - temperatures[i+1]*y_unit_len;
      line(curr_x, curr_y, next_x, next_y);
    }
  }
}


void renderBarChart() {
  float x_margin = canvas_width / 12;
  float y_margin = canvas_height / 7.5;
  float x_axis_len = canvas_width - 2*x_margin;
  float y_axis_len = canvas_height - 2*y_margin;
  float x_unit_len = x_axis_len / (hours.length + 1);
  float y_num_marks = y_axis_len/y_spacing;
  float y_increment = max(temperatures) / (int)y_num_marks;
  float y_unit_len = y_num_marks*y_spacing / max(temperatures);
  
  renderAxises(x_margin, y_margin, x_unit_len, y_num_marks, y_increment);
  
  // draw data
  for (int i = 0; i < temperatures.length; i++) {
    float curr_x = x_margin + (i+0.66)*x_unit_len;
    float curr_y = canvas_height - y_margin - temperatures[i]*y_unit_len;
    fill(red(i*10000000), green(i*50000000), blue(i*10000000));
    float h = temperatures[i]*y_unit_len -1;
    rect(curr_x, curr_y, 0.66*x_unit_len, h);
    
  }
}

void renderPieChart() {
  float x_pos = canvas_width/2;
  float y_pos = canvas_height/2;
  float d = 0.8*min(canvas_width, canvas_height);
  float sum = get_sum(temperatures);
  float start_angle = 0;
  
  for (int i = 0; i < temperatures.length; i++) {
    float curr_angle = 2*PI*(temperatures[i]/sum);
    ellipseMode(CENTER);
    fill(red(i*10000000), green(i*50000000), blue(i*10000000));
    arc(x_pos, y_pos, d, d, start_angle, start_angle + curr_angle, PIE);
    start_angle += curr_angle;
  } 
}

void mouseClicked () {
  if (b_line.onButton(mouseX, mouseY)) {
    if (state == "pie") {
      pie_to_line();
    }
    else if (state == "bar"){
      bar_to_line();
    }
    state = "line";
  }
  if (b_bar.onButton(mouseX, mouseY)) {
    if (state == "pie") {
      pie_to_bar();
    }
    else if (state == "line"){
      line_to_bar();
    }
    state = "bar";
  }
  if (b_pie.onButton(mouseX, mouseY)) {
    if (state == "line") {
      line_to_pie();
    }
    else if (state == "bar") {
      bar_to_pie();
    }
    state = "pie";
  }
}

void line_to_pie() {
  renderPieChart();
}

void pie_to_line() {
  renderLineChart();
}

void line_to_bar() {
  renderBarChart();
}

void bar_to_line() {
  renderLineChart();
}

void bar_to_pie() {
  bar_to_line();
  line_to_pie();
}

void pie_to_bar() {
  pie_to_line();
  line_to_bar();
}


float get_sum(float []values) {
  float sum = 0;
  for (int i = 0; i < values.length; i++) {
    sum += temperatures[i];
  }
  return sum;
}