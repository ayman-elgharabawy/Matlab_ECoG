function featurelist = replaceMInfWithzero(featurelist)

[rownum,colnum]=size(featurelist);
for k= 1 :colnum    %1798    -- --1855
for i = 1:rownum
if((featurelist(i,k)==-Inf))
  featurelist(i,k)=0;
end
if((featurelist(i,k)==Inf))
  featurelist(i,k)=0;
end
end
end