# Módulo 38: Modelo de Barganha de Rubinstein (Tempo é Dinheiro)
# Autor: Luiz Tiago Wilcke
# Descrição: Em jogos de ofertas alternadas infinitas, quem tem mais paciência (maior delta) fica com a maior parte.

source("R/00_setup_theme.R")

# Solução de Equilíbrio SPNE:
# Jogador 1 (proponente) recebe x = (1 - delta2) / (1 - delta1 * delta2)
# Se deltas iguais: x = 1 / (1 + delta)

deltas <- seq(0.1, 0.99, 0.01)
share_proposer <- 1 / (1 + deltas)

df_rubinstein <- data.frame(Paciencia = deltas, ParteProponente = share_proposer)

p38 <- ggplot(df_rubinstein, aes(x = Paciencia, y = ParteProponente)) +
  geom_line(size = 1.5, color = "purple") +
  
  geom_hline(yintercept = 0.5, linetype = "dashed") +
  annotate("text", x = 0.8, y = 0.52, label = "Limite quando Delta -> 1 (50/50)", color = "gray30") +
  
  labs(title = "Módulo 38: Modelo de Rubinstein",
       subtitle = "A vantagem de propor primeiro diminui conforme os jogadores são mais pacientes",
       x = "Fator de Desconto (Paciência)",
       y = "Fatia do Bolo Obtida pelo Proponente (Jogador 1)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  ylim(0.45, 1)

ggsave("output/mod38_rubinstein_barganha.png", plot = p38, width = 8, height = 6, bg="white")
print("Módulo 38 executado com sucesso.")
