# Módulo 29: Estratégia Tit-for-Tat (Olho por Olho)
# Autor: Luiz Tiago Wilcke
# Descrição: Simulação simples de Tit-for-Tat contra Aleatório e Defector.

source("R/00_setup_theme.R")

# Payoffs
payoff_matrix <- matrix(c(10, 0, 15, 5), nrow=2) # C=1, D=2
# (C,C)=10, (C,D)=0, (D,C)=15, (D,D)=5

rodadas <- 50
historia_TFT <- numeric(rodadas)
historia_RND <- numeric(rodadas) # Randomico: 50% C, 50% D

# Inicialização
historia_TFT[1] <- 1 # TFT começa cooperando
set.seed(123)
historia_RND <- sample(1:2, rodadas, replace=TRUE)

pontos_TFT <- 0
pontos_RND <- 0

# Simulação
for(t in 1:rodadas) {
  acao_tft <- historia_TFT[t]
  acao_rnd <- historia_RND[t]
  
  pontos_TFT <- pontos_TFT + payoff_matrix[acao_rnd, acao_tft] # Linha=Inimigo, Col=Eu
  pontos_RND <- pontos_RND + payoff_matrix[acao_tft, acao_rnd]
  
  # Update TFT para rodada seguinte (copia o que o outro fez)
  if(t < rodadas) {
    historia_TFT[t+1] <- acao_rnd
  }
}

df_scores <- data.frame(
  Estrategia = c("Tit-for-Tat", "Random (Caótico)"),
  Pontuacao = c(pontos_TFT, pontos_RND)
)

p29 <- ggplot(df_scores, aes(x = Estrategia, y = Pontuacao, fill = Estrategia)) +
  geom_bar(stat = "identity", width = 0.5) +
  geom_text(aes(label = Pontuacao), vjust = -0.5, size = 6, fontface = "bold") +
  
  scale_fill_manual(values = c("Tit-for-Tat" = "#002776", "Random (Caótico)" = "gray")) +
  
  labs(title = "Módulo 29: Robustez do Tit-for-Tat",
       subtitle = "Tit-for-Tat reage à traição mas perdoa a cooperação, superando estratégias caóticas",
       y = "Pontuação Acumulada (50 rodadas)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  theme(legend.position = "none")

ggsave("output/mod29_tit_for_tat.png", plot = p29, width = 7, height = 6, bg="white")
print("Módulo 29 executado com sucesso.")
