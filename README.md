# SpecRA
RGB to Spectrum

This code takes RGB data collected from the LYS Button (available for purchase here: https://lystechnologies.io/sample-package/) and outputs a reconstructed spectral power distribution in W/m2/nm in 5nm intervals from 380 to 780nm. The resulting spectrum is a 1x81 dimensional vector that can be saved in any format such as .csv

The code utilizes a reference library of spectra and uses an unpublished digital-twin model of the sensor to derive a measured copy of the high-dimensional library such that M = g(L) where g is a function that models how light from the LYS Button is encoded.  We can then use the lasso regularization for generalized linear models function to find the best linear combination of measured observations in M that approximate our input (the input here is the R, G, B output of the LYS Button).

In other words we solve y = Mx where y is our tristiumus input and x is a 1-dimensional coefficient vector. This approach makes the assumption that the coefficients x would also solve the problem w = Lx where w is the true spectrum and Lx is the linear combination of full-dimensional spectral observations in our library.

citation: https://doi.org/10.3390/s22062377

While we provide the user with this specific library, other libraries can be used but note that this will require the derivation of a new measured copy M. This could be done in various ways but the most direct approach could be to use a simple neural network to learn a relationship between spectral measurements and the LYS RGB values by taking a series of measurements side-by-side. While this is an arduious proceedure it could help improve results if sufficient training data are used.

While not computed here, additional information can be extracted from the spectral data. If saved in .csv format the file can be uploaded to the free-to-use CIE validated webtool luox available here: https://luox.app/

luox is a tool developed by Prof. Manual Spitschan (Oxford/TUM) and collaborators that computes additional information from the spectral power distribution such as color and vision-related quantities.
