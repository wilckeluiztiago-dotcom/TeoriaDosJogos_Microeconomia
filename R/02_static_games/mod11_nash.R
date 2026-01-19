# Módulo 11: Equilíbrio de Nash em Estratégias Puras
# Autor: Luiz Tiago Wilcke
# Descrição: Visualização de Melhores Respostas em Espaço Discreto.

source("R/00_setup_theme.R")

# Matriz de Payoff Genérica para exemplo de Entrada em Mercado
# (Incumbente, Entrante)
# Se Entrante ENTRA e Incumbente LUTAR: (-5, -5)
# Se Entrante ENTRA e Incumbente ACOMODAR: (5, 5)
# Se Entrante NÃO ENTRA: (10, 0)
# Vamos usar um exemplo numérico contínuo para visualização 2D de "Melhores Respostas"

# Best Response Functions (Ilustrativas)
br_player1 <- function(s2) {
  # Melhor resposta do Jogador 1 à estratégia s2 do Jogador 2
  return(ifelse(s2 > 0.5, 1, 0))
}

br_player2 <- function(s1) {
  # Melhor resposta do Jogador 2 à estratégia s1 do Jogador 1
  return(ifelse(s1 > 0.5, 1, 0))
}

# Grid para plotagem
grid <- expand.grid(S1 = seq(0, 1, 0.05), S2 = seq(0, 1, 0.05))

# Plotagem das curvas de melhor resposta discreta
p11 <- ggplot() +
  # Áreas de Dominância
  geom_rect(aes(xmin=0.5, xmax=1, ymin=0.5, ymax=1), fill="green", alpha=0.1) +
  geom_rect(aes(xmin=0, xmax=0.5, ymin=0, ymax=0.5), fill="green", alpha=0.1) +
  
  # Pontos de Equilíbrio Nash Puros
  geom_point(aes(x=0, y=0), size=6, color="red") +
  geom_point(aes(x=1, y=1), size=6, color="red") +
  
  annotate("text", x=0.1, y=0.1, label="Nash (0,0)", fontface="bold") +
  annotate("text", x=0.9, y=0.9, label="Nash (1,1)", fontface="bold") +
  
  labs(title = "Módulo 11: Equilíbrio de Nash (Coordenação)",
       subtitle = "Interseção das Melhores Respostas: Dois Equilíbrios Puros",
       x = "Estratégia Jogador 1",
       y = "Estratégia Jogador 2",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod11_nash_puras.png", plot = p11, width = 7, height = 7, bg="white")
print("Módulo 11 executado com sucesso.")
