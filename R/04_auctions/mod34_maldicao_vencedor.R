# Módulo 34: A Maldição do Vencedor (Winner's Curse)
# Autor: Luiz Tiago Wilcke
# Descrição: Em leilões de valor comum (ex: campo de petróleo), o vencedor é quem mais superestimou o valor.

source("R/00_setup_theme.R")

# Cenário: Valor Real do poço = 100 Milhões
# 100 Geólogos fazem estimativas com erro normal.
set.seed(42)
N <- 100
valor_real <- 100
estimativas <- rnorm(N, mean = valor_real, sd = 20)

# Quem ganha o leilão? Quem estimou mais alto (supondo lances baseados na estimativa).
vencedor_estimativa <- max(estimativas)
erro <- vencedor_estimativa - valor_real

df_curse <- data.frame(Estimativas = estimativas)

p34 <- ggplot(df_curse, aes(x = Estimativas)) +
  geom_histogram(binwidth = 5, fill = "gray80", color = "black") +
  geom_vline(xintercept = valor_real, color = "green", size = 1.5) +
  geom_vline(xintercept = vencedor_estimativa, color = "red", size = 1.5, linetype = "dashed") +
  
  annotate("text", x = valor_real, y = 10, label = "Valor Real", angle = 90, vjust = -1, color = "darkgreen") +
  annotate("text", x = vencedor_estimativa, y = 10, label = "Vencedor (Superestimou)", angle = 90, vjust = -1, color = "red") +
  
  labs(title = "Módulo 34: A Maldição do Vencedor (Pré-Sal)",
       subtitle = "O vencedor tende a ser aquele que cometeu o maior erro de otimismo",
       x = "Estimativa de Valor (Milhões R$)",
       y = "Frequência",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod34_maldicao_vencedor.png", plot = p34, width = 8, height = 6, bg="white")
print("Módulo 34 executado com sucesso.")
