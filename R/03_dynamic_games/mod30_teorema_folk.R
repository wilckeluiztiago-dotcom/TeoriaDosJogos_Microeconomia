# Módulo 30: Teorema Folk (Conjunto de Payoffs Viáveis)
# Autor: Luiz Tiago Wilcke
# Descrição: Visualização do Conjunto Convexo de Payoffs possíveis em jogos repetidos.

source("R/00_setup_theme.R")

# Payoffs Base (Dilema Prisioneiro)
# (C,C)=(3,3), (C,D)=(0,5), (D,C)=(5,0), (D,D)=(1,1)
pontos_base <- data.frame(
  x = c(3, 0, 5, 1),
  y = c(3, 5, 0, 1),
  label = c("(C,C)", "(C,D)", "(D,C)", "(D,D) [Nash]")
)

# Convex Hull (Polígono de Payoffs Viáveis)
hull <- pontos_base[chull(pontos_base$x, pontos_base$y), ]

# Payoff Minimax (Segurança) = 1 (Se jogador trair sempre, o outro trai sempre -> 1)
# Folk Theorem: Qualquer ponto dentro do Hull e "acima" de (1,1) é um equilíbrio SPNE possível se delta -> 1.

p30 <- ggplot(pontos_base, aes(x = x, y = y)) +
  geom_polygon(data = hull, aes(x = x, y = y), fill = "lightblue", alpha = 0.3) +
  geom_point(size = 4, color = "black") +
  geom_text(aes(label = label), vjust = -0.8, fontface = "bold") +
  
  # Região Individually Rational
  annotate("rect", xmin = 1, xmax = 5, ymin = 1, ymax = 5, fill = "green", alpha = 0.2) +
  annotate("text", x = 3, y = 2, label = "Região Folk Theorem\n(Sustentável)", color = "darkgreen", fontface = "bold") +
  
  labs(title = "Módulo 30: Teorema Folk (Payoffs Viáveis)",
       subtitle = "Qualquer payoff na região verde pode ser sustentado como equilíbrio em jogos infinitos",
       x = "Payoff Jogador 1",
       y = "Payoff Jogador 2",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod30_teorema_folk.png", plot = p30, width = 7, height = 6, bg="white")
print("Módulo 30 executado com sucesso.")
