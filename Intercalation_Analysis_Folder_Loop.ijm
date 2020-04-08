///author: Federico Saltarin///
///////////////////////////////////////////////////////////////////////////////////////

//Set the middle slice for later
mid_slice = round(nSlices/2);

//Choose the directory with all the TIFF files to analyze
dir = getDirectory("Choose a Directory ");
//Gets the list of all files inside the folder (Note: Keep only the tiff files to analyze and nothing else!)
files = getFileList( dir );

first_image = dir + files[1]

// Create sub-directories for summaries and analysis masks
out_dir = dir + "/Analysis/"; // 
File.makeDirectory(out_dir); 

mask_dir = out_dir + "/Masks/"; // 
File.makeDirectory(mask_dir); 

summ_dir = out_dir + "/Summary/"; // 
File.makeDirectory(summ_dir); 

// Setup the threshold level to use later for analysis
open( first_image );
setSlice(mid_slice)
run("Threshold...");
waitForUser("Set the Treshold", "Set the Treshold and click OK");
getThreshold(lower, upper);
close();
//print (lower,upper);

setBatchMode(true)

//Define function to do all the processing
function processFile( filePath ) 
{
	print( "Processing file: " + path );
        open( path );
          
//Thresholding
setAutoThreshold("Default dark no-reset");
//setAutoThreshold("Default dark");

//Threshold image based on setup from before
setThreshold(lower, upper);
setOption("BlackBackground", true);

//Create a mask, erode, dilate and fill holes to have a clean mask
run("Convert to Mask", "method=Otsu background=Dark black");
run("Fill Holes", "stack");
run("Erode", "stack");
run("Dilate", "stack");
run("Fill Holes", "stack");
run("Close-", "stack");

// Remove everything outside a central circle (if needed e.g. uneven illumination remove // before commands)
//makeOval(110, 110, 800, 800);
//run("Clear Outside", "stack");

// Set the dimension range for Analyze Particles plugin
run("Analyze Particles...", "size=35-Infinity circularity=0.00-1.00 show=Outlines summarize stack");

// Save summary and masks in the subfolders created before
selectWindow("Summary of "+files[i]+"");  
saveAs("Results", ""+summ_dir+"Summary of " +files[i]+".csv");

selectWindow("Drawing of "+files[i]+"");  
saveAs("tiff", ""+mask_dir+"Mask of " +files[i]+".tiff");

}


for (i = 0; i < files.length; i++) 
{
   path = dir + files[i];
   processFile( path );
}









