
 clear all;
% *************************************************************************
% this Program is used for prepare the training data input and output
% *************************************************************************
%======================================Expirement 31 ====================================================================%
%==========================================================================%
javaaddpath('C:\Master\Weka-3-6\weka.jar');
import weka.core.*;
import weka.classifiers.*;
import weka.classifiers.Classifier.*;
import weka.classifiers.functions.*;
import weka.classifiers.Evaluation.*;
import weka.filters.supervised.*;
import weka.core.converters.*;
  
%==========================================================================
%==========================================================================
%==========================================================================
competitionTest_features=zeros('single');
load 'C:\master\sub1_comp.mat'
load 'C:\master\sub1_testlabels.mat'
parms.movingwin = [0.5 0.05];
%==========================================================================
%                                 Prepare By EEGLAB
%==========================================================================
%==========================================================================%
noOfChannels=62;%48;  %62  ,64
selectedchannel=noOfChannels;
channels=selectedchannel;
%=========================Labeling the output data ======================================%
 
 
%====================================================================%
%===============================Finger1====================================%
finger_index=2;
[ Mixedlabel1] = labelData_ActiveIdle(train_data,train_dg,finger_index);
[ Mixedlabel2] = labelData_ActiveIdle(test_data,test_dg,finger_index);
 
Mixedlabel1_sampled=downsample(Mixedlabel1,2);
Mixedlabel2_sampled=downsample(Mixedlabel2,2);

train_11=Mixedlabel1_sampled(:,1:62);
test_11=Mixedlabel2_sampled(:,1:62);

train_labels_11=Mixedlabel1_sampled(:,63);
test_labels_11=Mixedlabel2_sampled(:,63);

clear Mixedlabel1;
clear Mixedlabel2;
[x1 y1]=size(train_11);
[x2 y2]=size(test_11);
 
train_data_Sampled_nonfluctuated=locdetrend(train_11,500,parms.movingwin);
test_data_Sampled_nonfluctuated=locdetrend(test_11,500,parms.movingwin);
 
%==================== Remove noise line ====================%
train_data_Sampled_nonfluctuated1=rmlinesc(double(train_data_Sampled_nonfluctuated),parms);
test_data_Sampled_nonfluctuated1=rmlinesc(double(test_data_Sampled_nonfluctuated),parms);


%=======================Band Pass Filter==================================%
%========================================================================%
filtered_data_sampled= eegfilt(train_data_Sampled_nonfluctuated1',500,7,175);
filtered_data_sampled_ref=reref(filtered_data_sampled);
 
filtered_testdata_sampled= eegfilt(test_data_Sampled_nonfluctuated1',500,7,175);
filtered_testdata_sampled_ref=reref(filtered_testdata_sampled);
 
%====================================================================%
%=====================Wavelet analysis===============================================%
%========================================================================================%
featurelist1=undecimatedwavelettree(filtered_data_sampled_ref,noOfChannels,512);
featurelist2=undecimatedwavelettree(filtered_testdata_sampled_ref,noOfChannels,512);
%%=====================Feature Extracting ===============================================%
%========================================================================================%
[f_indexa1 f_instance1]=size(featurelist1);
[f_indexa2 f_instance2]=size(featurelist2);
 
 [totalresult1,totalresult2,totalresult3,totalresult4,totalresult5] = getWindowMtSpectrum(featurelist1',512,f_indexa1);
 [testtotalresult1,testtotalresult2,testtotalresult3,testtotalresult4,testtotalresult5] = getWindowMtSpectrum(featurelist2',512,f_indexa2);
  Ampfeatures =  getWindowAmplitude(featurelist1',512,f_indexa1);
  testAmpfeatures =  getWindowAmplitude(featurelist2',512,f_indexa2);
  
                                                                                                                   
%===================================================================================
%===================================================================================
[xx1 yy1]=size(totalresult1);
[xx2 yy2]=size(testtotalresult1);


tot1=horzcat(Ampfeatures,totalresult1,totalresult2,totalresult3,totalresult4,totalresult5);
tot2=horzcat(testAmpfeatures,testtotalresult1,testtotalresult2,testtotalresult3,testtotalresult4,testtotalresult5);


traindata=horzcat(10*log10(abs(tot1(1:xx1,:))),train_labels_11(1:xx1,1));
testdata=horzcat(10*log10(abs(tot2(1:xx2,:))),test_labels_11(1:xx2,1));
 
[xx yy]=size(traindata);
[xx_test yy_test]=size(testdata);
traindata=replaceMInfWithzero(traindata);
testdata=replaceMInfWithzero(testdata);

  idx = gram_schmidt(traindata(1:xx,1:yy-1), traindata(1:xx,yy), 300);
  idx=[1058 4866 4934 5272 6223 5271 1704 1602 2112 550 4017 1744 664 5170 1657 1553 5230 1644 5905 5970 2201 1409 574 5988 703 4349 927 3208 73 3479 4337 4460 5324 2636 3306 4664 1827 5003 1268 6027 2746 1916 2474 3482 6008 978 3555 5416 4002 4405 5815 4951 3374 1469 2999 5111 107 3106 1811 3070 3732 4091 148 1366 2205 689 5794 3125 2762 528 1931 4409 4864 5571 2570 5145 5464 189 1076 2591 4975 2869 4766 395 3183 2022 3896 1529 2541 5745 1523 3203 1695 5538 4445 5368 379 2883 5039 185 5133 5694 803 5590 502 5247 5119 4103 6310 4559 3783 4805 2555 122 2337 6021 2181 2100 5106 2182 3375 1231 4225 5985 41 6046 149 2727 22 3554 4477 5900 4430 5567 733 3267 4053 143 1739 5374 5986 2745 608 5926 1474 6323 3166 5659 23 5853 3656 2303 2624 566 4984 1452 1182 598 654 5557 652 631 823 2649 279 623 4209 1638 4290 2118 3289 1551 1758 2881 821 800 1011 5339 3180 2949 4944 5907 4939 4734 3715 25 3052 5595 701 3690 ]

  idx=[1058 4866 4934 5272 6223 5271 1704 1602 2112 550 4017 1744 664 5170 1657 1553 5230 1644 5905 5970 2201 1409 574 5988 703 4349 927 3208 73 3479 4337 4460 5324 2636 3306 4664 1827 5003 1268 6027 2746 1916 2474 3482 6008 978 3555 5416 4002 4405 5815 4951 3374 1469 2999 5111 107 3106 1811 3070 3732 4091 148 1366 2205 689 5794 3125 2762 528 1931 4409 4864 5571 2570 5145 5464 189 1076 2591 4975 2869 4766 395 3183 2022 3896 1529 2541 5745 1523 3203 1695 5538 4445 5368 379 2883 5039 185 5133 5694 803 5590 502 5247 5119 4103 6310 4559 3783 4805 2555 122 2337 6021 2181 2100 5106 2182 3375 1231 4225 5985 41 6046 149 2727 22 3554 4477 5900 4430 5567 733 3267 4053 143 1739 5374 5986 2745 608 5926 1474 6323 3166 5659 23 5853 3656 2303 2624 566 4984 1452 1182 598 654 5557 652 631 823 2649 279 623 4209 1638 4290 2118 3289 1551 1758 2881 821 800 1011 5339 3180 2949 4944 5907 4939 4734 3715 25 3052 5595 701 3690 ];

z1=horzcat(traindata(1:xx,[idx]),traindata(1:xx,yy));
     DESTINATIONFILE='D:\DataResults\traindata1_2.arff';
     matlabToArff(DESTINATIONFILE,z1);
 
  
 
     z2=horzcat(testdata(1:xx_test,[idx]),testdata(1:xx_test,yy_test));
     DESTINATIONFILE='D:\DataResults\testdata1_2.arff';
     matlabToArff(DESTINATIONFILE,z2); 
       
     kalman 
%====================================================================%
%====================================================================%
%====================================================================%
%=x=corrcoef(originalsignal(50:100000,:),ActiveIdleSignal(1:99950,:));
%=========================== ========================================%
%====================================================================%
zz    