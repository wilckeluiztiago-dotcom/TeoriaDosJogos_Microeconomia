# Módulo 45: Teoria dos Jogos Evolutiva (Hawk-Dove)
# Autor: Luiz Tiago Wilcke
# Descrição: Dinâmica de populacional de estratégias agressivas vs passivas (Gavião vs Pomba).

source("R/00_setup_theme.R")

# Payoffs:
# (G, G) -> (-5, -5) [Luta custosa]
# (G, P) -> (10, 0)
# (P, G) -> (0, 10)
# (P, P) -> (5, 5) [Compartilham]

# Fitness_G = p*(-5) + (1-p)*10 = -5p + 10 - 10p = 10 - 15p
# Fitness_P = p*(0) + (1-p)*5 = 5 - 5p
# Equilibrio: Fitness_G = Fitness_P
# 10 - 15p = 5 - 5p -> 5 = 10p -> p = 0.5

prob_gaviao <- seq(0, 1, 0.01)
fit_g <- 10 - 15 * prob_gaviao
fit_p <- 5 - 5 * prob_gaviao

df_evo <- data.frame(ProporcaoGaviao = prob_gaviao, FitG = fit_g, FitP = fit_p)
library(tidyr)
df_long <- pivot_longer(df_evo, cols = c("FitG", "FitP"), names_to = "Estrategia", values_to = "Fitness")

p45 <- ggplot(df_long, aes(x = ProporcaoGaviao, y = Fitness, color = Estrategia)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 0.5, linetype = "dashed") +
  annotate("text", x = 0.52, y = 8, label = "ESS (p=0.5)", hjust = 0, fontface = "bold") +
  
  scale_color_manual(values = c("FitG" = "red", "FitP" = "blue")) +
  
  labs(title = "Módulo 45: Dinâmica Evolutiva (Gavião vs Pomba)",
       subtitle = "Se houver poucos gaviões, ser gavião é vantajoso. Se muitos, melhor ser pomba.",
       x = "Proporção de Gaviões na População (p)",
       y = "Fitness Esperado (Retorno)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod45_jogo_evolutivo.png", plot = p45, width = 8, height = 6, bg="white")
print("Módulo 45 executado com sucesso.")
