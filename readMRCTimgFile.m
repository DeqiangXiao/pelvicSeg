%the infant brain images, the are three type images: T1( xx_cbq.hdr), T2
%(xx_cbq-T2.hdr), label(xx-ls-corrected.hdr)
%I convert the label images to 0,1,2,3
function readMRCTimgFile()
% % addpath('/home/dongnie/Desktop/Caffes/software/NIfTI_20140122');
% % addpath('/home/dongnie/Desktop/Caffes/software/REST_V1.9_140508/REST_V1.9_140508');
% instensity image
d1=256;
d2=256;
d3=5;
len=13;
step=1;
rate=1;
path='./';
ids=[1 2 3 4 6 7 8 10 11 12 13];
threshold=1600;
d=[d1,d2,d3];
%flipIDs=[12 13 15 16 18 20 21 22];
dirname='./';
flipdirname='./';
mrfilename='img1.mhd';
segfilename='img1_seg.mhd';

% flipmrfilename='mr1_processed_resampled_p2_cropped_processed_histmatchedp2_flip.hdr';
% flipctfilename='ct1_processed_resampled_p2_cropped_processed_flip.hdr';
%labelfilename='mask.hdr';
%ctfilename='a.hdr';
for i=1:length(ids)
    id=ids(i);
%% for original images
    currMRname=strrep(mrfilename,'1',sprintf('%d',id));
    currSegname=strrep(segfilename,'1',sprintf('%d',id));
%     ctfilename=sprintf('prostate_%dto1_CT.nii',id);
%     [ctimg cthead]=rest_ReadNiftiImage([path,ctfilename]);
%     [mrimg,info] = ReadData3D([dirname,currMRname]);
    info = mha_read_header([dirname,currMRname]);
    mrimg = single(mha_read_volume(info));
%     mrimg =single(analyze75read(info));%
    %normalize it,learned from Andrew's course, haha
    mu=mean(mrimg(:));
    maxV=max(mrimg(:));
    minV=min(mrimg(:));
    mrimg=(mrimg-mu)/(maxV-minV);
    
    info = mha_read_header([dirname,currSegname]);%%switch to your file reading code.
    segimg = single(mha_read_volume(info)); 
%     segimg= ReadData3D([dirname,currSegname]);
%     
    labelimg=segimg/10;
   

    
    cnt=cropCubic(mrimg,ctimg,labelimg,id,d,step,rate);
    
    
  
    
end
% 
% t1filename='NORMAL01_cbq.hdr';
% info = analyze75info([path,t1filename]);
% t1img = analyze75read(info);
% 
% t2filename='NORMAL01_cbq-T2.hdr';
% info = analyze75info([path,t2filename]);
% t2img = analyze75read(info);
% 
% labelfilename='NORMAL01-ls-corrected.hdr';
% info = analyze75info([path,labelfilename]);
% labelimg = analyze75read(info);

return


%crop width*height*length from mat,and stored as image
%note,matData is 3 channels, matSet is 1 channel
%d: the patch size
function cubicCnt=cropCubic(matFA,matSeg,fileID,d,step,rate)   
    eps=1e-2;
    if nargin<6
    	rate=1/4;
    end
    if nargin<5
        step=4;
    end
    if nargin<4
        d=16;
    end
    [row,col,len]=size(matFA);
%% make the size to be better by padding zeros
%     tmat=zeros(row,184,152);
%     tmat(:,1:181,1:149)=matFA;
%     matFA=tmat;
%     
%     tmat=zeros(row,184,152);
%     tmat(:,1:181,1:149)=matSeg;
%     matSeg=tmat;
      [row,col,len]=size(matFA);
    %[rowData,colData,lenData]=size(matT1);
   
    %if row~=rowData||col~=colData||len~=lenData
     %   fprintf('size of matData and matSeg is not consistent\n');
     %   exit
    %end
    cubicCnt=0;
    fid=fopen('trainPelvic_list.txt','a');

    for i=1:step:row-d(1)+1
        for j=1:step:col-d(2)+1
            for k=1:step:len-d(3)+1%there is no overlapping in the 3rd dim
                volSeg=single(matSeg(i:i+d(1)-1,j:j+d(2)-1,k:k+d(3)-1));
%                 if sum(volSeg(:))<eps%all zero submat
%                     continue;
%                 end
                cubicCnt=cubicCnt+1;
                volFA=single(matFA(i:i+d(1)-1,j:j+d(2)-1,k:k+d(3)-1));
                %% for 3D data
                trainFA(:,:,:,1,cubicCnt)=volFA;
                trainSeg(:,:,:,1,cubicCnt)=volSeg;       
                %% for 2d dataset
%                 trainFA(:,:,1,cubicCnt)=squeeze(volFA);
%                 trainSeg(:,:,1,cubicCnt)=squeeze(volSeg);    
            end
        end
    end
     trainFA=single(trainFA);
     trainSeg=int8(trainSeg);
     h5create(sprintf('train_%s.hdf5',fileID),'/dataMR',size(trainFA),'Datatype','single');
     h5write(sprintf('train_%s.hdf5',fileID),'/dataMR',trainFA);
     h5create(sprintf('train_%s.hdf5',fileID),'/dataSeg',size(trainSeg),'Datatype','int8');
     h5write(sprintf('train_%s.hdf5',fileID),'/dataSeg',trainSeg);
     clear trainFA;
     clear trainSeg;
     fprintf(fid,sprintf('train_%s.hdf5\n',fileID));	
     fclose(fid);
return
