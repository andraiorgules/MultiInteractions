import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


Minim minim;
AudioInput mic;
FFT fft;
int w; 

void setup() 
{
  
 size(800, 800); 
 background(0);
   
  minim = new Minim(this);
  
  //get audio input from mic
  mic = minim.getLineIn(Minim.MONO, 4096, 44100); 
  
  fft = new FFT(mic.bufferSize(), mic.sampleRate()); 
  fft.logAverages(60,7);
 
 //for making bars instead of lines
  stroke(255); 
  w = width/fft.avgSize();
  strokeWeight(w); 
 
}


void draw() 
{
  
//so background can update and not have left over marks from the bars or circle
  background(0);
  
//for drawing sound bars based on mic input
  fft.forward(mic.mix); 

  for (int i = 0; i < fft.avgSize(); i++) 
  {
    line ((i*w)+(w/2), height, (i*w)+(w/2), height - fft.getAvg(i)*4); 
  }
  
  
//for circle controlled by mouse
  ellipse(mouseX, mouseY, 40, 40);
//mouse to the left makes the circle purple
  if (mouseX <= 317)
  {
    fill (150, 0, 150);
  }
//mouse to the right makes circle yellow  
  if (mouseX >= 318 && mouseY < 400)
  {
    fill (255, 255, 0);
  }
  
//mouse to bottom makes circle orange 
if (mouseY >= 700 && mouseX > 0 )
{
  fill (255, 165, 0);
}

//mouse to top makes circle pink
if (mouseY < 100 && mouseX > 0)
{
  fill (255, 31, 150);
}
  
  //println(mouseX, mouseY, ix, iy);
  
  
//add another visual representation that is changed by audio 
  
  
}

//change the background color when a key is pressed
void keyPressed()
{
  
  //blue
  if (key == '1')
  {
    background(0, 0, 255);
  }
  
  //green
  if (key == '2')
  {
    background(0, 255, 0);
  }
  
  //red
  if (key == '3')
  {
    background(255, 0, 0);
  }
  
}
