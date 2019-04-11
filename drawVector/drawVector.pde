
Vector v[];
Angle a[];

float mousex,mousey;
float Scale = 1;

void setup (){
  size(500,500);
  background(255);
  textAlign(CENTER);
  textSize(5);
  frameRate(120);
  
  String csvVectorDataLine[] = loadStrings("vector.csv");
  
  v = new Vector[csvVectorDataLine.length];
  
  float maxLength = 0;
  for(int i = 0;i < csvVectorDataLine.length;i++){

    String colum[] = split(csvVectorDataLine[i],',');
    
    v[i] = new Vector(colum[0],i);
    if(colum[3] .equals("la")){
      v[i].setLengthAndAngle(float(colum[1]),float(colum[2]));
    }
    else
      v[i].setPosition(float(colum[1]),float(colum[2]));
    
    if(maxLength < v[i].len )maxLength = v[i].len;
  }
  for(int i = 0;i < csvVectorDataLine.length;i++)
    v[i].Scale = 250 / maxLength ;
  String csvAngleDataLine[] = loadStrings("angle.csv");
  
  a = new Angle[csvAngleDataLine.length];

  for(int i = 0;i < csvAngleDataLine.length;i++){

    String colum[] = split(csvAngleDataLine[i],',');

    a[i] = new Angle(v[int(colum[0])].angle,v[int(colum[1])].angle);

  }

}
int c = 0;
int lx=0,ly=0;
void draw(){
  mousex = (mouseX - width/2) ;
  mousey = (mouseY - height/2);
  background(255);
  c = 1;
  setupAxis();
  scale(Scale);
  
  for(int i = 0;i < v.length;i++){
    v[i].drawVector();
    textSize(15);
  }
  
  noFill();
  
  for(int i = 0;i < a.length;i++)
    a[i].drawAngle();
  
}

void setupAxis(){
  strokeWeight(1);
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
    int r = 25 + 30 * c;
    
     arc(0,0,r,r,-radians(angle2),-radians(angle1)); 
     c++;
     
     float diff = notbase - base;
     
     text(diff + "°",labelX,labelY);
     
     if(mousePressed){
     if(mousex> labelX - 10 && mousex< labelX + 10 && mousey> labelY - 10 && mousey< labelY + 10){
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
  float Scale = 1;
  int num;
  Vector(String _name,int _num){
    num = _num;
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
    
    strokeWeight(2);
    line(0,0,x*Scale,y*Scale);
    drawArraw();
    fill(0);
    textSize(15);
    text(len,labelX,labelY);
    text(name,nlabelX,nlabelY);
    if(mousePressed){
     if(mousex> labelX - 10 && mousex< labelX + 10 && mousey> labelY - 10 && mousey< labelY + 10){
       labelX = int(mousex);
       labelY = int(mousey);
     }
    }
    if(mousePressed){
     if(mousex> nlabelX - 10 && mousex< nlabelX + 10 && mousey> nlabelY - 10 && mousey< nlabelY + 10){
       nlabelX = int(mousex);
       nlabelY = int(mousey);
     }
    }
  }
  void drawArraw(){
     fill(0);
    float Vx = x*Scale;
    float Vy = y*Scale;
    float Ux = Vx/(len*Scale);
    float Uy = Vy/(len*Scale);
    float Lux = -Uy;
    float Luy = Ux;
    float Rux = Uy;
    float Ruy = -Ux;
    float Nux = -Ux;
    float Nuy = -Uy;
    
    float Lx = x*Scale - Uy*5 -Ux*10;
    float Ly = y*Scale + Ux*5 -Uy*10;
    float Rx = x*Scale + Uy*5 -Ux*10;
    float Ry = y*Scale - Ux*5 -Uy*10;
    
    triangle(x*Scale,y*Scale,Lx,Ly,Rx,Ry);
  }
  
  void setPosition(float _x,float _y){
    x = _x;
    y = -_y;
    len = calcLength(_x,_y);
    angle = calcAngle(_x,_y);
    labelX = -150;
    labelY =  -220 + 20*num;
    nlabelX = -220;
    nlabelY =  -220 + 20*num;
  }
  void setLengthAndAngle(float _len,float _angle){
    len = _len;
    angle = _angle;
    calcPosition(_len,_angle);
    labelX = -150;
    labelY =  -220 + 20*num;
    nlabelX = -220;
    nlabelY =  -220 + 20*num;
  }
  
  float calcLength(float _x,float _y){
    float _len = sqrt(sq(_x)+sq(_y));
    return _len;
  }
  float calcAngle(float _x,float _y){
    float _angle = degrees(atan(_y/_x));
    
    if(_x < 0 &&_y >0) _angle+=90;
    else if(_x < 0 && _y <= 0) _angle+=180;
    else if(_x >= 0&&_y <= 0) _angle+=270;
    
    
    
    return _angle;
  }
  void calcPosition(float _len,float _angle){
    x = cos(radians(_angle)) * _len;
    y = -sin(radians(_angle)) * _len;
  }
}

void keyPressed() {

  // Pのキーが入力された時に保存
  if(key == ' ') {

    // デスクトップのパスを取得
    String path  = year()+month()+day()+hour()+minute()+second()+millis() + ".jpg";

    // 保存
    save(path);

  }
}
