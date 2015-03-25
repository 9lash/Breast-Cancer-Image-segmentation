Breast-Cancer-Image-segmentation
================================

Pattern Recognition: Breast Cancer detection using Image segmentation techniques.
io.m and segmentation.m together does the segmentation of the given image and eliminates unwanted noise in an biopsy cell image. Biopsy images contain black and white tissue image of breasts affected with cancer. Each cell is an ellipse and finding features like eccentricity of these ellipses, variance of eccentricities help detect whether the tissue image belongs to the breast cancer set.

=========================================================
##This code in particular stacks up the following features: ##
<ul>
<li>Feature 1: Mean of eccentricities of ellipses
<li>Feature 2: variances of the eccentricity
<li>Feature 3: kurtosis of the eccentricity
<li>Feature 4: skewness of eccentricity
<li>Feature 5: Formation of closed chain 
</ul>
