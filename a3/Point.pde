class Point{
  float x_pos;
  float y_pos;
  float value;
  float id;
  float pt_dimension; 
  
  public Point(float x, float y, float val, float iD){
    x_pos = x;
    y_pos = y;
    value = val;
    id = iD;
    pt_dimension = 5;
  }
  
  void drawPoint(){
     rect(x_pos - (pt_dimension/2), y_pos - (pt_dimension/2), pt_dimension, pt_dimension);  
  }
  void elongate(float x, float y, float w, float h){
     rect(x, y, w, h); 
  }
  
  
  
}