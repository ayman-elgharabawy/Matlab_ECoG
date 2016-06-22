

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

finger_index=2;
Mixedtrain=horzcat(train_data,train_dg(:,finger_index));
Mixedtest=horzcat(test_data,test_dg(:,finger_index));
 Mixedtrain_sampled= downsample(Mixedtrain);
 Mixedtest_sampled=  downsample(Mixedtest);
 
[ InputActive1,InputIdle1,OutputActive1,OutputIdle1] = SeparateActiveIdle(Mixedtrain_sampled);
[ InputActive2,InputIdle2,OutputActive2,OutputIdle2] = SeparateActiveIdle(Mixedtest_sampled);



md = NonLinearModel.fit(traindata(:,:),fingerstates(1:199680,1),modelfun,beta0);
 
 predictedFingerStatus=predict(mdl,traindata_testdata);