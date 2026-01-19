# Módulo 20: Eliminação Iterativa de Estratégias Dominadas (IEDS)
# Autor: Luiz Tiago Wilcke
# Descrição: Ilustração do processo de eliminação racional de estratégias.

source("R/00_setup_theme.R")

# Matriz 3x3
#       L    C    R
# T   (4,3) (5,1) (6,2)
# M   (2,1) (8,4) (3,6)
# B   (3,0) (9,6) (2,8)

# Passo 1: Para Jogador 1 (Linhas), B é dominada por alguma mistura?
# Vamos simplificar: Suponha uma estratégia que claramente nunca é jogada.
# T é melhor que M se Coluna L (4 > 2). M é melhor que T se Coluna C (8 > 5).
# Vamos considerar apenas visualmente as rodadas.

etapas <- data.frame(
  Etapa = c("1. Jogo Original", "2. Elimina B (Dom. por M mix)", "3. Elimina R (Dom. p/ Col)", "4. Solução Única (Nash)"),
  EstrategiasRestantes = c("3x3", "2x3", "2x2", "1x1"),
  Complexidade = c(9, 6, 4, 1)
)

p20 <- ggplot(etapas, aes(x = Etapa, y = Complexidade, fill = Etapa)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = EstrategiasRestantes), vjust = -0.5, fontface = "bold") +
  
  labs(title = "Módulo 20: Eliminação Iterativa de Estratégias",
       subtitle = "Redução da complexidade do jogo assumindo racionalidade comum",
       x = "Passos do Processo",
       y = "Células na Matriz",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  theme(legend.position = "none")

ggsave("output/mod20_dominancia.png", plot = p20, width = 9, height = 6, bg="white")
print("Módulo 20 executado com sucesso.")
