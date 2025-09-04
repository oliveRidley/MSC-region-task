JETZON_MSC_POC-fluxes_Elisa_010925.csv  this is the original file provided by Chloe Baumas by email 9/2/25 thread "Re: JETZON paper WG1, MSC database"



Mask_13_Regions.mat is the JETZON regions specification 

>> load Mask_13_Regions.mat
>> whos
  Name               Size              Bytes  Class     Attributes

  lat                1x180              1440  double              
  lon                1x360              2880  double              
  regionAbrev       13x1                1424  cell                
  regionNames       13x1                1802  cell                
  regions          180x360            518400  double           

>> regionNames

regionNames =

  13×1 cell array

    {'Arctic'                   }
    {'North Atlantic'           }
    {'North Pacific'            }
    {'North Subtropics Pacific' }
    {'Equatorial Pacific'       }
    {'South Subtropics Pacific' }
    {'Subantarctic'             }
    {'Antarctic'                }
    {'North Subtropics Atlantic'}
    {'Equatorial Atlantic'      }
    {'South Subtropics Atlantic'}
    {'North Indian ocean'       }
    {'South Indian Ocean'       }

so valid ocean regions run from 1-13,  0 is land

regions is a 1deg resolution 180x360 array with the region number assigned
imagesc(lon,lat,regions,'alphadata',regions>0)

set(gca,'ydir','norm','clim',[.5 13.5])
cb=colorbar;
set(cb,'Ticks',1:13,'TickLabels',regionAbrev)
colormap(turbo(13))
title('Mask_13_regions.mat','interp','none')


worldmap.mat is just a low resolution coastline I used to map the locations.

cleanupJetzonMsc.m  this shows what I did to suspicious locations.  Usually the Site field had the location which would help determine the sign of the lat or lon. If not the cruise name was used to look at the cruise report online.

before.png and after.png are the locations before and after.

JetsonRegionFromLonLat.m is a function to find the region from a location.  It makes a image of the locations overlaid on the region map, which I saved to MSClocationOverRegions.png 

the results were saved to a mat
JETZON_MSC_POC-fluxes_Elisa_010925.mat and a spreadsheet JETZON_MSC_POC-fluxes_Elisa_010925.xlsx

Two locations didn't have locations, so I looked at the cruise reports to find a location for that day to assign a region.
