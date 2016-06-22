function matlabToArff(fNameARFF,matrix)
javaaddpath('C:\Master\Weka-3-6\weka.jar');
import weka.core.*;
import weka.classifiers.*;
import weka.classifiers.Classifier.*;
import weka.classifiers.functions.*;
import weka.classifiers.Evaluation.*;
import weka.filters.supervised.*;
import weka.core.converters.*;
% convert matrix int arff(Attribute relation file format )format
%clc;
%fNameData = 'seqLabel';
%fNameARFF = 'seqLabel.arff';
matrix=replaceMInfWithzero(matrix);
fidARFF = fopen( fNameARFF ,'w');
%matrix = load(fNameData);
feature = matrix ( : , 1:end-1);
label = matrix (: , end) ;
noFeature = size(feature,2);
noSample = size(feature,1);

%%%%%%%%%% header

fprintf(fidARFF,'%s%s\n\n','@RELATION ',fNameARFF);
for i=1:noFeature % noFeature
         fprintf(fidARFF,'%s\t%s%d\t%s\n' ,'@ATTRIBUTE' , 'Feature',i, 'real' );
end
%fprintf(fidARFF,'%s\n\n','@ATTRIBUTE Class {''0'',''1''}');
fprintf(fidARFF,'%s\n\n','@ATTRIBUTE Class real');

%%%%%%%%%%  data
fprintf(fidARFF,'%s\n','@DATA');
for r=1:noSample
     for c=1:noFeature
          fprintf(fidARFF,'%3.1f,',matrix(r,c) );
     end
            fprintf(fidARFF,'%3.0f\n', label(r));
     
end

fclose(fidARFF);

end
