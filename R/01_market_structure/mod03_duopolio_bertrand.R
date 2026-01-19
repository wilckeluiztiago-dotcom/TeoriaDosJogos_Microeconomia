# Módulo 03: Duopólio de Bertrand (Competição por Preço)
# Autor: Luiz Tiago Wilcke
# Descrição: Simula a competição por preços, onde o equilíbrio leva ao custo marginal (Paradoxo de Bertrand).

source("R/00_setup_theme.R")

# Cenário: Duas empresas vendendo produtos homogêneos (ex: Gasolina em postos vizinhos)
mc <- 4.50 # Custo marginal do litro da gasolina
p_monopolio <- 6.00 # Preço que maximizaria o lucro conjunto (cartel)

# Em Bertrand com produtos homogêneos:
# Se P1 > P2 -> D1 = 0, D2 = Mercado
# Se P1 < P2 -> D1 = Mercado, D2 = 0
# Se P1 = P2 -> Dividem o mercado

# Função de lucro da empresa 1 dado p2
lucro_bertrand <- function(p1, p2, mc) {
  if (p1 > p2) {
    return(0)
  } else if (p1 < p2) {
    if (p1 < mc) return(p1 - mc) # Prejuízo proporcional (simplificado)
    return(100 * (p1 - mc)) # Lucro total (supor demanda fixa 100 para simplificar visualização)
  } else {
    return(50 * (p1 - mc)) # Divide mercado
  }
}

# Criar dados para uma "Matriz de Payoff" contínua visualizada
precos <- seq(4, 6.5, by = 0.05)
grid <- expand.grid(P1 = precos, P2 = precos)

# Calcular lucro da Empresa 1 para cada combinação
grid$Lucro1 <- mapply(lucro_bertrand, grid$P1, grid$P2, mc)

# Plotagem: Mapa de Calor dos Lucros da Empresa 1
p3 <- ggplot(grid, aes(x = P1, y = P2, fill = Lucro1)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "#002776") +
  geom_vline(xintercept = mc, linetype = "dashed", color = "red", size = 1) +
  geom_hline(yintercept = mc, linetype = "dashed", color = "red", size = 1) +
  annotate("text", x = mc + 0.1, y = 6.4, label = "Custo Marginal (Nash)", color = "red", angle = 90) +
  
  labs(title = "Módulo 03: Modelo de Bertrand e Guerra de Preços",
       subtitle = "Lucro da Empresa 1: A melhor resposta é sempre P2 - epsilon (até Cmg)",
       x = "Preço Empresa 1",
       y = "Preço Empresa 2",
       fill = "Lucro Emp 1",
       caption = "Autor: Luiz Tiago Wilcke | Teoria dos Jogos e Microeconomia") +
  theme_economico()

ggsave("output/mod03_duopolio_bertrand.png", plot = p3, width = 9, height = 7, bg = "white")
print("Módulo 03 executado com sucesso.")
