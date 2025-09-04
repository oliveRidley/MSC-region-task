MSC=readtable('JETZON_MSC_POC-fluxes_Elisa_010925.csv');

geoplot(MSC.lat_N_,MSC.lon_E_,'.')
title('Before')
figure

fucked=find(ismember(MSC.Project,'CUSTARD')); %Punta Arenas so lat
                                              %is wrong sign. 


mofucked=find(MSC.lon_E_>36 & MSC.lon_E_<44 & MSC.lat_N_>52 & ...
	      MSC.lat_N_<58); % these are south georgia DY086
                               % comics I.  CHange latitude sign,
                               % lon too.

MSC.lat_N_([fucked;mofucked])=-MSC.lat_N_([fucked;mofucked]);
MSC.lon_E_(mofucked)=MSC.lon_E_(mofucked);  % south georgia rather
                                            % than moscow.

landMsc=find(MSC.lon_E_>11 & MSC.lon_E_<11.2 & MSC.lat_N_>15 & ...
	     MSC.lat_N_<20);
% this is comics 2 Nambia  so latitude south
MSC.lat_N_(landMsc)=-MSC.lat_N_(landMsc);

% scotia sea JR274
landMsc=find(MSC.lon_E_>-48.5 & MSC.lon_E_<-45& MSC.lat_N_>60.8 & ...
	     MSC.lat_N_<61);

% cruises JR274 JR304 
scotiaSea=find(ismember(MSC.Site,'Scotia Sea'));
MSC.lat_N_(scotiaSea)=-MSC.lat_N_(scotiaSea);

so=find(ismember(MSC.Site,'Southern Ocean'));
MSC.lat_N_(so)=-MSC.lat_N_(so);



sg=find(ismember(MSC.Site,'South Georgia'));
sgToMv=find(MSC.lon_E_(sg)>0);
MSC.lon_E_(sg(sgToMv))=-MSC.lon_E_(sg(sgToMv));

%'Agulhas Bank '
agulhas=find(ismember(MSC.Site,'Agulhas Bank '));
MSC.lat_N_(agulhas)=-MSC.lat_N_(agulhas);

geoplot(MSC.lat_N_,MSC.lon_E_,'.')
title('After')



[regionNum,regionAbrev,regionName]= ...
    JetsonRegionFromLonLat(MSC.lon_E_,MSC.lat_N_);

% append new columns for region.
MSC=addvars(MSC,regionNum,regionAbrev,regionName);
title('MSC over JETZON regions')
xlabel('longitude (^oE)')
ylabel('latitude (^oN)')

% confirmed JR219 was Northern Hemi
% https://www.bodc.ac.uk/resources/inventories/cruise_inventory/report/10619/

% records 384 and 415 are missing location
%>> MSC([384,415],[2 3 5 7 8])
%
%ans =
%
%  2×5 table
%
%     Cruise           Site            date        lat_N_    lon_E_
%    _________    ______________    ___________    ______    ______
%
%    {'JR274'}    {'Scotia Sea'}    27-Jan-2013     NaN       NaN  
%    {'JR271'}    {'North Sea' }    11-Jun-2012     NaN       NaN  





% downloaded cruise report  JR271  June 11 snow catcher ws deployed
% 69.89567N -7.57712E    which is North Atlantic regionNum 2 NA
%
%JR274 are all Scotia Sea so Antarctic  AAZ regionNum 8
%

%safu=find(MSC.lat_N_>-36 & MSC.lat_N_<-33 & MSC.lon_E_>22 & ...
%	  MSC.lon_E_<30)  this had bits over land, but it is the
%	  Agulhas bank.  
MSC.regionNum(384)=8;
MSC.regionAbev{384}='AAZ';
MSC.regionName{384}='Antarctic';
MSC.regionNum(384)=2;
MSC.regionAbev{384}='NA';
MSC.regionName{384}='North Atlantic';

save JETZON_MSC_POC_fluxes_Elisa_010925 MSC

writetable(MSC,'JETZON_MSC_POC-fluxes_Elisa_010925.xlsx');


