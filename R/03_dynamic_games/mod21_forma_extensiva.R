# Módulo 21: Jogos na Forma Extensiva (Árvore de Jogos)
# Autor: Luiz Tiago Wilcke
# Descrição: Representação visual de decisões sequenciais (Árvore).

source("R/00_setup_theme.R")

# Estrutura da Árvore:
# Nó 1 (Jogador 1): Esquerda (L) ou Direita (R)
# Se L -> Nó 2 (Jogador 2): Cima (U) ou Baixo (D) -> Payoffs (3,1), (0,0)
# Se R -> Payoff (2,2)

nodes <- data.frame(
  x = c(0, -1, 1, -2, -0.5),
  y = c(2, 1, 1, 0, 0),
  label = c("J1", "J2", "R (2,2)", "(3,1)", "(0,0)"),
  type = c("Decision", "Decision", "Terminal", "Terminal", "Terminal")
)

edges <- data.frame(
  x = c(0, 0, -1, -1),
  y = c(2, 2, 1, 1),
  xend = c(-1, 1, -2, -0.5),
  yend = c(1, 1, 0, 0),
  label = c("L", "R", "U", "D")
)

p21 <- ggplot() +
  geom_segment(data = edges, aes(x = x, y = y, xend = xend, yend = yend), size = 1) +
  geom_text(data = edges, aes(x = (x+xend)/2, y = (y+yend)/2 + 0.1, label = label), color = "blue", fontface = "bold") +
  
  geom_point(data = nodes[nodes$type=="Decision",], aes(x = x, y = y), size = 6, color = "white", fill = "black", shape = 21) +
  geom_text(data = nodes, aes(x = x, y = y, label = label), vjust = -1, fontface = "bold") +
  
  xlim(-2.5, 1.5) + ylim(-0.5, 2.5) +
  theme_void() +
  labs(title = "Módulo 21: Jogo na Forma Extensiva", 
       subtitle = "O Jogador 1 move primeiro, depois o Jogador 2 observa e move",
       caption = "Autor: Luiz Tiago Wilcke")

ggsave("output/mod21_forma_extensiva.png", plot = p21, width = 8, height = 6, bg="white")
print("Módulo 21 executado com sucesso.")
