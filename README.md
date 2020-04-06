# Intercalation Fiji(imageJ) macro
ImageJ Macro for folder loop analysis of timelapse movies.
The idea is to automatically quantify all the timelapse movies in a folder. 
In my case, I have Lifeact-GFP endothelial cells that are displaced by melanoma cells. During intercalation of melanoma cells into the endothelial layer, the GFP signal is displaced leaving background "holes". The Macro  uses thresholding to identify this "holes". It loops through all the timepoints of all the movies and it saves the results per movie. As final results, the macro returns a CSV file, per movie, reporting the number and area of the quantified displacement events, per timepoint. Moreover it saves the binary masks obtained by thresholding.
This results can then be visualized.
What I normally do is:
- Merge all the results in a single file that contains all the needed information to identify the movies (well,FOV,condtion -> see https://github.com/federicosaltarin/Intercalation_Analysis -> R_Notebook_Merge_Summaries.Rmd  ). 
- Process and plot the results (see https://github.com/federicosaltarin/Intercalation_Analysis -> R_Notebook_Script_Intercalation.Rmd)

