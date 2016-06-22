function [InputActives,InputIdles,OutputActives,OutputIdles]=SeparateActiveIdle(IndputData)

[datalength noOfChannels]=size(IndputData);
InputActives=zeros(datalength-100,1:noOfChannels-1);
InputIdles=zeros(datalength-100,1:noOfChannels-1);

OutputActives=zeros(datalength-100,noOfChannels);
OutputIdles=zeros(datalength-100,noOfChannels);
r=zeros('double');

for j=101:datalength
    r=j-100;  %Delay 100 is best till now
 if(IndputData(j,noOfChannels)>0.2)
    InputActives(r,:)=(inputdata(r,1:noOfChannels-1));
     OutputActives(r,:)=(inputdata(r,noOfChannels));
 else  
    InputIdles(r,:)=(inputdata(r,1:noOfChannels-1));
    OutputIdles(r,:)=(inputdata(r,noOfChannels));
 end
end

end