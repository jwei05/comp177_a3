int[] hours;
float[] temperatures;
Graph data_g;
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
  init_graph();
  data_g.initData();
}

void draw() {
  clear();
  background(255);
  renderPanel();
  renderButtons();
  updateGraph();
  data_g.drawGraph();
  data_g.drawBars();

  //renderChart();
}

void updateGraph(){
  float before = data_g.x_ax_l;
  data_g.x_ax_l = before - 10;
  float ybefore = data_g.y_ax_l;
  //data_g.y_ax_l = ybefore + 10;
  
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

void init_graph(){
  float x_margin = canvas_width / 12;
  float y_margin = canvas_height / 7.5;
  float x_axis_len = canvas_width - 2*x_margin;
  float y_axis_len = canvas_height - 2*y_margin;
  float y_num_marks = y_axis_len/y_spacing;
  float x_unit_len = x_axis_len / (hours.length + 1);
  float y_unit_len = y_num_marks*y_spacing / max(temperatures);
  data_g = new Graph(x_margin, y_margin, x_axis_len, y_axis_len, 
                   x_unit_len, y_unit_len, "line");
  
}
  