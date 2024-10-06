# Read in data
df = read.csv("mendel_data.csv")
library(tidyverse)
head(df)
count(df,cross,generation)

# Count F1 phenotypes of monohybrid cross A
df_A_F1 <- df %>% filter(cross=='A' & generation=='F1')
count(df_A_F1,seed.shape, seed.color,pod.fuzz)

# Visualize plant height phenotypes F1s
ggplot(df_A_F1, aes(x=height.cm.)) + geom_density()

# Count F2 phenotypes of monohybrid cross A
df_A_F2 <- df %>% filter(cross=='A' & generation=='F2')
count(df_A_F2,seed.shape)
count(df_A_F2,seed.color)
count(df_A_F2,pod.fuzz)

# Visualize plant height phenotypes F2s
ggplot(df_A_F2, aes(x=height.cm.)) + geom_density()

# Create categorical variable for height
df_A_F2$plant.height <- ifelse(df_A_F2$height.cm. >= 75, "Tall", "Dwarf")
count(df_A_F2,plant.height)

# Count phenotypes of the test cross
df_TC_F1 <- df %>% filter(cross=='TC' & generation=='F1')
count(df_TC_F1,seed.shape)
count(df_TC_F1,seed.color)
count(df_TC_F1,pod.fuzz)

# Visualize plant height phenotypes 
ggplot(df_TC_F1, aes(x=height.cm.)) + geom_density()

# Create categorical variable for height
df_TC_F1$plant.height <- ifelse(df_TC_F1$height.cm. >= 75, "Tall", "Dwarf")
count(df_TC_F1,plant.height)

# Complete Chi-Square 
height_color <- df_TC_F1 %>% count(seed.color, plant.height) 
height_color
wide <- spread(height_color,seed.color,n)
wide

row.names(wide) <- wide$plant.height
wide <- wide[,2:3]
wide
chi <- chisq.test(wide)
chi

# ANOVA test on Plant Height of Progeny
# Create new variable for progeny group
df$progeny.group <- ifelse(df$plant.ID >= 100 & df$plant.ID <= 200, "B",
                           ifelse(df$plant.ID <= 100, "A", "C"))
df %>% ggplot(aes(x = progeny.group, y = height.cm.)) + geom_boxplot()
aov <- aov(height.cm. ~ progeny.group, data = df)
summary(aov)
plot(aov)

