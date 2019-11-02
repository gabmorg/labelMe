# `labelMe`

&nbsp;

###### [Gabriela Morgenshtern](https://orcid.org/0000-0003-4762-8797),Department of Cells and System Biology, University of Toronto, Canada. &lt;g.morgenshtern@mail.utoronto.ca&gt;


<!-- TOCbelow -->
1. About this package:<br/>
&nbsp;&nbsp;&nbsp;&nbsp;1.1. Overview <br/>
&nbsp;&nbsp;&nbsp;&nbsp;1.2. Installation <br/>
2. Notes<br/>
&nbsp;&nbsp;&nbsp;&nbsp;2.1 To test functionality <br/>
&nbsp;&nbsp;&nbsp;&nbsp;2.2 To use during workshop <br/>
3. Acknowledgements<br/>
<!-- TOCabove -->

----


# 1 About this package:

## 1.1 Overview
`labelMe` is a package allowing clinicians and developers with test image data that requires manual labeling (ex. ultrasounds) to easily spin up a local web application to do so, ensuring data privacy while enabling the interactive convenience of the browser as a platform for this task. This is particularly useful to those who work with image-recognition algorithms.

![](./inst/extdata/MORGENSHTERN_G_A1.png)

&nbsp;

## 1.2 Installation

**Organize your imaging files in a single directory, or group them into several easily-accessible directories. Then, install the package, use its functions to set your desired labels, and run your webapp locally!**

```
require("devtools")
devtools::install_github("gabmorg/labelme-goldenberg")
library("labelMe")
```

----

# 2 Notes 

## 2.1 To test functionality
1. Save the following images to your local machine:
![](./inst/extdata/pt1234_12.jpg)
![](./inst/extdata/pt_1234_11.jpg)

2. Call ```labelMe::serveMe(list("test label1", "test label2"))``` to launch the test app (replacing the strings with whatever labels you'd like to apply to the images)

## 2.2 To use during workshop
1. Note where images for labeling are located on your local machine

2. Call ```labelMe::startLabelingGoldenberg()``` in an R session to launch the app (within RStudio or Terminal) 

3. Upload the files to the Shiny app using the file browser on the right-hand panel; this will change the label of the *radio button groups* to the name of the uploaded files
- Please note that multiple file upload is not currently supported by the RStudio Viewer, and the app *must be opened in browser* to function. 
- Use ```CTRL + A``` to select all the images in a directory for batch upload

4. Select one option in each column of the radio buttons, according to the image presented on the screen
- Your selected choices are textually summarized below the radio group

5. Press the **<-** and **->** buttons on your keyboard to navigate between images

6. Click the ```"Download DATE-labels.csv"``` button to download the CSV to your local machine. 
- **If using a lab computer**, please create a folder in your *Desktop using your first name*, and save CSVs in there

7. Click ```"flush data"``` to remove labeled images from the (local) server 

8. Repeat steps 3-7 as needed until all images are labeled

&nbsp;

----

# 3 Contributions

The author of this package is Gabriela Morgenshtern. The functions available within this package include:
```
library("labelMe")
lsf.str("package:labelMe")
```
- serveMe : function (labelingList) 
- startLabelingGoldenberg : function () 

The above functions, and the helper functions involved in running it were authored by Gabriela Morgenshtern, using the Shiny R package, and with help structuring the app from the Shiny tutorial found on steps 1-6 here: (https://shiny.rstudio.com/tutorial/)

Thanks to Dr. Boris Steipe for providing the skeleton setup for this package through his own template (https://github.com/hyginn/rpt). Code for testing Shiny app was borrowed from a Shinytest tutorial by Ferand Dalatieh; specific examples of his contribution are denoted in the code. Starter code for the logic pertaining to pagination of images and radio buttons was found from Stéphane Laurent (https://stackoverflow.com/questions/57891201/render-images-for-interactive-display-from-folder-loaded-with-shinydirchoose)

The rest of the contributions are made by Gabriela.



&nbsp;

<!-- END -->
