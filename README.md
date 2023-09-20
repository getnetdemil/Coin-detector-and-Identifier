
Problem formulation

You have to write a custom coin detector and identifier program that can work on different images with very good confidence.

**Input:**  an image showing HUF and EUR coins and other stuff **Output:**  figures and console output (total amount for each currency)

Tasks to do

Write a script that…

1. loads the sample image into a variable,
1. applies histogram operations (e.g. stretching) to enhance quality
1. applies thresholding in color spaces to get a binary mask of objects
1. applies a coin detecting conv. kernel to find the round objects only
1. crops the round objects from the image one-by-one
1. decides for each round object whether it is a coin or not
1. if the object is a coin, quantize its value based on color and diameter
1. sums up the coin values for all the coins
1. returns the two summed values (Forint and Euro separately).

Key results to be presented:

You may code freely, as there are no restrictions on what functions, variable names and processing flow to use.

However, please create the following outputs:

1. **Figure 1** should show the original and binary image side-by-side
1. **Figure 2** should show the result of the convolution
1. **Figure 3** should show the cropped round objects, and for each subfigure the title says whether the object is a coin or not
1. **Figure 4** should show a similar image to Fig. 3 but with the coins only, showing their determined value
1. The answer (total amount) should be displayed on the **console**


Figure 7

![](Aspose.Words.e1974aeb-1851-4b90-8c14-fff76b1aa017.001.jpeg)


Figure 3

![](Aspose.Words.e1974aeb-1851-4b90-8c14-fff76b1aa017.002.png)


Figure 4

![](Aspose.Words.e1974aeb-1851-4b90-8c14-fff76b1aa017.003.png)



The console output:

![](Aspose.Words.e1974aeb-1851-4b90-8c14-fff76b1aa017.004.png)



There is no code package for this assignment.

All scripts and functions must be written entirely by you.

Download the image to be processed from here:

<https://beta.dev.itk.ppke.hu/bipa/assignment_01> 



Submission & hints

You should create a script named a01\_NEPTUN.m where the NEPTUN part is your Neptun ID. This has to be the main script; running that must be able to solve the problem.

You are allowed to create other files (e.g. additional functions) too, if necessary.

Please submit ALL files (including the image as well) in a compressed **ZIP** file via the Moodle system.

**Check the upcoming slides for hints!**


Hint 1

Stretch the histogram of the image to the full dynamic range. Use thresholding on separate color channels and combine the results (with logical operations) to get a decent mask.

A mask with large white areas in non-coin objects will cause problems.

Aim for a mask that is white in the coin regions but has “holes” in the unwanted parts.

If the mask is “noisy” (small white dots) it’s not a problem, the convolution will deal with it.


Hint 2

The “coin-detection kernel” should be a round kernel with a diameter comparable to the smallest coin. ![](Aspose.Words.e1974aeb-1851-4b90-8c14-fff76b1aa017.005.png)

Something like this will do: 

(The size of a good kernel might be different in your case.) 

Use the MATLAB’s built-in kernel generator function to obtain such matrix.


Hint 4

Cropping the objects may sound hard but it isn’t.

Define a window size that is large enough to contain the whole coin.

Find the location of the maximum in the convolved image, and crop the window-sized area around the same spot in the original, color image.

Modify the result of the convolution; replace every value inside the window with 0. This will destroy the now-found maximum and the next iteration will find the next max value, possibly a new coin for which the kernel shows significant activation.

Stop the loop when the value of the maximum is not significant anymore.


Hint 6

The histogram of the cropped color image can be useful to decide whether it’s a coin or not. Use the total number of pixels in the “interesting” regions; 

E.g. if an image has 50% of its pixels between 0 and 20 intensity => coin.

(The values are not accurate in this example; it’s just here to illustrate the idea.)

![](Aspose.Words.e1974aeb-1851-4b90-8c14-fff76b1aa017.006.jpeg) 16


Hint 7

You have to build a so-called “look-up-table” in which you store the coin diameters associated with their values.

Create it manually by measuring the diameters of the coins in the original image. Allow some error margin. The result should be a set of boundary values and an associated value belonging to that interval of diameters.

E.g. (not real values, just an example!)

If 152 < d < 160  then   5 Ft If 165 < d < 178 then  10 Ft If  190 < d < 200 then 20 Ft etc....


Hint 8

It might also be beneficial to include color info in the look-up-table as well: E.g. (not some real values, just an example!)

If 152 < d < 160  AND  red > 200 then   2 cent If 152 < d < 160  AND  red < 170 then   5 Ft etc...


Hint 9

Use the diameter and color of the coin to get its value. Consider the line of pixels along the center of the window (both horizontally and vertically). Try to detect the huge jump in the pixel value; find the location of these points and calculate the distance between them. This is the diameter of the coin. Compare the diameters along the two axes; they should be very close to each other in value. Check the color of the coin within this interval too!

19![](Aspose.Words.e1974aeb-1851-4b90-8c14-fff76b1aa017.007.png)

