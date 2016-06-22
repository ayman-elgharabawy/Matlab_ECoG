function [ mixedLabeled ] = labelData_ActiveIdle(inputdata,outputdata,fingIndex)
% *************************************************************************
% We use this function to label the active and idle epoches for the input
% signal and output finger data   Master
% *************************************************************************
[datalength noOfChannels]=size(inputdata);
mixedLabeled=zeros(datalength,noOfChannels+1);
r=zeros('double');
 Active=1;
 Idle=0;
for j=101:datalength
    r=j-100;  %Delay 100 is best till now
 if(outputdata(j,fingIndex)>1)
    mixedLabeled(r,:)=horzcat(inputdata(r,:),Active);
 else  
    mixedLabeled(r,:)=horzcat(inputdata(r,:),Idle);
 end
end
 
  
end