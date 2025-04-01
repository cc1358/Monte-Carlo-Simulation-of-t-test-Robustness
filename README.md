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

<img width="391" alt="Screenshot 2025-04-01 at 6 21 51 PM" src="https://github.com/user-attachments/assets/2655b9a5-a82c-49ec-a381-9a968003dca0" />
<img width="802" alt="Screenshot 2025-04-01 at 6 22 21 PM" src="https://github.com/user-attachments/assets/e0c46cdb-f6f5-4a47-a446-99aef49f9686" />
