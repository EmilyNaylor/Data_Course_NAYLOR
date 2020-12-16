Emily Naylor

December 16,2020

Another Meta-Analysis for Genetic Association Between Autoimmune Disease

My Data-Analysis Final Project


The final report is contained in the r markdown Another_Meta-Analysis_for_Genetic_Association_Between_Autoimmune_Diseases.Rmd with its corresponding html file.


R folder and files

	01_clean_SNP_data.R -- The R file where the data was cleaned up for analysis. The code chunk under the Quality Control subsection of the markdown report.

	02_create_case_control_matrix -- The R file where the case control matrices were created. The code chunk under the Case Control Matrices subsection of the markdown report.
	
	03_ASSET_Htraits_analysis.R -- The R file where the data was analyzed using a heterogeneous two-sided subset-based method (located in the code chunk of the Heterogeneous Two-sided Subset Analysis subsection of the markdown report) as well as the table and figures of the results (located in the code chunks of the Results section of the markdown report).
	
	ASSET_manual_examples.R -- The R file containing the examples on how to use the commands of the R package ASSET from the Vignette.

Data folder and files
	
	snp_data_raw.xlsx -- The raw qualitity controlled data from Marquez et al. (2018). Contains the SNP data as well as the sample size data.
	
	SNP_meta_data_cleaned_excel.csv -- The excel data from the raw that was cleaned for R format.
	
	SNP_Data_Organized.csv -- The cleaned and organized data from the 01_clean_SNP_data.R file.
	
	control_matrix.txt -- The matrix of the controls shared between disease types.
	
	case_matrix.txt -- The matrix of the case subjects shared between disease types.
	
	case_control.txt -- The matrix of the case subjects shared as controls between disease types. Had to be created for analysis to work even though there were none.
	
	h_trait_analysis.csv -- The summarized h.trait analysis results of all of the SNPs examined within the project. 

Results folders and files

	Table -- Contains the table results of the 8 SNPs associated with at least 3 diseases.
	
	Figures -- Contains the individual forest plots for each of the 8 SNPs along with the two combined plots that had to be combined outside of R due to the h.forest function of ASSET not having a functionality for combining plots. 
