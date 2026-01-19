# Módulo 33: Leilão Inglês vs Holandês
# Autor: Luiz Tiago Wilcke
# Descrição: Comparação visual da dinâmica de preços.

source("R/00_setup_theme.R")

# Inglês: Começa baixo, sobe até restar um. (Equivalente a Vickrey)
# Holandês: Começa alto, desce até alguém aceitar. (Equivalente a 1º Preço)

tempo <- 1:100
preco_reserva_vendedor <- 50
valor_privado_comprador <- 80

# Dinamica:
# Ingles: P(t) = 10 + t. Para quando P > 2º maior lance.
# Holandes: P(t) = 200 - t. Para quando P < Valor avaliado (com shading).

df_leiloes <- data.frame(Tempo = tempo)
df_leiloes$Ingles <- 10 + tempo
df_leiloes$Holandes <- 200 - tempo

p33 <- ggplot(df_leiloes, aes(x = Tempo)) +
  geom_line(aes(y = Ingles, color = "Inglês (Ascendente)"), size = 1.2) +
  geom_line(aes(y = Holandes, color = "Holandês (Descendente)"), size = 1.2) +
  
  geom_hline(yintercept = valor_privado_comprador, linetype = "dotted") +
  annotate("text", x = 10, y = 85, label = "Minha Valoração (80)", hjust = 0) +
  
  annotate("point", x = 70, y = 80, size = 4, color = "blue") +
  annotate("text", x = 70, y = 90, label = "Lance!", color = "blue") +
  
  scale_color_manual(values = c("Inglês (Ascendente)" = "#002776", "Holandês (Descendente)" = "#ffdf00")) +
  
  labs(title = "Módulo 33: Dinâmica de Preços",
       subtitle = "Inglês revela informação durante o processo. Holandês exige decisão estratégica instantânea.",
       x = "Tempo",
       y = "Preço Anunciado",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod33_ingles_holandes.png", plot = p33, width = 8, height = 6, bg="white")
print("Módulo 33 executado com sucesso.")
