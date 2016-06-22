function[SegmentedData]=SVDSegmentation(rawdata , windowSize)
SegmentedData=zeros('single');
for k = 0:windowSize:length(rawdata)-windowSize
[FUtotalsignal,FS,FV]=svd(rawdata(:,k+1:k+windowSize)','econ'); 
temp1=FUtotalsignal*FS;
if(SegmentedData == 0)
   SegmentedData=temp1;
   else
   SegmentedData= vertcat(SegmentedData,temp1);
   end
end
end 