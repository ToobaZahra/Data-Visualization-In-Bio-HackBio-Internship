
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