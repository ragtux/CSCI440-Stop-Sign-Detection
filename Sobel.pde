void sobel(PImage img,PImage xx) 
{
        int[][] filter1 = {
            { -1,  0,  1 },
            { -2,  0,  2 },
            { -1,  0,  1 }
        };

        int[][] filter2 = {
            {  1,  2,  1 },
            {  0,  0,  0 },
            { -1, -2, -1 }
        };
        
        img.loadPixels();
        
        for (int y = 1; y < img.height - 1; y++) 
        {
            for (int x = 1; x < img.width - 1; x++) 
            {
                // get 3-by-3 array of colors in neighborhood
                int[][] gray = new int[3][3];
                for (int i = 0; i < 3; i++) {
                    for (int j = 0; j < 3; j++) {
                        gray[i][j] = (int)img.get(x-1+i, y-1+j);
                    }
                }
                // apply filter
                int gray1 = 0, gray2 = 0;
                for (int i = 0; i < 3; i++) {
                    for (int j = 0; j < 3; j++) {
                        gray1 += gray[i][j] * filter1[i][j];
                        gray2 += gray[i][j] * filter2[i][j];
                    }
                }
                int magnitude = 255 - floor(abs(gray1) + abs(gray2));
                //int magnitude = 255 - constrain((int) sqrt(gray1*gray1 + gray2*gray2),0,255);
                color grayscale = color(magnitude, magnitude, magnitude);
                xx.set(x, y, grayscale);
            }
        }
        
        xx.updatePixels();
}
