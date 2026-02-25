
# data types

x <- 3
y <- 3L
z <- "H"
a <- 3i
b <- TRUE
c <- FALSE
class(a)
class(b)
class(c)
class(x)
class(y)
class(z)
#----------------------------

# R Math
min(3,45)
max(21,200)
sqrt(5)
abs(-3.45)
ceiling(6.77)
floor(7.97)

#----------------------------

# R data structures
gene_exp <- c('A'= 10,"B"= 14.2, 'C' = 3.5)
print(gene_exp)
gene_exp
gene_exp[1]
gene_exp[-2]
gene_exp['C']
gene_exp[["C"]]
gene_exp <- gene_exp[-2]
gene_exp

#----------------------------

# Data Frames
my_genes <- c('A','B','C')
sample_1 <- c(89,43,21)
sample_2 <- c(34,44,14)
sample_3 <- c(14,28,8)

my_gene_df <- data.frame(my_genes,sample_1, sample_2, sample_3)

# select col
my_gene_df$my_genes
my_gene_df[2,]
my_gene_df[1:2,]
my_gene_df[c(1,2),c(1,2)]

# Importing dataframes
fileOnMyPc <- 'E:/Data-Visualization-In-Bio-HackBio-Internship/Data Visualisation with R/bacteria.csv'
fileOnline <- 'https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/bacteria.csv'

read.csv(fileOnMyPc, header=T)
read.csv(fileOnline, header=T)

read.delim(fileOnMyPc, header=T, sep=',')
read.delim(fileOnline, header=T, sep=',')

#----------------------------

# Playing with bacterial dataset

bacteria <- read.delim(fileOnMyPc, header=T, sep = ',')
bacteria$BSL
table(bacteria$BSL)
dim(bacteria)
nrow(bacteria)
ncol(bacteria)
head(bacteria)
tail(bacteria)

# Plot some cols
bsl_data <- table(bacteria$BSL)
plot(bsl_data)
barplot(bsl_data)

#----------------------------

# Loops & Conditions

even_num <- seq(0, 10, 2)
print(even_num)

for (i in even_num ){
  print(i)
  Sys.sleep(2)
  print("i am awake now, let's move to next number!")
  
}


my_new_seq <- c(seq(23,87,5), seq(2,47,5))

for (i in my_new_seq) {
  if (i%%2 == 0) {
    print(paste0(i, ' is an even number!'))
  }else{
    print(paste0(i,' is an odd number!'))
  }
  
}

#----------------------------

# Functions

# my_gene <- "GCGCATATTATTAGCGCTAGCTTGC"
# my_gene <- strsplit(x=my_gene,split = '')[[1]]
# print(my_gene)

#for (ntd in my_gene){
 # Sys.sleep(3)
  #print(ntd)
 
#}


GC_calculator <- function(input_gene){ # function
  counter = 0
  input_gene <- strsplit(x=input_gene, split = '')[[1]] # split the string
  
  for (ntd in input_gene) { # for loop
    if (ntd == 'G'| ntd == 'C'){
      counter <- counter + 1
    }
  }
  return ((counter/length(input_gene))*100)
}

gene <- "GCGCATATTATTAGCGCCCCCGGGTAGCTTGC"
GC_calculator(gene)

# ----------------------------------------------------------------------

fileOnMyPc <- 'E:/Data-Visualization-In-Bio-HackBio-Internship/Data Visualisation with R/bacteria.csv'
bacteria <- read.delim(fileOnMyPc, header = T, sep = ',')

View(bacteria)

# Understanding the Columns
# C1,C2 = PCA coordinates

# sample_id = unique identifier

# species = bacterial

# isolation_origin = source of the sample (urine[samples taken from UTIs], blood[isolates from bloodstream infections],
#feces[collected from stool samples that are either pathogenic or harmless], animal[isolates from non-human hosts they are often studies to undersatnd the zoonotic transmission(spread between animal and humans)])

# phenotype = either pathogenic(harmful) or commensal (harmless)

# BSL = biosafety level[how dangerous is to handle the strain in the lab]

# soln =  solution concentration

# fit values [Likely resistance/susceptibility to carbapenems, ciprofloxacin, gentamicin, kanamycin, piperacillin.] = how well the bacteria grew or survived under antibiotic exposure (higher = most resistant)

# labels = could be cluster IDS or machine learning classification labels

# ----------------------------------------------------------------------

# Which sample sources are most represented, and does the dataset
#lean toward clinical infections [urine, blood] or environmental/commensal origins[animal, feces]?

isolation_origin_freq <- table (bacteria$Isolation.origin)
print(isolation_origin_freq)


# Categorical Plots

barplot(height=isolation_origin_freq, # what to plot
        width = c(1,1,1,1), # width of each bar
        names.arg = c('Animal','Blood','Feces','Urine'), # names on x-axis
        legend = F, # labels
        las = 1, # names on x-axis in vertical direction
        ylim = c(0,20), # values on y-axis would be from 0-20
        col = c(0:3), # color of bars
        main = "Distribution of E. coli Isolates by Source", # heading
        xlab = "Isolation origin", # X-axis label
        ylab = "Number of Samples" # Y-axis labels
)

# insight from barplot
# - animal isolates dominates -> this suggests that data lean heavily towards zoonotic surveillance, It is not purely clinical.
# - urine and blood samples are too significant -> it means dataset has strong medical relevance too
# - feces isolated are least represented -> gut commensal strains are present but not main focus

# Pie chart
pie(isolation_origin_freq,
    col = c(0:3), # colors
    labels  = c('Animal','Blood','Feces','Urine'),
    radius = 1, 
    clockwise = T,# direction
    lty = 3 # dotted boundary
    
)

# ----------------------------------------------------------------------

# ggplot

install.packages("ggplot2")
install.packages("dplyr", dependencies = TRUE)

remove.packages("rlang")
install.packages("rlang")
library(ggplot2)
library(dplyr)

# ----------------------------------------------------------------------

# boxplot
boxplot(x = bacteria$carb_fit,
        notch = T,
        main = "My First Boxplot",
        ylim = c(0,1.5),
        ylab = 'Fitness',
        xlab = "Carbenicillin",
        col = 3
)

# biological insight
# Median line is around 1, most isolates have fitness around 1
# whiskers go from ~0.2 to ~1.5, some isolates grow poorly, some grow very well
# the box is wide(IQR), there is variability among isolates

# ----------------------------------------------------------------------

# Density plot

plot(density(x=bacteria$carb_fit))

# Biological Insight
# The carb_fit show a biomodal distribution, suggesting the presence of two distinct sub populations with different exposure to Carbenicillin exposure.
# Peak 1 (~0.4-0.5) : likely represent --> Carbenicillin-sensitive isolated, reduced growth under antibiotic stress
# Peak 2 (~1.1-1.2) : likely represent --> resistant isolates, able to maintain/increase growth

# ----------------------------------------------------------------------

# Scatter plot
plot(x=bacteria$C1,
     y=bacteria$C2,
     xlim = c(0,10),
     ylim = c(0,10),
     xlab = 'PCA1',
     ylab = 'PCA2',
     main = 'PCA Plot',
     las = 1,
     col = as.factor(bacteria$labels),
     pch = 19,
     cex = 0.8
     )

# Heatmap
library(pheatmap)

pheatmap(mat = bacteria[,8:13],
         border_color = 'black',
         legend = T,
         labels_row = bacteria$sample_id,
         fontsize_row = 4,
         cluster_cols = T,
         cluster_rows = T
         )
# ----------------------------------------------------------------------

#ggplot

#BOXPLOT

library(ggplot2)
ggplot(bacteria,
       aes(x="Carbenicillin", y=carb_fit))+
       geom_boxplot(notch=TRUE, fill='lightgray')+
       labs(
         x='',
         y="Fitness",
         title = "Distribution of Carbenicillin Fitness"
       )+
         theme_minimal()
       
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#DENSITY PLOT

ggplot(bacteria,
       aes(x=carb_fit))+
  geom_density(fill='steelblue',alpha=0.5)+
  labs(
    x='Fitness',
    y='Density',
    title = 'Density of Carbenicillin Fitness'
  )+
  theme_minimal()

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# BOXPLOT by category
# By Isolation origin

ggplot(bacteria,
       aes(x=Isolation.origin, y=carb_fit))+
  geom_boxplot()+
  labs(
    x = "Isolation Origin",
    y = "Fitness",
    title = "Fitness by Isolation Origin"
  )+
  theme_minimal()


#By Phenotype

ggplot(bacteria,
       aes(x=Phenotype, y=carb_fit))+
  geom_boxplot()+
  labs(
    x = 'Phenotype',
    y = 'Fitness',
    title = "Fitness by Phenotype"
  )+
  theme_minimal()

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# SCATTER PLOT

ggplot(bacteria,
       aes(x=C1,y=C2))+
  geom_point()+
  labs(
    x='C1',
    y='C2',
    title = 'Scatter Plot of C1 vs C2'
  )+
  theme_minimal()


# PCA-style scatter with color labels

ggplot(bacteria,
       aes(x=C1, y=C2, color = as.factor(labels)))+
  geom_point(size = 1, alpha = 0.7)+
  coord_cartesian(xlim = c(0,10), ylim = c(0,10))+
  labs(
    x = 'PC1',
    y = 'PC2',
    color = "Label",
    title = "PC Plot"
  )+
  theme_minimal()

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Heatmap



install.packages('vctrs')
install.packages('tidyr')
install.packages("tidyverse")
install.packages('dplyr')

library(tidyverse)

#Step 1: Reshape data
heatmap_df <- bacteria%>%
  select(sample_id,8:13)%>%
  pivot_longer(
    cols = -sample_id,
    names_to = "Variable",
    values_to = 'Value'
  )


# Step 2: Plot

ggplot(heatmap_df,
       aes(x= Variable, y= sample_id, fill= Value))+
  geom_tile(color="black")+
  scale_fill_gradient(low="white", high="red")+
  labs(
    x="",
    y="",
    title="Heatmap of Selected Features"
  )+
  theme_minimal()+
  theme(axis.text.y= element_text(size=6))

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
