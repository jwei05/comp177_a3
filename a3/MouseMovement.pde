// Mouse related functions
//---------------------------------------------------------
void mouseClicked () {
  if (b_line.onButton(mouseX, mouseY)) {
    if (data_g.state == "Pie") {
      //println("1");
      pie_to_line = true;
    }
    else if (data_g.state == "Bar"){
      println("2");
      bar_to_line = true;
    }
  }
  if (b_bar.onButton(mouseX, mouseY)) {
    if (data_g.state == "Pie") {
      //println("3");
      pie_to_bar = true;
    }
    else if (data_g.state == "Line"){
      //println("4");
      line_to_bar = true;
    }
  }
  if (b_pie.onButton(mouseX, mouseY)) {
    if (data_g.state == "Line") {
      //println("5");
      line_to_pie = true;
    }
    else if (data_g.state == "Bar") {
      //println("6");
      bar_to_pie = true;
    }
  }
}