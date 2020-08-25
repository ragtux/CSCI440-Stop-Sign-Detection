void sharpen(PImage img, PImage xx)
{
    for (int x = 0; x < img.width; x++) {
      for (int y = 0; y < img.height; y++) {
        // Each pixel location (x,y) gets passed into a function called convolution()
        // The convolution() function returns a new color to be displayed.
        color c = convolution(img,x,y); 
        int loc = x + y*img.width;
        xx.pixels[loc] = c;
      }
     }
     updatePixels();
}


color convolution(PImage img, int x, int y) 
{
  float[][] matrix = { { -1, -1, -1 },
                       { -1,  9, -1 },
                       { -1, -1, -1 } };
  
  //float[][] matrix = { { -1/9, -1/9, -1/9 },
  //                     { -1/9,  8/9, -1/9 },
  //                     { -1/9, -1/9, -1/9 } };
  int matrixsize = 3;
  
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  // Loop through convolution matrix
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      int xloc = x + i - offset;
      int yloc = y + j - offset;
      int loc = xloc + img.width * yloc;
      // Make sure we have not walked off the edge of the pixel array
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      // We sum all the neighboring pixels multiplied by the values in the convolution matrix.
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal,0,255);
  gtotal = constrain(gtotal,0,255);
  btotal = constrain(btotal,0,255);
  
  // Return the resulting color
  
  return color(rtotal,gtotal,btotal);
}


void blur(PImage img, PImage xx)
{
  float v = 1.0/9.0;
  float[][] kernel = {{ v, v, v }, 
                      { v, v, v }, 
                      { v, v, v }};                     
  
  img.loadPixels(); 
  
  // Create an opaque image of the same size as the original
  // Loop through every pixel in the image
  for (int y = 1; y < img.height-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < img.width-1; x++) {  // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*img.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = red(img.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      xx.pixels[y*img.width + x] = color(sum);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  xx.updatePixels();
}
