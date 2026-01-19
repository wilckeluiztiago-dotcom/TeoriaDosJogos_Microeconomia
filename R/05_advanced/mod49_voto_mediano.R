# Módulo 49: Jogos de Votação (Teorema do Eleitor Mediano)
# Autor: Luiz Tiago Wilcke
# Descrição: Convergência de candidatos para o centro em eleições majoritárias (Modelo de Hotelling-Downs).

source("R/00_setup_theme.R")

# Distribuição de Eleitores (Normal - Esquerda vs Direita)
eleitores <- rnorm(1000, mean = 50, sd = 15) # Escala 0 a 100

# Candidatos A e B.
# Se A=20 e B=80, dividem no meio (50).
# Se A muda para 40, pega votos de 0 a 60. B perde.
# B também move para o centro.
# Equilíbrio de Nash: A=50, B=50.

df_eleitores <- data.frame(Posicao = eleitores)

p49 <- ggplot(df_eleitores, aes(x = Posicao)) +
  geom_density(fill = "gray90", alpha = 0.5) +
  
  geom_vline(xintercept = 50, color = "purple", size = 1.5, linetype = "dashed") +
  annotate("text", x = 50, y = 0.005, label = "Eleitor Mediano\nEquilíbrio de Nash", color = "purple") +
  
  # Ilustração de Posições Iniciais
  annotate("point", x = 20, y = 0, size = 5, color = "red") +
  annotate("text", x = 20, y = 0.002, label = "Cand A (Inicial)", color = "red") +
  annotate("segment", x = 22, xend = 45, y = 0.001, yend = 0.003, arrow = arrow(), color = "red") +
  
  annotate("point", x = 80, y = 0, size = 5, color = "blue") +
  annotate("text", x = 80, y = 0.002, label = "Cand B (Inicial)", color = "blue") +
  annotate("segment", x = 78, xend = 55, y = 0.001, yend = 0.003, arrow = arrow(), color = "blue") +
  
  labs(title = "Módulo 49: Teorema do Eleitor Mediano",
       subtitle = "Para maximizar votos, os candidatos convergem para a posição do eleitor mediano",
       x = "Espectro Político (0=Esq, 100=Dir)",
       y = "Densidade de Eleitores",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  xlim(0, 100)

ggsave("output/mod49_voto_mediano.png", plot = p49, width = 8, height = 6, bg="white")
print("Módulo 49 executado com sucesso.")
