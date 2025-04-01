# Load required packages
library(ggplot2)
library(dplyr)
library(tidyr)
library(knitr)

# Set seed for reproducibility
set.seed(123)

# Monte Carlo simulation function
monte_carlo_t_test <- function(distribution, n, mu0, alpha = 0.05, n_sim = 10000) {
  p_values <- numeric(n_sim)
  
  for (i in 1:n_sim) {
    if (distribution == "chisq") {
      x <- rchisq(n, df = 1)
    } else if (distribution == "uniform") {
      x <- runif(n, min = 0, max = 2)
    } else if (distribution == "exponential") {
      x <- rexp(n, rate = 1)
    }
    
    test_result <- t.test(x, mu = mu0, alternative = "two.sided")
    p_values[i] <- test_result$p.value
  }
  
  empirical_alpha <- mean(p_values < alpha)
  return(empirical_alpha)
}

# True means for each distribution
mu0_chisq <- 1          # Mean of χ²(1)
mu0_uniform <- 1         # Mean of Uniform(0,2)
mu0_exponential <- 1     # Mean of Exponential(1)

# Simulation parameters
sample_sizes <- c(5, 10, 20, 30, 50, 100)
alpha <- 0.05
n_sim <- 10000

# Run simulations for all distributions and sample sizes
results <- expand.grid(
  distribution = c("chisq", "uniform", "exponential"),
  n = sample_sizes,
  empirical_alpha = NA,
  stringsAsFactors = FALSE
)

for (i in 1:nrow(results)) {
  mu0 <- switch(results$distribution[i],
                "chisq" = mu0_chisq,
                "uniform" = mu0_uniform,
                "exponential" = mu0_exponential)
  
  results$empirical_alpha[i] <- monte_carlo_t_test(
    distribution = results$distribution[i],
    n = results$n[i],
    mu0 = mu0,
    alpha = alpha,
    n_sim = n_sim
  )
}

# Add distribution names for plotting
results <- results %>%
  mutate(distribution_name = case_when(
    distribution == "chisq" ~ "χ²(1)",
    distribution == "uniform" ~ "Uniform(0,2)",
    distribution == "exponential" ~ "Exponential(1)",
    TRUE ~ as.character(distribution)
  ))

# Create visualization
ggplot(results, aes(x = n, y = empirical_alpha, color = distribution_name)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  geom_hline(yintercept = alpha, linetype = "dashed", color = "red") +
  scale_x_continuous(trans = "log10", breaks = sample_sizes) +
  scale_y_continuous(limits = c(0, 0.1)) +
  labs(
    title = "Empirical Type I Error Rate of t-test Under Non-Normal Distributions",
    subtitle = paste("Monte Carlo simulation with", n_sim, "replications per condition"),
    x = "Sample Size (log scale)",
    y = "Empirical Type I Error Rate",
    color = "Distribution"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

# Create results table
results_table <- results %>%
  select(Distribution = distribution_name, 
         `Sample Size` = n, 
         `Empirical α` = empirical_alpha) %>%
  mutate(`Empirical α` = round(`Empirical α`, 4))

kable(results_table, caption = "Empirical Type I Error Rates Across Conditions")
