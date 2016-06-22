function [ totalresult1,totalresult2,totalresult3,totalresult4,totalresult5] =getWindowMtSpectrum(rawdata,windowSize,noOfChannels)
 
Ktapers=3;
NW=(Ktapers+1)/2;
params.tapers = [NW  Ktapers];
params.Fs=500; 
params.fpass = [0 250];
params.pad =8;
params.err=[2 .05];
 
totalresult1=zeros('single');
totalresult2=zeros('single');
totalresult3=zeros('single');
totalresult4=zeros('single');
totalresult5=zeros('single');

var xx;

   result1=zeros('single'); 
   result2=zeros('single'); 
   result3=zeros('single'); 
   result4=zeros('single'); 
   result5=zeros('single');
   
for i= 1:noOfChannels

for k=0:windowSize:length(rawdata)-windowSize
    
    [xx,f1,Serr1]=mtspectrumc(rawdata(k+1:k+windowSize,i),params);
   temp1(1:windowSize,1)= (sum(xx(1:10000,1))/10000)^2;
   if(result1 == 0)
   result1=temp1;
   else
   result1= vertcat(result1,temp1);
   end
        
   
    temp2(1:windowSize,1) =(sum(xx(10001:20000,1))/10000)^2;
   if(result2 == 0)
   result2=temp2;
   else
   result2= vertcat(result2,temp2);
   end
   
      temp3(1:windowSize,1)= (sum(xx(20001:30000,1))/10000)^2;
   if(result3 == 0)
   result3=temp3;
   else
   result3= vertcat(result3,temp3);
   end
   
   
    temp4(1:windowSize,1)= (sum(xx(30001:40000,1))/10000)^2;
   if(result4 == 0)
   result4=temp4;
   else  
   result4= vertcat(result4,temp4);
   end
       
   temp5(1:windowSize,1)= (sum(xx(40001:50000,1))/10000)^2;
   if(result5 == 0)
   result5=temp5;
   else
  result5= vertcat(result5,temp5);
   end
   
  % temp6(1:windowSize,1)= (sum(xx(101:110,1))/10)^2;
  % if(result6 == 0)
  % result6=temp6;
  % else
  % result6= vertcat(result6,temp6);
  % end
   
   
  % temp7(1:windowSize,1)= (sum(xx(111:120,1))/10)^2;
  % if(result7 == 0)
  % result7=temp7;
  % else
  % result7= vertcat(result7,temp7);
  % end
   
   
   %   temp8(1:windowSize,1)= (sum(xx(35001:40000,1))/5000)^2;
   %if(result8 == 0)
   %result8=temp8;
   %else
   %result8= vertcat(result8,temp8);
   %end
   
  
   % temp9(1:windowSize,1)= (sum(xx(40001:45000,1))/5000)^2;
   %if(result9 == 0)
   %result9=temp9;
   %else
   %result9= vertcat(result9,temp9);
   %end
   
   %    temp10(1:windowSize,1)= (sum(xx(45001:50000,1))/5000)^2;
   %if(result10 == 0)
   %result10=temp10;
   %else
   %result10= vertcat(result10,temp10);
   %end
   
   
end


if((totalresult1)==0)
 totalresult1= result1;
else

totalresult1 = horzcat(totalresult1,result1);

end
 result1=0;
 
 if((totalresult2)==0)
 totalresult2= result2;
else

totalresult2 = horzcat(totalresult2,result2);

 end
 result2=0;
 
 if((totalresult3)==0)
 totalresult3= result3;
else

totalresult3 = horzcat(totalresult3,result3);

 end
 result3=0;
 
 if((totalresult4)==0)
 totalresult4= result4;
 else
     if(length(result4)==length(totalresult4))
totalresult4 = horzcat(totalresult4,result4);
     end
 end
result4=0;

  if((totalresult5)==0)
 totalresult5= result5;
  else
    if(length(result5)==length(totalresult5))
 totalresult5 = horzcat(totalresult5,result5);
    end
end
result5=0;
 

%  if((totalresult6)==0)
% totalresult6= result6;
%else
%     if(length(result6)==length(totalresult6))
%totalresult6 = horzcat(totalresult6,result6);
%end
%  end
%result6=0;

%  if((totalresult7)==0)
% totalresult7= result7;
%else
 %    if(length(result7)==length(totalresult7))
%totalresult7 = horzcat(totalresult7,result7);
%end
%  end
%result7=0;


%  if((totalresult8)==0)
% totalresult8= result8;
%else
%     if(length(result8)==length(totalresult8))
%totalresult8 = horzcat(totalresult8,result8);
%end
%  end
%result8=0;

 % if((totalresult9)==0)
 %totalresult9= result9;
%else
 %    if(length(result9)==length(totalresult9))
%totalresult9 = horzcat(totalresult9,result9);
%end
 % end
%result9=0;

 % if((totalresult10)==0)
 %totalresult10= result10;
%else
 %    if(length(result10)==length(totalresult10))
%totalresult10 = horzcat(totalresult10,result10);
%end
 % end
%result10=0;
%=================
 
 %total=horzcat(totalresult1,totalresult2,totalresult3,totalresult4,totalresult5 ,totalresult6,totalresult7,totalresult8,totalresult9,totalresult10);
end
end