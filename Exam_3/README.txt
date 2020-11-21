SKILLS TEST 3
_____________


Do a fresh "git pull" to get the skills test files.
The files you just got from your "git pull" are:
  
README.txt            # this file containing the test prompts
fig1.png                    # Need to recreate this figure exactly (see instructions)
fig2.png                    # Need to recreate this figure approximately (see instructions)
FacultySalaries_1995.csv    # Data for part 1
Juniper_Oils.csv            # Data for part 2

FacultySalaries_1995.csv   # College faculty salaries and total compensation from 1995, by Ranks, Tier, and State (This is supposedly real data, but I'm not sure the scale. 600 definitely doesn't mean $600,000, but it's not important.) College faculty have 3 ranks: Assistant (not tenured), Associate (tenured), and Full (been around forever or something). College "Tier" refers to the amount of funding devoted to research vs the amount of funding for teaching, with Tier I being universities that spend more on research than teaching and award PhD degrees.

Juniper_Oils.csv          # A number of dead cedar trees were collected and the chemical composition of their essential oil content was measured. The hypothesis was that certain chemicals would degrade over time since they died in fires. So there are a bunch of columns for chemical compounds, and a column for "YearsSinceBurn." The values under each chemical are Mass-Spec concentrations.

################################################################################
#   Create a new directory in YOUR data course repository called Exam_3        #       
#   Create a new Rproject in this new directory and copy all exam files to it  #
#   Complete the tasks below in a script called LASTNAME_Skills_Test_3.R       #
#   Be sure that your file paths are relative to your new Rproject             #
################################################################################


Tasks:
  
I.      Load and clean FacultySalaries_1995.csv file
Re-create the graph shown in "fig1.png"
Export it to your Exam_3 folder as LASTNAME_Fig_1.jpg (note, that's a jpg, not a png)
Please pay attention to what variables are on this graph.  This task is really all about whether you can make a tidy dataset out of something a bit wonky. Refer back to the video where we cleaned "Bird_Measurements.csv"

        
II.     Export an ANOVA table to a file called "Salary_ANOVA_Summary.txt"
        The ANOVA model should test the influence of "State", "Tier", and "Rank" on "Salary" but should NOT include any interactions between those predictors.


III.    The rest of the test uses another data set. The "Juniper_Oils.csv" data. Get it loaded and take a look.
        It's not exactly tidy either. Get used to that. It's real data collected as part of a collaboration between Young Living Inc. and UVU Microbiology. A number of dead cedar trees were collected and the chemical composition of their essential oil content was measured. The hypothesis was that certain chemicals would degrade over time since they died in fires. So there are a bunch of columns for chemical compounds, and a column for "YearsSinceBurn." The values under each chemical are Mass-Spec concentrations.
        Those are the ones the columns we care about for the purposes of this exam. Guess what, I'm giving you a nicely formatted list of the chemical compounds:
        c("alpha-pinene","para-cymene","alpha-terpineol","cedr-9-ene","alpha-cedrene","beta-cedrene","cis-thujopsene","alpha-himachalene","beta-chamigrene","cuparene","compound 1","alpha-chamigrene","widdrol","cedrol","beta-acorenol","alpha-acorenol","gamma-eudesmol","beta-eudesmol","alpha-eudesmol","cedr-8-en-13-ol","cedr-8-en-15-ol","compound 2","thujopsenal")
        
                                                         
IV.     Make me a graph of the following:
        x = YearsSinceBurn
        y = Concentration
        facet = ChemicalID (use free y-axis scales)
        See Fig2.png for an idea of what I'm looking for

V.      Use a generalized linear model to find which chemicals show concentrations that are significantly (significant, as in P < 0.05) affected by "Years Since Burn". Use the tidy() function from the broom R package (Thank Dalton for asking about this) in order to produce a data frame showing JUST the significant chemicals and their model output (coefficient estimates, p-values, etc)     

I'll show you what I mean...here's the data frame I need you to produce from your glm model:

# A tibble: 6 x 5
  term                          estimate std.error statistic  p.value
  <chr>                            <dbl>     <dbl>     <dbl>    <dbl>
1 alpha-cedrene                    7.88      1.93       4.08 4.97e- 5
2 cedr-8-en-13-ol                  7.62      1.93       3.95 8.72e- 5
3 cedrol                          22.5       1.93      11.7  5.12e-29
4 cis-thujopsene                  17.3       1.93       8.95 2.93e-18
5 widdrol                          5.82      1.93       3.01 2.69e- 3
6 cis-thujopsene:YearsSinceBurn    0.332     0.141      2.35 1.90e- 2


VI.		Commit and push all your code and files to GitHub. I'll pull your repository after Thanksgiving break and grade what I find.
                                                                                                              
                                                                                                              
VII. For 10 bonus points, put all this code and output into a fancy knitted html file instead of just an R script.

