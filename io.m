clear all;
close all;

fileFolder= fullfile('E:/', 'Pattern Recognition','images');
files= dir(fullfile(fileFolder,'*.tif'));
fileNames= {files.name};
for i = 1: length(fileNames)
    fname{i} = fullfile(fileFolder,fileNames{i});
    I{i} = imread(fname{i});
end

for i = 1:2
    [N_Objects,N_Ho,Avgeob,E,Arnf1,eccnmed,eccnm,eccnvar, eccnkurtosis] = Segmentation(I{i}, i);
    N_O(i) = N_Objects;
    N_Holes(i)=N_Ho;
    AvgEOB(i)=Avgeob;
    Euler(i)= E;
    Arnf(i) = Arnf1;
    eccnmedian(i) = eccnmed;
    eccnmean(i) = eccnm;
    eccnv(i) = eccnvar;
    eccnkurt(i) = eccnkurtosis;
   % eccnsk(i) = eccnskewness;
end

 %% plotting
%Updating the Variance of Eccentricity
for i = 1:12
    if(isnan(eccnv(i)))
        ECCNVIDC(i)=0;
    else
        ECCNVIDC(i)=eccnv(i);
    end
end

for i = 13:24
    if(isnan(eccnv(i)))
        ECCNVN(i-12)=0;
    else
        ECCNVN(i-12)=eccnv(i);
    end
end

%%
%Updating Kurtosis
for i = 1:12
    if(isnan(eccnkurt(i)))
        EOIDC_kurt(i)=0;
    else
        EOIDC_kurt(i)=eccnkurt(i);
    end
end

for i = 13:24
    if(isnan(eccnkurt(i)))
        EON_kurt(i-12)=0;
    else
        EON_kurt(i-12)=eccnkurt(i);
    end
end

%%
%Updating Skewness
for i = 1:12
    if(isnan(eccnsk(i)))
        EOIDC_skew(i)=0;
    else
        EOIDC_skew(i)=eccnsk(i);
    end
end

for i = 13:24
    if(isnan(eccnsk(i)))
        EON_skew(i-12)=0;
    else
        EON_skew(i-12)=eccnsk(i);
    end
end


%%
figure(1), scatter3(ECCNVN,EON_kurt,EON_skew, 'r');
hold on;
scatter3(ECCNVIDC,EOIDC_kurt,EOIDC_skew,'b');
title('Eccentricities variance vs Kurtosis vs skewness ');
legend('Holes of Normal Tissue - Eccentricity','Holes of Cancer tissue - Eccentricity');
xlabel('Variance of Eccentricity'); ylabel('Kurtosis of Eccentricity'); zlabel('Skewness of Eccentricity');

%%
figure(2);
plot(ECCNVN, EON_kurt,'ro');
hold on;
plot(ECCNVIDC, EOIDC_kurt,'b*');
hold on;
title('Eccentricity Kurtosis vs Eccentricity Variance');
legend('Normal Tissue','Cancer Tissue')
xlabel('Variance of Eccentricity'); ylabel('Kurtosis of Eccentricity');

figure(3);
plot(ECCNVN, EON_skew,'ro');
hold on;
plot(ECCNVIDC, EOIDC_skew,'b*');
hold on;
title('Eccentricity Skewness vs Eccentricity Variance');
legend('Normal Tissue','Cancer Tissue')
xlabel('Variance of Eccentricity'); ylabel('Skewness of Eccentricity');

figure(4);
plot( EON_skew,EON_kurt,'ro');
hold on;
plot(EOIDC_skew, EOIDC_kurt,'b*');
hold on;
title('Eccentricity Kurtosis vs Eccentricity Skewness');
legend('Normal Tissue','Cancer Tissue')
xlabel('Variance of Eccentricity'); ylabel('Kurtosis of Eccentricity');

%%
%Variance of Ratio of the Area of the nucleus to the total area of the
%chain

for i = 1:12
    if(isnan(Arnf(i)))
        ArvIDC(i)=0;
    else
        ArvIDC(i)=Arnf(i);
    end
end

for i = 13:24
    if(isnan(Arnf(i)))
        ArvN(i-12)=0;
    else
        ArvN(i-12)=Arnf(i);
    end
end

figure(5);
plot(ECCNVN, ArvN,'ro');
hold on;
plot(ECCNVIDC, ArvIDC,'b*');
hold on;
title('Variance of ratio of Nuclei area to total area  vs Eccentricity Variance');
legend('Normal Tissue','Cancer Tissue')
xlabel('Variance of Eccentricity'); ylabel('Variance of the ratio of the Nuclei area to the total area of the chain');

%%
% %%Avgdiameter
% for i = 13:24
%     if(isnan(AvgEdia(i)))
%         AvgdiaN(i-12)=0;
%     else
%         AvgdiaN(i-12)=AvgEdia(i);
%     end
% end
% 
% for i = 1:12
%     if(isnan(AvgEdia(i)))
%         AvgdiaIDC(i)=0;
%     else
%         AvgdiaIDC(i)=AvgEdia(i);
%     end
% end
% 
% for i = 25:36
%     if(isnan(AvgEdia(i)))
%         AvgdiaDCIS(i-24)=0;
%     else
%         AvgdiaDCIS(i-24)= AvgEdia(i);
%     end
% end
% 
% %%
% figure(3), plot(AvgdiaN, 'rd','MarkerFaceColor', 'r');
% hold on;
% plot(AvgdiaIDC,'d','MarkerFaceColor','b');
% %plot(AvgdiaDCIS,'d','MarkerFaceColor', 'y');
% title('Avg diameter holes formed by connected chains in the images ');
% legend('Avg diameter of Normal Tissue ','Avg diameter of Cancer tissue ', 'Eccentricity of DCIS');
% xlabel('Instances/ Images'); ylabel('Average Diameters of the holes in the image');

% %Eccnmedian, Eccnmean, Areanfeature
% for i = 1:12
%     if(isnan(eccnmedian(i)))
%         EOIDCn(i)=0;
%     else
%         EOIDCn(i)=eccnmedian(i);
%     end
% end
% 
% for i = 13:24
%     if(isnan(eccnmedian(i)))
%         EONn(i-12)=0;
%     else
%         EONn(i-12)=eccnmedian(i);
%     end
% end
% 
% for i = 25:36
%     if(isnan(eccnmedian(i)))
%         EODCISn(i-24)=0;
%     else
%         EODCISn(i-24)=eccnmedian(i);
%     end
% end
% 
% figure(4), plot(EOIDCn, 'rd','MarkerFaceColor', 'r');
% hold on;
% plot(EONn,'d','MarkerFaceColor','b');
% %plot(EODCISn,'d','MarkerFaceColor', 'y');
% title('Avg Eccentricity of the nucleus vs the image instances ');
% legend('Avg Eccentricity of nuclei of Normal Tissue ','Avg Eccentricity of nuclei of Cancer tissue ', 'Avg Eccentricity of nuclei of the DCIS');
% xlabel('Instances/ Images'); ylabel('Average Diameters of the holes in the image');
% 
% 

%%
% %plotting mean values of eccentricities of nucleus
% for i = 1:12
%     if(isnan(eccnmean(i)))
%         EOIDCmn(i)=0;
%     else
%         EOIDCmn(i)=eccnmean(i);
%     end
% end
% 
% for i = 13:24
%     if(isnan(eccnmean(i)))
%         EONmn(i-12)=0;
%     else
%         EONmn(i-12)=eccnmean(i);
%     end
% end
% 
% for i = 25:36
%     if(isnan(eccnmean(i)))
%         EODCISmn(i-24)=0;
%     else
%         EODCISmn(i-24)=eccnmean(i);
%     end
% end
% 
% figure(5), plot(EOIDCmn, 'rd','MarkerFaceColor', 'r');
% hold on;
% plot(EONmn,'d','MarkerFaceColor','b');
% %plot(EODCISn,'d','MarkerFaceColor', 'y');
% title('Avg Eccentricity of the nucleus vs the image instances ');
% legend('Avg Eccentricity of nuclei of Normal Tissue ','Avg Eccentricity of nuclei of Cancer tissue ', 'Avg Eccentricity of nuclei of the DCIS');
% xlabel('Instances/ Images'); ylabel('Average eccentricities of the nuceleus of the image');
% 
% 
% %% plotting eccentricities of holes vs  mean eccentricities of nucleus
% figure(6), plot(EOIDCmn,EOIDC, 'r*');
% hold on;
% plot(EONmn, EON, 'b*');
% title('Eccentricities of Nuclei vs eccentricities of holes');
% legend('Cancer','Normal');
% xlabel('Eccentricity of Nuclei (Nuclear size)');
% ylabel('Eccentricity of holes (Tubular Feature)');
