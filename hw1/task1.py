import cv2
import numpy as np

MAX_AREA = 5000

def main():
	img = cv2.imread('tool.png',0)
	newImage = np.zeros((img.shape[0],img.shape[1],3), np.uint8)

	ret,thresh = cv2.threshold(img,127,255,cv2.THRESH_BINARY)
	contours, hierarchy = cv2.findContours(thresh,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)

	for i in range(0, len(contours)):
	    area = cv2.contourArea(contours[i])
	    print type(contours[i]).__name__
	    if (area < MAX_AREA):
	        print area
	        cv2.drawContours(newImage, contours, i, (0,0,255), 1)
	        getOrientation(contours[i], img)

	showImg(img)

def getOrientation(contours, img):
	array = contours.flatten()
	cv2.calcCovarMatrix(array,cv2.cv.CV_COVAR_SCALE|cv2.cv.CV_COVAR_ROWS)

def showImg(img):
	cv2.imshow('image',img)
	cv2.waitKey(0)
	cv2.destroyAllWindows()

main()
"""
1.Mean
2.X-X_
3.Cov
4.Eigen calc
5.Sort eigen

"""

