# Task 1
#### For the GC% calculation, make it robust enough to handle nucleotide sequences written in upper and lower case. I.e., GCATTTA and gcaTTTA should both return 25%.
```python
def gc_count(seq):
    seq = seq.upper()
    gc_count = seq.count('G') + seq.count('C')
    return (gc_count/len(seq))*100

```
# Task 2
#### Write a function that returns the molecular weight of any protein in KiloDalton
#### Let the function accept your name as an input by default
#### if your name or any input contains a non-protein character by default (such as B), return 0 for that value.

```
def protein_weight(seq="ToobaZahra"):
amino_weight = {
        'A': 89.09,  'C': 121.15, 'D': 133.10, 'E': 147.13,
        'F': 165.19, 'G': 75.07,  'H': 155.16, 'I': 131.17,
        'K': 146.19, 'L': 131.17, 'M': 149.21, 'N': 132.12,
        'P': 115.13, 'Q': 146.15, 'R': 174.20, 'S': 105.09,
        'T': 119.12, 'V': 117.15, 'W': 204.23, 'Y': 181.19
}
for amino in seq:
    if amino not in amino_weight:
        return 0

for amino_acid in seq:
    total_weight = sum(amino_weight[amino_acid])

return total_weight/1000

```

## Examples
```
print(gc_count("ATGCGARFDE"))
print(protein_weight())
print(protein_weight("ADFRTCFS"))

```