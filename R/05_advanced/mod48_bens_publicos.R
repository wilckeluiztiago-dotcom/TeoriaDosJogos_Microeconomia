# Módulo 48: Bens Públicos e o Problema do Carona (Free Rider)
# Autor: Luiz Tiago Wilcke
# Descrição: Contribuição voluntária para um bem comum. O equilíbrio de Nash é contribuir zero.

source("R/00_setup_theme.R")

# N Jogadores. Cada um tem dotação 20.
# Decide contribuir c_i para o pote.
# O pote é multiplicado por F (Fator > 1 e F < N) e dividido igualmente.
# Payoff i = (20 - c_i) + (Sum(c) * F) / N
# Custo Marginal de contribuir = 1. Retorno Marginal = F/N.
# Se F/N < 1, não contribuir é dominante.

N <- 4
Fator <- 1.6 # F/N = 0.4 < 1. Nash = 0.
rodadas <- 10

# Simulação com decaimento típico experimental
# Rodada 1: 50-60% de contribuição. Rodada 10: < 10%.
media_contribuicao <- 20 * exp(-0.3 * (1:rodadas)) # Modelo Exponencial Decrescente ajustado

df_public <- data.frame(Rodada = 1:rodadas, Contribuicao = media_contribuicao)

p48 <- ggplot(df_public, aes(x = Rodada, y = Contribuicao)) +
  geom_line(size = 1.5, color = "#009c3b") +
  geom_point(size = 4, color = "#009c3b") +
  
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  annotate("text", x = 2, y = 1, label = "Nash (0)", color = "red", vjust = -1) +
  
  labs(title = "Módulo 48: Jogo dos Bens Públicos",
       subtitle = "A cooperação inicial decai conforme os participantes percebem os 'caronas' (Free Riders)",
       x = "Rodada",
       y = "Contribuição Média ($)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  ylim(0, 20)

ggsave("output/mod48_bens_publicos.png", plot = p48, width = 8, height = 6, bg="white")
print("Módulo 48 executado com sucesso.")
