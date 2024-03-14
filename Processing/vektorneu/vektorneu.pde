float Input1=0.0;
float Input2=0.0;
float Input3=0.0;
float Input4=0.0;
float Input5=0.0;
float Input6=0.0;


float Parameter1 = 9.0;
float Parameter2 = 2.0;
float Parameter3 = 7.0;
float Parameter4 = 7.0;
float Parameter5 = 0.03;
float Parameter7 = 9.0;



import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;



void setup(){
  size(600,600,P2D);
  noStroke();
  smooth();
  oscP5 = new OscP5(this,12000);
  dest = new NetAddress("127.0.0.1",6448);


}

void draw(){
  

  
  background(0);
  stroke(255);
  noFill();
  

  

 Parameter1 += Parameter7;
 
  for(float x =0; x <height; x+=Parameter2){
    for(float y= 0; y<height; y+= Parameter2){
      PVector f = getFlow(x,y);
       line(x,y,x+f.x,y+f.y);
    }
  }
  
  for(float y=Parameter2; y<width; y+=Parameter2){
    PVector p = new PVector(0, y);
    PVector v = new PVector (0,y);
    
       for (int i =0; i< width; i++){
         float oldx = p.x;
         float oldy= p.y;

         p.x += v.x;
         p.y += v.y;
         
         line(oldx, oldy , p.x, p.y);
       }
    }
  }
  
  
  PVector getFlow(float x, float y){
    float angle = noise(x/height + Parameter1, y/width) *Parameter3 *Parameter4;
    return PVector.fromAngle(angle*Parameter7).setMag(Parameter5);
  }
  
 void ScaleParameters(){
        
        Parameter1 = map(Input1,0,1,0.01,1);
        Parameter2 = map(Input2,0,1,0,20);
        Parameter3 = map(Input3,0,1,0,10);
        Parameter4 = map(Input4,0,1,0,10);
        Parameter5 = map(Input5,0,1,0,10);
        Parameter7 = map(Input6,0,1,0,10);
  
        
        
}


void oscEvent(OscMessage theOscMessage){
  if(theOscMessage.checkAddrPattern("/wek/outputs")==true){
    if(theOscMessage.checkTypetag("ffffff")){
      
      Input1 = theOscMessage.get(0).floatValue();
      Input2 = theOscMessage.get(1).floatValue();
      Input3 = theOscMessage.get(2).floatValue();
      Input4 = theOscMessage.get(3).floatValue();
      Input5 = theOscMessage.get(4).floatValue();
      Input6 = theOscMessage.get(5).floatValue();
      println("Received new params value from Wekinator");
      ScaleParameters();
    }
    else {
      println("error:unexpected params type tag received by processing");
    }
  }
}
