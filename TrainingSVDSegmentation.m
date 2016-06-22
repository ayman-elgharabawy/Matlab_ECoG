function[tot]=TrainingSVDSegmentation(rawdata )
tot=zeros('single');
%%%get periods of active and idles
[xs ys]=size(rawdata);
k=1; 
totalk=0;
g=1;
for i =1:length(rawdata)-1
  if(rawdata(i,ys)==rawdata(i+1,ys) && i~=(length(rawdata)-1))
      chunk(k,1:ys-1)=rawdata(i,1:ys-1) ;
      k=k+1;
      
  else
     chunk(k,1:ys-1)=rawdata(i,1:ys-1) ;
     totalk=totalk+k;
      fprintf('\n chunk: %d\n', totalk);
         k=1; 
    [chunkx chunky]=size(chunk);
      if(chunkx <chunky)
      svddata=chunk;
      else
          svddata= SVDSegmentation(chunk',chunkx);
      end
      chunk=zeros('single');
        if((tot)==0)
           tot= svddata;
        else
           tot = vertcat(tot,svddata);
         end
  g=g+1;
  end
end

end 