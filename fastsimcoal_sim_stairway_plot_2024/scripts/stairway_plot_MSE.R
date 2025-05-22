🤔 Why use MSE?

    Penalizes large errors more heavily

        Squaring the error emphasizes large discrepancies.

        Helpful when over/underestimation has serious consequences.

    Smooth, differentiable metric

        Ideal for optimization and model fitting.

    Common in simulation benchmarking

        In Ne inference (e.g., Stairway Plot, PSMC), you might simulate known demographic histories and use MSE to quantify how well the method recovers that history.

    Log scale MSE

        When Ne spans large scales (e.g., 10³ to 10⁶), calculating MSE on log10(Ne) avoids dominance by high values.




# Step 1: Simulate example Ne values (true vs inferred)
time_points <- c(10, 100, 1000, 10000, 100000)  # generations ago

# True Ne values (e.g., from a simulation)
true_Ne <- c(10000, 5000, 10000, 20000, 30000)

# Inferred Ne values (e.g., from Stairway Plot results)
inferred_Ne <- c(9000, 7000, 12000, 15000, 25000)

# Step 2: Compute MSE
mse <- mean((log10(true_Ne) - log10(inferred_Ne))^2)
cat("MSE (log10 scale):", mse, "\n")

# Step 3: Organize data for plotting
library(ggplot2)
df <- data.frame(
  Time = time_points,
  True = true_Ne,
  Inferred = inferred_Ne
)

# Step 4: Plot Ne over time
ggplot(df, aes(x = Time)) +
  geom_line(aes(y = True, color = "True Ne"), size = 1.2) +
  geom_line(aes(y = Inferred, color = "Inferred Ne"), size = 1.2, linetype = "dashed") +
  scale_x_log10() +
  scale_y_log10() +
  labs(title = "Stairway Plot Ne Inference vs True Ne",
       subtitle = paste("MSE (log10 scale):", round(mse, 4)),
       x = "Time (generations ago)", y = "Effective population size (Ne)",
       color = "Legend") +
  theme_minimal()


******* Customize with real data ********
#    Replace true_Ne and inferred_Ne with vectors from simulations and your Stairway Plot output (often in a .csv file with time and Ne columns).
#    You can compute MSE over only overlapping time bins if needed.

# computing MSE over only overlapping time bins is common when comparing true vs inferred Ne (e.g., from Stairway Plot), 
# because the time intervals may not align exactly.

# Example: MSE with overlapping time bins using interpolation

# Step 1: Simulated time and Ne values (log10 scale recommended)
true_df <- data.frame(
  Time = c(10, 100, 1000, 10000, 100000),
  Ne = c(10000, 5000, 10000, 20000, 30000)
)

inferred_df <- data.frame(
  Time = c(50, 200, 1000, 8000, 90000),
  Ne = c(8000, 6000, 12000, 16000, 28000)
)

# Step 2: Find overlapping time range
time_min <- max(min(true_df$Time), min(inferred_df$Time))
time_max <- min(max(true_df$Time), max(inferred_df$Time))

# Step 3: Create a common sequence of time points within the overlap
common_time <- sort(unique(c(true_df$Time, inferred_df$Time)))
common_time <- common_time[common_time >= time_min & common_time <= time_max]

# Step 4: Interpolate both datasets to these common times (log10 scale)
true_interp <- approx(x = true_df$Time, y = log10(true_df$Ne), xout = common_time)$y
inferred_interp <- approx(x = inferred_df$Time, y = log10(inferred_df$Ne), xout = common_time)$y

# Step 5: Compute log-scale MSE
mse <- mean((true_interp - inferred_interp)^2)
cat("MSE over overlapping time bins (log10 scale):", round(mse, 5), "\n")

# Step 6: Optional – Plot
library(ggplot2)
plot_df <- data.frame(
  Time = rep(common_time, 2),
  log10_Ne = c(true_interp, inferred_interp),
  Source = rep(c("True", "Inferred"), each = length(common_time))
)

ggplot(plot_df, aes(x = Time, y = log10_Ne, color = Source)) +
  geom_line(size = 1.2) +
  scale_x_log10() +
  labs(
    title = "True vs Inferred Ne (Interpolated)",
    subtitle = paste("MSE (log10 scale):", round(mse, 5)),
    x = "Time (generations ago)", y = expression(log[10](Ne))
  ) +
  theme_minimal()


********** chatGPT: plot MSE with Ne trajectories **********
# Simulated true and inferred Ne values
true_df <- data.frame(
  Time = c(10, 100, 1000, 10000, 100000),
  Ne = c(10000, 5000, 10000, 20000, 30000)
)

inferred_df <- data.frame(
  Time = c(10, 100, 1000, 10000, 100000),
  Ne = c(8000, 7000, 12000, 15000, 25000)
)

# Calculate log10 Ne values
true_df$log10Ne <- log10(true_df$Ne)
inferred_df$log10Ne <- log10(inferred_df$Ne)

# Merge and compute squared error
df <- merge(true_df, inferred_df, by = "Time", suffixes = c("_True", "_Inferred"))
df$SquaredError <- (df$log10Ne_True - df$log10Ne_Inferred)^2

# Compute global MSE
global_mse <- mean(df$SquaredError)

# Plot: Ne curves and pointwise squared error as bar heights
library(ggplot2)
ggplot(df, aes(x = Time)) +
  geom_line(aes(y = Ne_True, color = "True Ne"), linewidth = 1.2) +
  geom_line(aes(y = Ne_Inferred, color = "Inferred Ne"), linetype = "dashed", linewidth = 1.2) +
  geom_bar(aes(y = 10^SquaredError), stat = "identity", fill = "red", alpha = 0.5, width = 0.1) +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title = "Ne Inference with Pointwise MSE",
    subtitle = paste("Global MSE (log10 scale):", round(global_mse, 5)),
    x = "Time (generations ago)",
    y = "Effective Population Size (Ne)",
    color = "Legend"
  ) +
  theme_minimal()


********** deepseek: plot MSE with Ne trajectories **********
# Load required libraries
library(ggplot2)
library(scales)
library(patchwork)

# Step 1: Prepare the data
true_df <- data.frame(
  Time = c(10, 100, 1000, 10000, 100000),
  Ne = c(10000, 5000, 10000, 20000, 30000)
)

inferred_df <- data.frame(
  Time = c(50, 200, 1000, 8000, 90000),
  Ne = c(8000, 6000, 12000, 16000, 28000)
)

# Step 2: Find overlapping time range and common time points
time_min <- max(min(true_df$Time), min(inferred_df$Time))
time_max <- min(max(true_df$Time), max(inferred_df$Time))
common_time <- sort(unique(c(true_df$Time, inferred_df$Time)))
common_time <- common_time[common_time >= time_min & common_time <= time_max]

# Step 3: Interpolate and calculate MSE
true_interp <- approx(x = true_df$Time, y = log10(true_df$Ne), xout = common_time)$y
inferred_interp <- approx(x = inferred_df$Time, y = log10(inferred_df$Ne), xout = common_time)$y
mse <- mean((true_interp - inferred_interp)^2)

# Step 4: Create proper data frames for plotting
# Original points
true_points <- data.frame(
  Time = true_df$Time,
  Ne = true_df$Ne,
  log10_Ne = log10(true_df$Ne),
  Source = "True",
  Type = "Original"
)

inferred_points <- data.frame(
  Time = inferred_df$Time,
  Ne = inferred_df$Ne,
  log10_Ne = log10(inferred_df$Ne),
  Source = "Inferred",
  Type = "Original"
)

# Interpolated lines
true_line <- data.frame(
  Time = common_time,
  Ne = 10^true_interp,
  log10_Ne = true_interp,
  Source = "True",
  Type = "Interpolated"
)

inferred_line <- data.frame(
  Time = common_time,
  Ne = 10^inferred_interp,
  log10_Ne = inferred_interp,
  Source = "Inferred",
  Type = "Interpolated"
)

# Combine all data
plot_df <- rbind(true_points, inferred_points, true_line, inferred_line)

# Step 5: Create the main trajectory plot
traj_plot <- ggplot(plot_df, aes(x = Time, y = Ne, color = Source)) +
  geom_line(data = subset(plot_df, Type == "Interpolated"), size = 1) +
  geom_point(data = subset(plot_df, Type == "Original"), size = 3) +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_color_manual(values = c("True" = "#E69F00", "Inferred" = "#56B4E9")) +
  labs(x = "Time (generations ago)", 
       y = expression("N"[e]),
       title = "Effective Population Size Trajectories") +
  theme_minimal() +
  theme(legend.position = "bottom")

# Step 6: Create MSE visualization
mse_df <- data.frame(
  Time = common_time,
  Squared_Error = (true_interp - inferred_interp)^2
)

mse_plot <- ggplot(mse_df, aes(x = Time, y = Squared_Error)) +
  geom_col(fill = "#009E73", alpha = 0.7) +
  geom_hline(yintercept = mse, linetype = "dashed", color = "red") +
  annotate("text", x = median(common_time), y = mse * 1.1, 
           label = paste("MSE =", round(mse, 5)), color = "red") +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  labs(x = "Time (generations ago)", 
       y = "Squared Error",
       title = "Mean Squared Error (Log10 Scale)") +
  theme_minimal()

# Step 7: Combine plots
combined_plot <- traj_plot / mse_plot + 
  plot_annotation(
    title = "Comparison of True and Inferred Ne Trajectories",
    subtitle = paste("MSE calculated on log10 scale over overlapping time range:",
                    round(mse, 5)),
    theme = theme(plot.title = element_text(hjust = 0.5, size = 14),
                plot.subtitle = element_text(hjust = 0.5))
  )

# Display the plot
print(combined_plot)