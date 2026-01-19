# Módulo 22: Indução Reversa (Solução de Jogos Sequenciais)
# Autor: Luiz Tiago Wilcke
# Descrição: Resolvendo o jogo de trás para frente.

source("R/00_setup_theme.R")

# Jogo do Módulo 21
# Estágio 2: J2 escolhe entre U (1) e D (0). Escolhe U.
# Payoff implícito para J1 se escolher L é o payoff de (L, U) -> 3.
# Estágio 1: J1 escolhe entre L (Resulta em 3) e R (Resulta em 2).
# J1 escolhe L.
# SPNE: (L, U)

dados_inducao <- data.frame(
  Passo = c("1. Último Nó (J2)", "2. Decisão J2", "3. Nó Raiz (J1)", "4. Decisão J1"),
  Descricao = c("J2 escolhe entre Payoff 1 (U) e 0 (D)", "J2 racional escolhe U", "J1 antecipa que J2 escolherá U", "J1 compara 3 (se L) vs 2 (se R) -> Escolhe L"),
  Ordem = 1:4
)

p22 <- ggplot(dados_inducao, aes(x = 1, y = max(Ordem) - Ordem + 1)) +
  geom_text(aes(label = Passo), x = 0.6, hjust = 0, fontface = "bold", size = 5) +
  geom_text(aes(label = Descricao), x = 0.6, y = max(dados_inducao$Ordem) - dados_inducao$Ordem + 0.6, hjust = 0, color = "gray30", size = 4) +
  theme_void() + 
  xlim(0.5, 2) +
  labs(title = "Módulo 22: Algoritmo de Indução Reversa",
       subtitle = "Processo Lógico de Resolução",
       caption = "Autor: Luiz Tiago Wilcke")

ggsave("output/mod22_inducao_reversa.png", plot = p22, width = 8, height = 4, bg="white")
print("Módulo 22 executado com sucesso.")
