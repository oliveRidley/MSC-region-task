function [regionNum,regionAbrev,regionName]=JetsonRegionFromLonLat(lon,lat)
figure('pos',[360   277   765   433])
r=load('Mask_13_Regions')
regions=flipud(r.regions);

regionLat=fliplr(r.lat);

regionLon=r.lon;



 row =fix(lat+90)+1
 col =fix(lon+180)+1;

valid= ~isnan(row) & ~isnan(col);
regioN=NaN(size(row));
regioN(valid)=regions(row(valid)+(col(valid)-1)*180)

imagesc(regionLon,regionLat,regions,'alphadata',(regions>0)*.25)
set(gca,'ydir','norm','dataaspectratio',[1 1 1])
hold on
caxis([.5 13.5])
colormap(turbo(13))


use=find(regioN>0 & ~isnan(regioN))
scatter(lon(use),lat(use),30,regioN(use),'filled')
axis([-180 180,-90 90])
set(gca,'dataaspectratio',[1 1 1])


coast=load('worldmap.mat')
line(coast.lon,coast.lat,'color','k')
beforeCb=get(gca,'pos');
caxis([.5 13.5])
cb=colorbar('Ticks',1:13,'TickLabels',r.regionAbrev)
set(gca,'pos',beforeCb)
xlabel('longitude (^oE)')
ylabel('latitude (^oN)')



regionNum=regioN;
nrec=size(regioN,1);
regionAbrev=cell(nrec,1);
regionName=regionAbrev;

use=(regionNum>0 & ~isnan(regioN));
line(lon(~use),lat(~use),'marker','x','linestyle','none','color','k','markersize',10)
for i=find(~use)'
regionAbrev{i}=string.empty;
regionName{i}=string.empty;
end

regionAbrev(use)=r.regionAbrev(regionNum(use));
regionName(use)=r.regionNames(regionNum(use));
return