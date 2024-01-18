library(tidyverse)
library(palmerpenguins)

# count() function of dplyr ----

# here we count how many individuals of each species we have
count(penguins, species)

# here we count how many individuals live on what island
count(penguins, island)

# counting with multile options
count(penguins, species, island)

# here is the same code as in line 7 but with a pipe %>% 
penguins %>% 
  count(species, island)

# filter() function of dplyr ----

# Filter the dataset for female penguins
filter(penguins, sex == "female")

# Filter out all female penguins
filter(penguins, sex != "female")

# Filter all penguins wit a bodymass of 4000 g or smaller
filter(penguins, body_mass_g <= 4000)

# Saving the filtered data to an object
f_penguins <- filter(penguins, sex == "female")

# Here we filter all female penguins with a body mass of 4000 g or less
filter(penguins, sex == "female" & body_mass_g <= 4000)

# Filter for multiple species
filter(penguins, species %in% c("Adelie", "Chinstrap"))

# mutate() function of dplyr ----

# Adding a new column to the dataset we call bill_factor
pen_bill <- mutate(penguins, bill_factor = bill_length_mm / bill_depth_mm)

# Changing an already existing column -> here we confert gramms to kilogramms
pen_kg <- mutate(penguins, body_mass_g = body_mass_g / 1000)

# relocate() function of dplyr ----

# Same code as in line 42 but here we extending the 
# code with pipes and moving the column we just created 
# after bill_depth_mm, you can also use .before instead 
# of .after 
pen_bill <- penguins %>% 
  mutate(bill_factor = bill_length_mm / bill_depth_mm) %>% 
  relocate(bill_factor, .after = bill_depth_mm)

# rename() function of dplyr ----

# Same code as in line 45 the code was extended by using
# pipes %>% and the column header was renamed from body_mass_g
# to body_mass_kg since we converted from g to kg
pen_kg <- penguins %>% 
  mutate(body_mass_g = body_mass_g / 1000) %>% 
  rename(body_mass_kg = body_mass_g)

# case_when() function of dplyr ----

# Here we using the mutate() function to add another column
# called weight_category. Then the case_when() function was
# used to fill the column. If penguins were havier than 4000 g
# they were classified 'heavy', otherwise 'light
mutate(penguins, weight_category = case_when(body_mass_g > 4000 ~ "heavy",
                                             TRUE ~ "light"))

# Same principle here, but a sub-category 'medium' was added
# for penguins between 3999 and 3000 gramms
penguins %>% 
  mutate(weight_category = case_when(body_mass_g > 4000 ~ "heavy",
                                     body_mass_g < 3999 & body_mass_g > 3000 ~ "medium",
                                     TRUE ~ "light"))

# group_by() and summarise() function of dplyr ----

# With this code we group the data set by penguin species
# and calculate the mean and standard deviation (sd) of
# the body mass
penguins %>% 
  group_by(species) %>% 
  summarise(mean_mass_g = mean(body_mass_g, na.rm = TRUE),
            sd_mass_g = sd(body_mass_g, na.rm = TRUE))

# Here the data set is grouped by species, island and sex
# same summarise statistics are used
penguins %>% 
  group_by(species, island, sex) %>% 
  summarise(mean_mass_g = mean(body_mass_g, na.rm = TRUE),
            sd_mass_g = sd(body_mass_g, na.rm = TRUE)) %>% 
  drop_na() # this function drops all of the NAs
