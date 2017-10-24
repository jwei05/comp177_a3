// Mouse related functions
//---------------------------------------------------------
void mouseClicked () {
  if (b_line.onButton(mouseX, mouseY)) {
    if (data_g.state == "Pie") {
      pie_to_line = true;
    }
    else if (data_g.state == "Bar"){
      bar_to_line = true;
    }
  }
  if (b_bar.onButton(mouseX, mouseY)) {
    if (data_g.state == "Pie") {
      pie_to_bar = true;
    }
    else if (data_g.state == "Line"){
      line_to_bar = true;
    }
  }
  if (b_pie.onButton(mouseX, mouseY)) {
    if (data_g.state == "Line") {
      line_to_pie = true;
    }
    else if (data_g.state == "Bar") {
      bar_to_pie = true;
    }
  }
}