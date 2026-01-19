# Módulo 05: Formação de Cartéis e Colusão
# Autor: Luiz Tiago Wilcke
# Descrição: Analisa o lucro conjunto de cartel vs competição e o incentivo ao desvio (traição).

source("R/00_setup_theme.R")

# Parâmetros
a <- 100
b <- 1
mc <- 20

# 1. Solução de Cartel (Monopólio Compartilhado)
# Maximiza Lucro Conjunto (Q = q1 + q2)
Q_cartel <- (a - mc) / (2 * b)
q_indiv_cartel <- Q_cartel / 2
preco_cartel <- a - b * Q_cartel
lucro_indiv_cartel <- (preco_cartel - mc) * q_indiv_cartel

# 2. Solução de Traição (Um mantém acordo, outro otimiza como Cournot)
# Se Emp 2 mantém q = 20, Emp 1 joga sua Melhor Resposta a 20.
q_traicao <- (a - mc - b * q_indiv_cartel) / (2 * b)
preco_traicao <- a - b * (q_traicao + q_indiv_cartel)
lucro_traidor <- (preco_traicao - mc) * q_traicao
lucro_traido <- (preco_traicao - mc) * q_indiv_cartel

# 3. Solução de Cournot (Ambos traem/competem)
q_cournot <- (a - mc) / (3 * b)
preco_cournot <- a - b * (2 * q_cournot)
lucro_cournot <- (preco_cournot - mc) * q_cournot

# Tabela de Payoffs para Gráfico de Barras
df_payoffs <- data.frame(
  Cenario = c("Cartel (Cooperação)", "Traição (Melhor p/ Mim)", "Vítima da Traição", "Competição (Nash)"),
  Lucro = c(lucro_indiv_cartel, lucro_traidor, lucro_traido, lucro_cournot),
  Cor = c("Cooperação", "Traição", "Derrota", "Competição")
)

df_payoffs$Cenario <- factor(df_payoffs$Cenario, levels = c("Traição (Melhor p/ Mim)", "Cartel (Cooperação)", "Competição (Nash)", "Vítima da Traição"))

p5 <- ggplot(df_payoffs, aes(x = Cenario, y = Lucro, fill = Cor)) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_text(aes(label = round(Lucro, 1)), vjust = -0.5, fontface = "bold") +
  scale_fill_manual(values = c("Cooperação" = "#009c3b", "Traição" = "#C8102E", "Derrota" = "gray", "Competição" = "#002776")) +
  labs(title = "Módulo 05: Incentivos em um Cartel (Dilema)",
       subtitle = "O incentivo individual para trair (vermelho) desestabiliza o cartel",
       x = "Estratégia Adotada",
       y = "Lucro Individual",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  theme(legend.position = "none")

ggsave("output/mod05_cartel.png", plot = p5, width = 10, height = 6, bg = "white")
print("Módulo 05 executado com sucesso.")
