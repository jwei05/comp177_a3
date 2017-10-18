class Line {
  float x1;
  float x2; 
  float y1;
  float y2;
  float x;
  float y;
  
  Line(float _x1, float _y1, float _x2, float _y2) {
    x1 = _x1;
    x2 = _x2;
    y1 = _y1;
    y2 = _y2;
    x = x1;
    y = y1;
  }
  
  void grow_line() {
    if (x <= x2 && y <= y2) {
      x += 1;
      y += 1;
      line(x1, y1, x, y);
    }
    else {
      line(x1, y1, x2, y2);
    }
  }
}