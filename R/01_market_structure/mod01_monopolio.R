# Módulo 01: Monopólio e Perda de Peso Morto
# Autor: Luiz Tiago Wilcke
# Descrição: Simula um monopólio maximizador de lucro e compara com concorrência perfeita.

source("R/00_setup_theme.R")

# Parâmetros do Modelo (Exemplo: Distribuição de Energia Elétrica em uma região isolada)
# Demanda Inversa: P = a - bQ
a <- 100 # Preço máximo de reserva
b <- 2   # Sensibilidade ao preço

# Custo Marginal (suposto constante)
cmg <- 20

# Funções
receita_total <- function(q) { (a - b * q) * q }
receita_marginal <- function(q) { a - 2 * b * q }
lucro <- function(q) { receita_total(q) - cmg * q }

# Solução de Monopólio (Rmg = Cmg)
# a - 2bQ = cmg -> 2bQ = a - cmg -> Q* = (a - cmg) / 2b
q_monopolio <- (a - cmg) / (2 * b)
p_monopolio <- a - b * q_monopolio

# Solução de Concorrência Perfeita (P = Cmg)
# a - bQ = cmg -> bQ = a - cmg -> Q* = (a - cmg) / b
q_perf <- (a - cmg) / b
p_perf <- cmg # Preço igual ao custo marginal

# Dados para Plotagem
df_plot <- data.frame(q = seq(0, q_perf * 1.2, length.out = 100))
df_plot$P <- a - b * df_plot$q
df_plot$Rmg <- a - 2 * b * df_plot$q
df_plot$Cmg <- cmg

# Plotagem
p1 <- ggplot(df_plot, aes(x = q)) +
  geom_line(aes(y = P, color = "Demanda"), size = 1.2) +
  geom_line(aes(y = Rmg, color = "Receita Marginal"), size = 1.2, linetype = "dashed") +
  geom_hline(aes(yintercept = cmg, color = "Custo Marginal"), size = 1.2) +
  
  # Ponto de Monopólio
  geom_point(aes(x = q_monopolio, y = p_monopolio), size = 4, color = "black") +
  geom_segment(aes(x = q_monopolio, xend = q_monopolio, y = 0, yend = p_monopolio), linetype = "dotted") +
  geom_segment(aes(x = 0, xend = q_monopolio, y = p_monopolio, yend = p_monopolio), linetype = "dotted") +
  annotate("text", x = q_monopolio + 2, y = p_monopolio + 5, label = "Equilíbrio Monopólio", fontface = "bold") +

  # Ponto de Concorrência Perfeita
  geom_point(aes(x = q_perf, y = p_perf), size = 4, color = "black") +
  annotate("text", x = q_perf, y = p_perf - 5, label = "Concorrência Perfeita", fontface = "bold") +
  
  scale_color_manual(values = c("Demanda" = "#002776", "Receita Marginal" = "#009c3b", "Custo Marginal" = "#C8102E")) +
  labs(title = "Módulo 01: Equilíbrio de Monopólio vs Concorrência Perfeita",
       subtitle = "Análise de Preço e Quantidade Ótima",
       x = "Quantidade (Q)",
       y = "Preço (R$)",
       color = "Legenda",
       caption = "Autor: Luiz Tiago Wilcke | Teoria dos Jogos e Microeconomia") +
  theme_economico()

# Salvar gráfico
ggsave("output/mod01_monopolio.png", plot = p1, width = 10, height = 6, bg = "white")
print("Módulo 01 executado com sucesso.")
