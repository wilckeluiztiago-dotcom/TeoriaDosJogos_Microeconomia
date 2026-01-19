# Módulo 04: Duopólio de Stackelberg (Líder e Seguidor)
# Autor: Luiz Tiago Wilcke
# Descrição: Modelo sequencial onde a empresa Líder decide a quantidade primeiro, antecipando a reação da Seguidora.

source("R/00_setup_theme.R")

# Parâmetros
a <- 200 # Demanda
b <- 1
c_lider <- 20
c_seguidor <- 20

# 1. A Seguidora observa Q_lider e maximiza seu lucro como em Cournot.
# Reação da Seguidora: q2 = (a - c2 - b*q1) / 2b

# 2. A Líder sabe disso e incorpora a função de reação no seu problema de maximização.
# Lucro1 = (a - b(q1 + q2) - c1) * q1
# Substituindo q2: Lucro1 = (a - b(q1 + (a - c2 - b*q1)/2b) - c1) * q1
# Simplificando a solução analítica para custos iguais:
# Q_lider = (a - c) / 2b (Mesmo que monopólio!)
# Q_seguidor = (a - c) / 4b

q_lider_otimo <- (a - c_lider) / (2 * b)
q_seguidor_otimo <- (a - c_seguidor - b * q_lider_otimo) / (2 * b)

# Dados para gráfico: Curvas de Isolucro da Líder e Reação da Seguidora
df_reacao_seguidor <- data.frame(q_lider = seq(0, 200, length.out=100))
df_reacao_seguidor$q_seguidor <- (a - c_seguidor - b * df_reacao_seguidor$q_lider) / (2 * b)
df_reacao_seguidor$q_seguidor[df_reacao_seguidor$q_seguidor < 0] <- 0

# Plot
p4 <- ggplot() +
  # Curva de Reação da Seguidora
  geom_line(data = df_reacao_seguidor, aes(x = q_lider, y = q_seguidor, color = "Reação Seguidora"), size = 1.2) +
  
  # Pontos de Equilíbrio
  geom_point(aes(x = q_lider_otimo, y = q_seguidor_otimo), size = 5, color = "purple") +
  annotate("text", x = q_lider_otimo + 15, y = q_seguidor_otimo + 5, 
           label = paste("Stackelberg\nLíder:", round(q_lider_otimo), "\nSeguidor:", round(q_seguidor_otimo)), 
           fontface = "bold", color = "purple") +

  # Comparação com Cournot (Simétrico)
  geom_point(aes(x = (a - 20)/(3*b), y = (a - 20)/(3*b)), size = 3, color = "gray") +
  annotate("text", x = (a - 20)/(3*b), y = (a - 20)/(3*b) - 5, label = "Cournot", color = "gray") +

  labs(title = "Módulo 04: Modelo de Stackelberg (Vantagem do Líder)",
       subtitle = "A Líder produz mais que em Cournot, forçando a Seguidora a produzir menos",
       x = "Quantidade Líder",
       y = "Quantidade Seguidora",
       color = "Legenda",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod04_stackelberg.png", plot = p4, width = 8, height = 6, bg = "white")
print("Módulo 04 executado com sucesso.")
