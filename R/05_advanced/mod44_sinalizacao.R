# Módulo 44: Jogos de Sinalização (Modelo de Spence)
# Autor: Luiz Tiago Wilcke
# Descrição: Educação como sinal de produtividade. Custo de diploma é menor para habilidosos.

source("R/00_setup_theme.R")

# Dois tipos: Habilidade Alta (H) e Baixa (L). Produtividade: H=20, L=10.
# Custo da Educação (anos y): C_H(y) = y, C_L(y) = 2y (Mais difícil para L).
# Salário w(y).
# Separação: w=20 se y >= y*, w=10 se y < y*.
# Condição H escolher y*: 20 - y* > 10 -> y* < 10.
# Condição L escolher 0: 10 > 20 - 2y* -> 2y* > 10 -> y* > 5.
# Equilíbrio de Separação possível para y* entre 5 e 10.

anos_estudo <- 0:12
salario <- ifelse(anos_estudo >= 6, 20, 10) # y* = 6

utilidade_H <- salario - anos_estudo
utilidade_L <- salario - 2 * anos_estudo

df_spence <- data.frame(Anos = anos_estudo, Utilidade_H = utilidade_H, Utilidade_L = utilidade_L)
library(tidyr)
df_spence_long <- pivot_longer(df_spence, cols = c("Utilidade_H", "Utilidade_L"), names_to = "Tipo", values_to = "Utilidade")

p44 <- ggplot(df_spence_long, aes(x = Anos, y = Utilidade, color = Tipo)) +
  geom_line(size = 1.2) +
  geom_vline(xintercept = 6, linetype = "dashed") +
  annotate("text", x = 6.2, y = 18, label = "Sinal Exigido (y*=6)", hjust = 0) +
  
  geom_point(data = subset(df_spence_long, Anos == 6 & Tipo == "Utilidade_H"), size = 4) +
  geom_point(data = subset(df_spence_long, Anos == 0 & Tipo == "Utilidade_L"), size = 4) +
  
  scale_color_manual(values = c("Utilidade_H" = "blue", "Utilidade_L" = "red")) +
  
  labs(title = "Módulo 44: Sinalização de Spence",
       subtitle = "Tipo H escolhe y=6 (Máx Utilidade). Tipo L prefere y=0 a y=6 (Separador).",
       x = "Anos de Educação (Custo)",
       y = "Utilidade Líquida (Salário - Custo)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod44_sinalizacao.png", plot = p44, width = 8, height = 6, bg="white")
print("Módulo 44 executado com sucesso.")
