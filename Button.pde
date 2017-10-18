class Button {
  color c;
  String word;
  float x_pos, y_pos;
  float h, w;
  
  Button(color _c, String _word, float _x_pos, float _y_pos, float _w, float _h) {
    c = _c;
    word = _word;
    x_pos = _x_pos;
    y_pos = _y_pos;
    h = _h;
    w = _w;
  }
 
  boolean onButton (float x, float y) {
    if (((x >= x_pos) && (x <= x_pos+w))
    && ((y >=  y_pos) && (y <= y_pos + h))){
      return true;
    }
    return false;
  }
  
  void render () {
    fill(c);
    stroke(0);
    rect(x_pos, y_pos, w, h, 7);
  
    textSize(12);
    fill(0);
    textAlign(CENTER, CENTER);
    text(word, x_pos + w/2 , y_pos + h/2);
  } 
}