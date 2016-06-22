
function [ temp1 ]  = getWindowAmplitude(rawdata,windowSize,NoOfChanels)



featuresData=zeros(length(rawdata),1);
for i= 1:NoOfChanels
   result=zeros('single'); 
   k=1;
  for h=0:windowSize:length(rawdata)-windowSize
    temp1(h+1:h+windowSize,i)=(sum(rawdata(h+1:h+windowSize,i))/windowSize)^2;
   k=k+1;
   end



end
      
end