import numpy as np
import scipy.cluster.hierarchy as sch
import matplotlib.pyplot as plt

# Distance matrix from the image (corrected for formatting)
labels = ["A._bicolor", "A._fulva", "A._haemorrhoa", "A._hattorfiana", "A._marginata", "A._trimerana", "B._pascuorum"]
distance_matrix = np.array([
    [0, 0.1698, 0.161, 0.1529, 0.1215, 0.1584, 0.1509],
    [0.1698, 0, 0.1876, 0.1946, 0.2029, 0.1952, 1.852],
    [0.161, 0.1876, 0, 0.1865, 0.1907, 0.1861, 1.6416],
    [0.1529, 0.1946, 0.1865, 0, 0.1406, 0.1397, 1.6614],
    [0.1215, 0.2029, 0.1907, 0.1406, 0, 0.1365, 1.5866],
    [0.1584, 0.1952, 0.1861, 0.1397, 0.1365, 0, 1.6075],
    [0.1509, 1.852, 1.6416, 1.6614, 1.5866, 1.6075, 0]
])

# Convert the distance matrix into a condensed format needed by linkage
condensed_dist_matrix = sch.distance.squareform(distance_matrix)

# Perform hierarchical clustering using the neighbor-joining-like algorithm
linkage_matrix = sch.linkage(condensed_dist_matrix, method='average')

# Create the dendrogram
plt.figure(figsize=(10, 6))
dendrogram = sch.dendrogram(linkage_matrix, labels=labels, orientation='right')

plt.title('Phylogenetic Tree (Dendrogram)')
plt.xlabel('Distance')
plt.ylabel('Species')
plt.show()
