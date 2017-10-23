class Point{
  float x_pos;
  float y_pos;
  float value;
  float id;
  float pt_dimension; 
  color c;
  
  public Point(float x, float y, float val, float iD, color colr){
    x_pos = x;
    y_pos = y;
    value = val;
    id = iD;
    pt_dimension = 5;
    c = colr;
  }
  
  void drawPoint(){
    fill(c);
     rect(x_pos - (pt_dimension/2), y_pos - (pt_dimension/2), pt_dimension, pt_dimension);  
  }  
}