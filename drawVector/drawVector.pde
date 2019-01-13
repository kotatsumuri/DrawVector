
Vector v1,v2,v3,v4,v5;
Angle a1,a2,a3,a4;

float mousex,mousey;
float Scale =2;

void setup (){
  size(500,500);
  background(255);
  textAlign(CENTER);
  textSize(5);
  frameRate(120);
  
  v1 = new Vector("EL");
  v2 = new Vector("ER2");
  v3 = new Vector("E0");
  v4 = new Vector("ER1");
  v5 = new Vector("EC");
  
  v1.setLengthAndAngle(0.656,46.8);
  v2.setLengthAndAngle(0.981,10.8);
  v3.setLengthAndAngle(1,0);
  v4.setLengthAndAngle(0.66,-43.2);
  v5.setLengthAndAngle(0.13,-79.2);
  
  a1 = new Angle(v3.angle,v1.angle);
  a2 = new Angle(v3.angle,v2.angle);
  a3 = new Angle(v3.angle,v4.angle);
  a4 = new Angle(v3.angle,v5.angle);
}
int c = 0;
int lx=0,ly=0;
void draw(){
  mousex = (mouseX - width/2) / Scale;
  mousey = (mouseY - height/2) / Scale;
  background(255);
  c = 1;
  setupAxis();
  scale(Scale);
  
  v1.drawVector();
  v2.drawVector();
  v3.drawVector();
  v4.drawVector();
  v5.drawVector();
  
  noFill();
  a4.drawAngle();
  a1.drawAngle();
  a2.drawAngle();
  a3.drawAngle();
  
  
}

void setupAxis(){
  line(width/2,0,width/2,height);
  line(0,height/2,width,height/2);
  translate(width/2,height/2);
}

class Angle{
  float base,notbase,angle1,angle2;
  int labelX,labelY;
  
  Angle(float _angle1,float _angle2){
    base = _angle1;
    notbase = _angle2;
    
    if(base < notbase){
      angle1 = base;
      angle2 = notbase;
    }
    else{
      angle1 = notbase;
      angle2 = base;
    }
    
    float diff = notbase -base;
    
    labelX = int(cos(radians(diff/2)) * 30);
    labelY = -int(sin(radians(diff/2)) * 30);
  }
  
  void drawAngle(){
    int r = 20 + 10 * c;
    
     arc(0,0,r,r,-radians(angle2),-radians(angle1)); 
     c++;
     
     float diff = notbase - base;
     
     text(diff + "°",labelX,labelY);
     
     if(mousePressed){
     if(mousex> labelX - 5 && mousex< labelX + 5 && mousey> labelY - 5 && mousey< labelY + 5){
       labelX = int(mousex);
       labelY = int(mousey);
     }
    }
  }
}

class Vector{
  float x,y,len,angle;
  int labelX,labelY,nlabelX,nlabelY;
  String name;
  
  Vector(String _name){
    x = 0;
    y = 0;
    len = 0;
    angle = 0;
    labelX = 0;
    labelY = 0;
    nlabelX = 0;
    nlabelY = 0;
    name = _name;
  }
  
  void drawVector(){
    line(0,0,x*100,y*100);
    drawArraw();
    fill(0);
    text(len,labelX,labelY);
    text(name,nlabelX,nlabelY);
    if(mousePressed){
     if(mousex> labelX - 5 && mousex< labelX + 5 && mousey> labelY - 5 && mousey< labelY + 5){
       labelX = int(mousex);
       labelY = int(mousey);
     }
    }
    if(mousePressed){
     if(mousex> nlabelX - 5 && mousex< nlabelX + 5 && mousey> nlabelY - 5 && mousey< nlabelY + 5){
       nlabelX = int(mousex);
       nlabelY = int(mousey);
     }
    }
  }
  void drawArraw(){
     fill(0);
    float Vx = x*100;
    float Vy = y*100;
    float Ux = Vx/(len*100);
    float Uy = Vy/(len*100);
    float Lux = -Uy;
    float Luy = Ux;
    float Rux = Uy;
    float Ruy = -Ux;
    float Nux = -Ux;
    float Nuy = -Uy;
    
    float Lx = x*100 - Uy*2 -Ux*4;
    float Ly = y*100 + Ux*2 -Uy*4;
    float Rx = x*100 + Uy*2 -Ux*4;
    float Ry = y*100 - Ux*2 -Uy*4;
    
    triangle(x*100,y*100,Lx,Ly,Rx,Ry);
  }
  
  void setPosition(float _x,float _y){
    x = _x;
    y = -_y;
    len = calcLength(_x,_y);
    angle = calcAngle(_x,_y);
    labelX = int(x * 100);
    labelY = int(y *100 -10);
    nlabelX = int(x * 100);
    nlabelY = int(y *100 +10);
  }
  void setLengthAndAngle(float _len,float _angle){
    len = _len;
    angle = _angle;
    calcPosition(_len,_angle);
    labelX = int(x *100);
    labelY = int(y*100 -10);
    nlabelX = int(x * 100);
    nlabelY = int(y *100 +10);
  }
  
  float calcLength(float _x,float _y){
    float _len = sqrt(sq(_x)+sq(_y));
    return _len;
  }
  float calcAngle(float _x,float _y){
    float _angle = degrees(atan(_y/_x));
    return _angle;
  }
  void calcPosition(float _len,float _angle){
    x = cos(radians(_angle)) * _len;
    y = -sin(radians(_angle)) * _len;
  }
}