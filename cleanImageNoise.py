'''
if a image (e.g., segmentation maps) is composed of several components, but there are some noise, which are in form of isolated components
we can then remove the extra noise with following codes. 
I stored it into my bitbucket. 1/8/2017
Dong Nie
12/17/2016
'''



def main():
    path='~/Desktop/Caffes/caffe/python/pelvicSeg/'
    saveto='~/Desktop/Caffes/caffe/python/pelvicSeg/'
    caffeApp=0
    fileIDs=[1,2,3,4,6,7,8,10,11,12,13]
    #fileIDs=[1]
    for ind in fileIDs:
        datafilename='preSub%d_5x168x112.nii'%ind #provide a sample name of your filename of data here
        datafn=os.path.join(path,datafilename)
        labelfilename='gt%d.nii'%ind  # provide a sample name of your filename of ground truth here
        labelfn=os.path.join(path,labelfilename)
        prefilename='preSub%d_denoised.nii'%ind #provide a sample name of your filename of data here
        prefn=os.path.join(path,prefilename)

        imgOrg=sitk.ReadImage(datafn)
        mrimg=sitk.GetArrayFromImage(imgOrg)
        labelOrg=sitk.ReadImage(labelfn)
        labelimg=sitk.GetArrayFromImage(labelOrg) 
        # Run function on sample array
        #filtered_array = filter_isolated_cells(mrimg, struct=np.ones((3,3,3)))        
        filtered_array = denoiseImg(mrimg, struct=np.ones((3,3,3)))        
        # Plot output, with all isolated single cells removed
        #plt.imshow(filtered_array, cmap=plt.cm.gray, interpolation='nearest')
        pr0=dice(labelimg,filtered_array,0)
        pr1=dice(labelimg,filtered_array,1)
        pr2=dice(labelimg,filtered_array,2)
        pr3=dice(labelimg,filtered_array,3)
        print 'dice for sub%d: '%ind,pr0, ' ',pr1,' ',pr2,' ',pr3
        preVol=sitk.GetImageFromArray(filtered_array)
        sitk.WriteImage(preVol,prefn)
if __name__ == '__main__':     
    main()
