# Set seed to prevent getting negative height data
set.seed(321)

# Create cross A F1 data
df_a_f1<- data.frame(matrix(NA, ncol=7, nrow=100))
colnames(df_a_f1) <- c('plant.ID', 'cross','generation', 'seed.shape', 'seed.color', 'pod.fuzz',
                     'height.cm.')
df_a_f1$plant.ID <- 1:nrow(df_a_f1)
df_a_f1$cross <- "A"
df_a_f1$generation <- "F1"
df_a_f1$seed.shape <- "Round"
df_a_f1$seed.color <- "Yellow"
df_a_f1$pod.fuzz <- ifelse(df_a_f1$plant.ID >= 66,"N","Y")
df_a_f1$height.cm. <- round((rnorm(nrow(df_a_f1),mean = 125, sd = 13)), digits=2)

# Create cross A F2 data
df_a_f2<- data.frame(matrix(NA, ncol=7, nrow=100))
colnames(df_a_f2) <- c('plant.ID', 'cross', 'generation', 'seed.shape', 'seed.color', 'pod.fuzz',
                     'height.cm.')
df_a_f2$plant.ID <- 100 + 1:nrow(df_a_f2)
df_a_f2$cross <- "A"
df_a_f2$generation <- "F2"
df_a_f2$seed.shape <- ifelse(df_a_f2$plant.ID <= 176, 'Round', 'Wrinkled')
df_a_f2$seed.color <- ifelse(df_a_f2$plant.ID <= 138 | df_a_f2$plant.ID >= 163, 'Yellow', 'Green')
df_a_f2$pod.fuzz <- ifelse(df_a_f2$plant.ID <= 110, 'Y', 'N')
df_a_f2$height.cm. <- ifelse(df_a_f2$plant.ID >= 125, 
                             round((rnorm(34,mean = 125, sd = 13)), digits=2),
                             round((rnorm(66,mean = 40, sd = 10)), digits=2))
# Randomize the order of groups
df_a_f2 <- df_a_f2[sample(1:nrow(df_a_f2)), ]
# Reassign plant ID
df_a_f2$plant.ID <- 100 + 1:nrow(df_a_f2)

# Create test cross data (YELLOW/ROUND/TALL/fuzz x green/wrinkled/short/no.fuzz)
df_tc_f1<- data.frame(matrix(NA, ncol=7, nrow=100))
colnames(df_tc_f1) <- c('plant.ID', 'cross', 'generation', 'seed.shape', 'seed.color', 'pod.fuzz',
                       'height.cm.')
df_tc_f1$plant.ID <- 200 + 1:nrow(df_tc_f1)
df_tc_f1$cross <- "TC"
df_tc_f1$generation <- "F1"
df_tc_f1$seed.shape <- ifelse(df_tc_f1$plant.ID <= 251, 'Round', 'Wrinkled')
df_tc_f1$seed.color <- ifelse(df_tc_f1$plant.ID <= 224 | df_tc_f1$plant.ID >= 276, 'Yellow', 'Green')
df_tc_f1$pod.fuzz <- ifelse(df_tc_f1$plant.ID <= 280, 'Y', 'N')

# Randomize before assigning heights to half
df_tc_f1 <- df_tc_f1[sample(1:nrow(df_tc_f1)), ]
# Reassign plant ID
df_tc_f1$plant.ID <- 200 + 1:nrow(df_tc_f1)

# Assign height
df_tc_f1$height.cm. <- ifelse(df_tc_f1$plant.ID >= 250, 
                             round((rnorm(50,mean = 150, sd = 13)), digits=2),
                             round((rnorm(50,mean = 40, sd = 10)), digits=2))

# Randomize again
df_tc_f1 <- df_tc_f1[sample(1:nrow(df_tc_f1)), ]
# Reassign plant ID
df_tc_f1$plant.ID <- 200 + 1:nrow(df_tc_f1)

# Bind all together
df <- bind_rows(df_a_f1, df_a_f2, df_tc_f1)

summary(df)

# Save as .csv
write.csv(df, "./mendel_data.csv", row.names = FALSE)




