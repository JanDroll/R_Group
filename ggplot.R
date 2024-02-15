library(palmerpenguins)
library(ggplot2)
library(ggthemes)
library(patchwork)
library(ggside)
library(ggdist)
library(gghalves)
library(ggridges)
library(gganimate)
library(scico)


# Basic plot with the palmer penguins data set

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point()

# Changing colors and shapes based on factor

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, col = species)) +
  geom_point()

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, col = species, shape = sex)) +
  geom_point()

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, shape = species)) +
  geom_point(aes(col = body_mass_g), size = 2, alpha = 0.8) +
  scico::scale_color_scico(palette = "lapaz", direction = -1)

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, col = species)) +
  geom_point(alpha = 0.5)

# Making box/violin plots

ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_violin()

# Changing the color of a box plot

ggplot(penguins, aes(x = species, y = body_mass_g, col = species)) +
  geom_boxplot()

ggplot(penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot()

# Bar plots

ggplot(penguins, aes(x = island)) +
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = position_dodge2())

ggplot(penguins, aes(y = island, fill = species)) +
  geom_bar(position = position_dodge2())

# Visualization of distributions Histogram / Kernel-Density / Frequency-polygons
# Histogram
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram()

ggplot(penguins, aes(x = body_mass_g, fill = species)) +
  geom_histogram()
# Frequency-polygons
ggplot(penguins, aes(x = body_mass_g)) +
  geom_freqpoly()

ggplot(penguins, aes(x = body_mass_g, col = species)) +
  geom_freqpoly()

ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

ggplot(penguins, aes(x = body_mass_g, fill = species)) +
  geom_density(alpha = 0.5)

# Changing themes
ggplot(penguins, aes(x = body_mass_g)) +
  geom_freqpoly() +
  theme_bw()

ggplot(penguins, aes(x = body_mass_g)) +
  geom_freqpoly() +
  theme_few()

# Using theme() to change single aspects about a theme

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, col = species)) +
  geom_point() +
  theme_classic() +
  theme(panel.background = element_rect(fill = "#252525"),
        plot.background = element_rect(fill = "#252525"),
        axis.title = element_text(color = "white"),
        axis.text = element_text(color = "white"),
        axis.line = element_line(colour = "white"),
        axis.ticks = element_line(colour = "white"))

# Using facet_wrap and facet_grid to separate plots

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, shape = species)) +
  geom_point(aes(col = body_mass_g), size = 2, alpha = 0.8) +
  scico::scale_color_scico(palette = "lapaz", direction = -1) +
  theme_bw() +
  facet_wrap(~island)

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, shape = species)) +
  geom_point(aes(col = body_mass_g), size = 2, alpha = 0.8) +
  scico::scale_color_scico(palette = "lapaz", direction = -1) +
  theme_bw() +
  facet_grid(species~island)

# Using patchwork to combine plots together
P1 <- ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram() +
  theme_bw()

P2 <- ggplot(penguins, aes(x = body_mass_g)) +
  geom_freqpoly() +
  theme_bw()

P3 <- ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, col = species)) +
  geom_smooth(method = "lm") +
  theme_bw()

P1 + P2

(P1 + P2) / P3 + plot_annotation(tag_levels = "a",
                                 title = "Patchwork",
                                 subtitle = "Wie man das package benutzt",
                                 caption = "Verschiedenste Anordnungen sind möglich")

# Using ggside to add side plots to your graph

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, col = species)) +
  geom_point(alpha = 0.5) +
  theme_few() +
  geom_xsideboxplot(aes(y = species), orientation = "y") +
  scale_xsidey_discrete() +
  geom_ysidedensity(aes(x = after_stat(density)), position = "stack") +
  scale_ysidex_continuous(guide = guide_axis(angle = 90), minor_breaks = NULL) +
  theme(ggside.panel.scale = 0.3)

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, col = species)) +
  geom_point(alpha = 0.5) +
  theme_few() +
  geom_xsideboxplot(aes(y = species), orientation = "y") +
  scale_xsidey_discrete() +
  geom_ysidedensity(aes(x = after_stat(density)), position = "stack") +
  scale_ysidex_continuous(guide = guide_axis(angle = 90), minor_breaks = NULL) +
  theme(ggside.panel.scale = 0.3,
        legend.position = "none") +
  facet_wrap(~species)

# The ggdist package for distributions
ggplot(penguins, aes(x = species, y = body_mass_g, col = species, fill = species)) +
  stat_halfeye(alpha = 0.75) +
  theme_bw() +
  scale_color_brewer(palette = "Dark2") +
  scale_fill_brewer(palette =  "Set2") +
  theme(legend.position = "none") +
  labs(x = "Species", y = "Body Mass (g)")

# Raincloud plots with ggdist ang gghalves
ggplot(penguins, aes(x = species, y = body_mass_g, col = species, fill = species)) +
  ggdist::stat_halfeye(alpha = 0.5, point_color = NA, .width = 0) +
  geom_boxplot(fill = "white", width = 0.1, outlier.color = NA, lwd = 0.6) +
  gghalves::geom_half_point(side = "l", alpha = 0.5, position = position_nudge(x = -0.1)) +
  theme_few() +
  theme(legend.position = "none") +
  labs(x = "Species", y = "Body Mass (g)") +
  coord_flip()
  
ggplot(penguins, aes(x = body_mass_g, y = species, fill = species)) +
  geom_density_ridges(alpha = 0.5) +
  theme_bw() +
  theme(legend.position = "none") +
  labs(x = "Body Mass (g)", y = "")

# Animate plots with gganimate
library(gapminder) # For data

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, size = pop, colour = country)) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(title = 'Year: {frame_time}', x = "BIP pro Kopf", y = "Lebenserwartung") +
  theme_bw() +
  transition_time(year) +
  shadow_wake(wake_length = 0.1, alpha = FALSE)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = continent)) +
  geom_point(alpha = 0.5, show.legend = FALSE) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  theme_few() +
  facet_wrap(~continent) +
  scale_color_brewer(palette = "Set1") +
  transition_time(year) +
  labs(title = 'Year: {frame_time}', x = 'BIP pro Kopf', y = 'Lebenserwartung')
  
