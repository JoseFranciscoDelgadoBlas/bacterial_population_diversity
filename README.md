# bacterial_population_genomic_diversity
R codes to analyze differential bacterial populations from different ecological niches based on genomic data in order to assess diversity of total gene content, plasmid content, antimicrobial resistance gene content and bacterial functions.

The R code files here indicated are broadly explained and linked to the work “Population genomics and evolutionary history of Escherichia coli resistant to last-resort antibiotics in wastewater and river environments” by Delgado-Blas et al.


# Contents

R code to extract and analyze presence/absence gene data from pan-genomic analysis to carry out a statistical comparison of total gene diversity between two bacterial populations at two levels: comparison of the differential gene composition and comparison of the level of gene diversity of both populations.

    Total_genomic_bacterial_diversity.R

R code to extract and analyze presence/absence gene data from pan-genomic analysis to carry out a statistical comparison of the level of gene diversity between sequence types (STs) of the same bacterial species from two different ecological niches.

    Genomic_bacterial_diversity_per_bacterial_ST.R
    
R code to extract and analyze presence/absence plasmid data (based on plasmid incompatibility groups) from ARIBA pipeline using PlasmidFinder database to carry out a statistical comparison of total plasmid diversity between two bacterial populations at two levels: comparison of the differential plasmid composition and comparison of the level of plasmid diversity of both populations.

    Total_plasmid_diversity.R
    
R code to extract and analyze presence/absence plasmid data (based on plasmid incompatibility groups) from ARIBA pipeline using PlasmidFinder database to carry out a statistical comparison of the level of plasmid diversity between sequence types (STs) of the same bacterial species from two different ecological niches.

    Plasmid_diversity_per_bacterial_ST.R
    
R code to extract and analyze presence/absence resistance gene data from ARIBA pipeline using ResFinder database to carry out a statistical comparison of total resistance gene diversity between two bacterial populations at two levels: comparison of the differential resistance gene composition and comparison of the level of resistance gene diversity of both populations.

    Total_resistance_gene_diversity.R
    
R code to extract and analyze presence/absence resistance gene data from ARIBA pipeline using ResFinder database to carry out a statistical comparison of the level of resistance gene diversity between sequence types (STs) of the same bacterial species from two different ecological niches.

    Resistance_gene_diversity_per_bacterial_ST.R
    
R code to extract and analyze presence/absence bacterial function data from anvi'o pipeline using the microbial pangenomics workflow to carry out a statistical comparison of total function diversity between two bacterial populations at two levels: comparison of the differential function composition and comparison of the level of bacterial function diversity of both populations.

     Total_function_diversity.R
     
R code to extract and analyze presence/absence bacterial function data from anvi'o pipeline using the microbial pangenomics workflow to carry out a statistical comparison of the level of bacterial function diversity between sequence types (STs) of the same bacterial species from two different ecological niches.

     Function_diversity_per_bacterial_ST.R
