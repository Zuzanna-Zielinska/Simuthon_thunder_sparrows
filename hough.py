import cv2
import numpy as np
import matplotlib.pyplot as plt
import os

def fun(photo:str,Rtable:list):
    img2 = cv2.imread(photo)
    img_gray2 = cv2.cvtColor(img2, cv2.COLOR_BGR2Lab)[:,:,2]

    sobelx2= cv2.Sobel(img_gray2, cv2.CV_64F, 1, 0, ksize=5)
    sobely2= cv2.Sobel(img_gray2, cv2.CV_64F, 0, 1, ksize=5)
    amplitude2= np.sqrt(sobelx2**2 + sobely2**2)
    amplitude2= amplitude2/np.max(amplitude2)
    orientation2= np.arctan2(sobely2, sobelx2)

    accumulator = np.zeros(img_gray2.shape, dtype=np.uint8)

    for y in range(img2.shape[0]):
        for x in range(img2.shape[1]):
            if amplitude2[y,x] > 0.5:
                angle = int(np.rad2deg(orientation2[y,x]))
                for r, fi in Rtable[angle]:
                    x1 = -r*np.cos(np.deg2rad(fi)) + x
                    y1 = -r*np.sin(np.deg2rad(fi)) + y
                    if 0 <= x1 < img2.shape[1] and 0 <= y1 < img2.shape[0]:
                        accumulator[int(y1), int(x1)] += 1

    index= np.where(accumulator.max() == accumulator)
    cv2.circle(img2,(int(index[1][0]),int(index[0][0])),70,(0,0,255))
    cv2.imshow('edges', img2)
    cv2.waitKey(0)


def zad1():
    img = cv2.imread("cutim\cimg000001.png")
    img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2Lab)[:,:,2]
    im_bin= (img_gray>150).astype(np.uint8)*255

    moments= cv2.moments(im_bin, 1)
    m00= moments['m00']
    m10= moments['m10']
    m01= moments['m01']
    px= int(m10/m00)
    py= int(m01/m00)


    contours, hierarchy = cv2.findContours(im_bin, cv2.RETR_TREE, cv2.CHAIN_APPROX_NONE)
    contour= contours[0]

    sobelx= cv2.Sobel(img_gray, cv2.CV_64F, 1, 0, ksize=5)
    
    sobely= cv2.Sobel(img_gray, cv2.CV_64F, 0, 1, ksize=5)
    amplitude= np.sqrt(sobelx**2 + sobely**2)
    amplitude= amplitude/np.max(amplitude)
    orientation= np.arctan2(sobely, sobelx)
    Rtable = [[] for _ in range(360)]
    for c in contour:
        x, y = c[0]
        distance= np.sqrt((x-px)**2 + (y-py)**2)
        angle = int(np.rad2deg(np.arctan2(y-py, x-px)))
        Rtable[int(np.rad2deg(orientation[y,x]))].append((distance, angle))

    # os.chdir("cutim")
    # for file in os.listdir():
    #     if file.endswith('.png'):   
    #         fun(file,Rtable)
    
    cv2.destroyAllWindows()

zad1()




