PImage id01;
PImage id02;
PImage id03;
PImage id04;
PImage id05;
PImage id06;
int xc;

void setup(){
  int xc = 0;
  surface.setResizable(true);
  size(840, 547);
  
  id01 = loadImage("rabbit2.jpg");
  id02 = new PImage(id01.width, id01.height); 
  id03 = new PImage(id01.width, id01.height);
  id04 = new PImage(id01.width, id01.height);
  id05 = new PImage(id01.width, id01.height);
  id06 = new PImage(id01.width, id01.height);
  
  surface.setSize(id01.width,id01.height);
 // noLoop();
}

void draw() 
{
  background(50);
  float a =  5f * (mouseX / (float)width); 
  float b = 65f * (mouseY / (float)width); 
  
  
  if(xc < 1)
  {
    id01.filter(BLUR, 3);
    xc++;
  }
  else
  {
  
    dither(id01);
    //int[] hist = new int[256]; 
    // (1) histogram equalization
    //histogramEqualization(id01, id02);
    // (2) Gaussian blur 
    //blur(id01, id03);
    
    // (3) toggle contrast against variable threshold
    //contrast(id01, id04, b);
   
    //id03.filter(BLUR, 2);
    //(4) find edges 
    //processEdges(id01, id06);
    //contrast(id04, id05, 2);
    //id02.filter(POSTERIZE, 3);
    //println("a:",a,"b:",b);
    //sobel(id01,id06);
    image(id01, 0, 0); 
  }
  //display the image
  //noLoop();
}

// example 15-12 PixelNeighborEdge, Daniel Shiffman
void processEdges(PImage source, PImage destination)
{
   // We are going to look at both image's pixels
  source.loadPixels();
  destination.loadPixels();
  
  // Since we are looking at left neighbors
  // We skip the first column
  for (int x = 1; x < width; x++ ) {
    for (int y = 0; y < height; y++ ) {
      
      // Pixel location and color
      int loc = x + y*source.width;
      color pix = source.pixels[loc];
      
      // Pixel to the left location and color
      int leftLoc = (x - 1) + y*source.width;
      color leftPix = source.pixels[leftLoc];
      
      float diff = abs(brightness(pix) - brightness(leftPix));
      destination.pixels[loc] = color(diff); 
    }
  }
  
  destination.updatePixels();
  //image(destination,0,0);
}

void contrast(PImage source, PImage destination, float threshold)
{
  source.loadPixels();
  destination.loadPixels();
  
  for (int x = 0; x < source.width; x++) 
  {
    for (int y = 0; y < source.height; y++)
    {
      int loc = x + y*source.width;
      // Test the brightness against the threshold
      if (brightness(source.pixels[loc]) > threshold*6)
        destination.pixels[loc] = color(255); // White
      else 
        destination.pixels[loc] = color(0); // Black
    }
  }
 
  destination.updatePixels();
  //image(destination, 0, 0);
}
