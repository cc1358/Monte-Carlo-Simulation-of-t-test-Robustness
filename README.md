# Monte-Carlo-Simulation-of-t-test-Robustness
This GitHub project investigates the robustness of the t-test to departures from normality by examining its empirical Type I error rate under three non-normal distributions. The project demonstrates statistical simulation skills in R and provides insights into when the t-test can be reliably used.


Project Overview

The project evaluates whether the t-test maintains its nominal significance level (α) when the underlying population distribution is:

χ²(1) - heavily skewed
Uniform(0,2) - symmetric but not normal
Exponential(1) - moderately skewed
For each distribution, we:

Calculate the true mean (μ₀)
Perform Monte Carlo simulations to estimate the empirical Type I error rate
Compare it to the nominal α level (typically 0.05)
Visualize the results
