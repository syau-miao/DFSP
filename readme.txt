This project is the source code of our paper "DFSP: A fast and automatic distance field-based stem-leaf segmentation pipeline for point cloud of maize shoot".
Wang D, Song Z, Miao T, Zhu C, Yang X,Yang T, Zhou Y, Den H and Xu T (2023)DFSP: A fast and automatic distance field-based stem-leaf segmentation pipeline forpoint cloud of maize shoot.Front. Plant Sci. 14:1109314.doi: 10.3389/fpls.2023.1109314
 

1.The code was developed in matlab2017a and tested only on this version.

2.How to run stem and leaf segmentation code.
1)Run SL_Segmentation.m.
2)Variables in the 'Parameters' structure can be modified to process different data.
3)The code will automatically save the segmentation result as a "ply" file with the prefix "seg".
4)If you don't want to see the visualization diagram, you can set the third parameter of the 'sl_seg' function to 'false'.

3.How to run downsample code.
1)Run Down_Sample.m
2)You can set the 'grid' parameter. The larger this parameter is, the fewer points will be obtained from the first downsampling.
3)All the '15000' numbers can be changed to any number to obtain the downsampling result of any number of points.

Should you have any questions, comments, or suggestions, please contact us at miaoteng@syau.edu.cn
