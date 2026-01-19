# Módulo 10: Poder de Mercado e Índice de Lerner
# Autor: Luiz Tiago Wilcke
# Descrição: Índice de Lerner (L = (P - Cmg)/P) e relação com Elasticidade da Demanda.

source("R/00_setup_theme.R")

# L = -1 / E_d
# Quanto mais inelástica a demanda, maior o poder de mercado.

elasticidades <- seq(-5, -1.1, by = 0.1) # Demandas elásticas a inelásticas
lerner_index <- -1 / elasticidades
markup_percentual <- (lerner_index / (1 - lerner_index)) * 100

df_lerner <- data.frame(Elasticidade = elasticidades, Lerner = lerner_index, Markup = markup_percentual)

p10 <- ggplot(df_lerner, aes(x = Elasticidade, y = Lerner)) +
  geom_line(size = 2, color = "#002776") +
  geom_area(fill = "#002776", alpha = 0.2) +
  
  labs(title = "Módulo 10: Índice de Lerner e Poder de Mercado",
       subtitle = "Relação inversa entre Elasticidade da Demanda e Poder de Mercado (Markup)",
       x = "Elasticidade-Preço da Demanda (negativa)",
       y = "Índice de Lerner (Margem)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod10_poder_mercado_lerner.png", plot = p10, width = 8, height = 6, bg = "white")
print("Módulo 10 executado com sucesso.")
