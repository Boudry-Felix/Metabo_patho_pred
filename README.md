# Pathology prediction

## Project Overview
This project, `patho_pred`, aims to predict pathological athletes during an altitude training camp. Various machine learning models, including k-means, hierarchical clustering (HC), principal component analysis (PCA), and partial least squares discriminant analysis (PLSDA), were employed to achieve this goal.

## Machine Learning Models
### k-means Clustering
k-means clustering is a method used to partition the dataset into distinct groups. The algorithm assigns each data point to one of the predefined clusters based on feature similarity.

### Hierarchical Clustering (HC)
Hierarchical clustering is an algorithm that groups similar objects into clusters. It builds a hierarchy from the bottom up, merging the closest clusters at each step until only one cluster remains.

### Principal Component Analysis (PCA)
PCA is a dimensionality reduction technique that transforms the data into a set of orthogonal components, capturing the maximum variance in the dataset. It is often used for exploratory data analysis and visualization.

### Partial Least Squares Discriminant Analysis (PLSDA)
PLSDA is a classification method that models the relationship between the predictors and the response variable by projecting the predictors into a new space.

## Setup and Usage
To set up and run the project, follow these steps:

1. Clone the repository:
```sh
git clone https://github.com/Boudry-Felix/patho_pred.git
cd patho_pred
```
2. Add data:

    Import your data and put them in a `Data` folder inside the project.

3. Run the analysis:
```sh
quarto preview patho_pred.qmd
```
# License

This project is licensed under the GPLv3 License. See the [LICENSE](https://github.com/Boudry-Felix/patho_pred/blob/main/LICENSE) file for details.

For more details and code implementation, you can visit the [repository](https://github.com/Boudry-Felix/patho_pred).

If you have any questions or need further assistance, feel free to contact the author at [felix.boudry@univ-perp.fr](mailto:felix.boudry@univ-perp.fr).
