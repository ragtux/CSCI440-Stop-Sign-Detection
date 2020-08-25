int[] getHist(PImage img)
{
  int[] hist = new int[256]; 
  
  for (int x = 0; x < img.pixels.length; x++){ // for every pixel in image
      float v = red(img.pixels[x]); // find pixel's value
      hist[(int)v]++; // increment that associated value's bin counter.
  }
  return hist;
}

PGraphics histogram(PImage img)
{
  img.loadPixels(); 
  
  int[] hist = getHist(img); 
   
  float auxmax = max(hist);
  PGraphics pg = createGraphics(img.width, img.height);
  
  pg.beginDraw();
    pg.stroke(205, 120, 20);
    for(int b = 0; b<256; b++)
    {
      pg.line(b, img.height, b, (img.height-int(hist[b]*100/auxmax)));
      println(hist[b]);
    }
  pg.endDraw();
  
  return pg;
}

void histogramEqualization(PImage i, PImage d)
{
  i.loadPixels();
  d.loadPixels();
  
  int M = i.width;
  int N = i.height;
  int K = 256; // number of intensity values

  // compute the cumulative histogram:
  int[] H = getHist(i);
  int[] cum_hist = new int[256];
  int sum = 0;
  
  for (int ix = 0; ix < H.length; ix++){
    sum += H[ix];
    cum_hist[ix] = sum; 
  }


  // equalize the image:
  for (int x = 0; x < i.pixels.length; x++){
      int a = int(blue(i.pixels[x]));
      int b = cum_hist[a] * (256 - 1) / (width * height);
      //println(b);
      d.pixels[x] = color(b);
    
  }
    
  d.updatePixels();
  
}
