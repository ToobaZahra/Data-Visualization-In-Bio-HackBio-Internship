# R script
```
print("Hi, my name is Tooba Zahra, a scholar at Comsats University Islamabad. My favourite gene is COMT in Humans.")
```

# Technical Writing 

## From Fastq to figure, Why Most Bioinformatics Pipeline Fail at the Last Mile



Researchers invest months perfecting alignment parameters, tuning variant callers, and ensuring reproducible computational environments. Then, inexplicably, they generate publication figures with hastily written R scripts, inconsistent color schemes, and plots that would make Edward Tufte weep.



### Why Visualization Gets Neglected:

The problem comes from how bioinformatics training typically unfolds. Graduate students learn statistical methods, and computational infrastructure. Visualization is presented as trivial- just call plot() or ggplot() and you're done. The assumption is that if the analysis is sound, the visualization will naturally follow.



### The Reproducibility Breakdown:

Figures are how most readers engage with computational work. If our heatmap uses a rainbow color scheme that creates false structure, or our scatter plot obscures outliers through poor alpha blending, readers will draw wrong conclusions no matter how correct our statistics are. So the consequences for reproducibility are severe. A Nature Genetics paper might provide perfect computational reproducibility-code, parameters, environment specifications-but the figures in that paper often can't be generated from provided scripts.



### How R-based Visualization Should Work

First, visualization code should be modular and reusable, not monolithic scripts. Instead of writing one-off plotting functions for each analysis, build a project specific plotting library with consistent themes, color palettes and layout functions.
Second, visualization parameters should be documented and version-controlled with the same rigor as computational parameters. Good visualization code should read like documentation: someone else should be able to understand our representational choices by reading the code.

Third, treat color and typography as first class concerns, not afterthoughts. Colorblindness affects roughly 8% of men; rainbow colormaps create false gradients; small fonts disappear in presentations. they are not minor polish issues, they are accessibility and communication barriers. 



### Integrating Visualization into Pipelines

Visualization should be integrated throughout the pipeline, with plotting code living alongside analysis code. Modern workflow managers like Snakemake make this possible. Your pipeline should generate publication-ready figures as formal outputs, with explicit dependencies on data files and plot configuration. When your input data changes, your figures regenrate automatically with correct parameters, When you adjust a plotting parameter, you can see exactly which figures are affected. This shifts visualization from an afterthought to a first-class pipeline output.
