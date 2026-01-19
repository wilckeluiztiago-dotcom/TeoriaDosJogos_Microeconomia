# Módulo 06: Concorrência Monopolística (Diferenciação)
# Autor: Luiz Tiago Wilcke
# Descrição: Curto vs Longo Prazo em mercados com produtos diferenciados (ex: Restaurantes, Marcas de Roupa).

source("R/00_setup_theme.R")

# No curto prazo, age como monopólio. No longo prazo, a demanda contrai até tangenciar o custo médio (Lucro Econômico Zero).

# Função de Custo Médio (U-shaped)
# C(Q) = 100 + 10Q + Q^2 -> CMe = 100/Q + 10 + Q
# Cmg = 10 + 2Q
custo_total <- function(q) { 100 + 10 * q + q^2 }
custo_medio <- function(q) { 100/q + 10 + q }
custo_marginal <- function(q) { 10 + 2 * q }

# Demanda Curto Prazo (Alta): P = 80 - 2Q
demanda_cp <- function(q) { 80 - 2 * q }
rmg_cp <- function(q) { 80 - 4 * q }

# Equilíbrio CP: Rmg = Cmg -> 80 - 4Q = 10 + 2Q -> 70 = 6Q -> Q = 11.66
q_cp <- 70 / 6
p_cp <- demanda_cp(q_cp)
lucro_cp <- (p_cp - custo_medio(q_cp)) * q_cp

# Demanda Longo Prazo (Baixa/Deslocada): Tangencia o CMe.
# Para tangenciar, P = CMe e Inclinação Demanda = Inclinação CMe.
# Vamos apenas ilustrar deslocando a curva para baixo visualmente.
demanda_lp <- function(q) { 50 - 2 * q } # Deslocamento ilustrativo

# Plotagem
df_mc <- data.frame(q = seq(2, 25, length.out = 200))
df_mc$CMe <- custo_medio(df_mc$q)
df_mc$CMg <- custo_marginal(df_mc$q)
df_mc$Demanda_CP <- demanda_cp(df_mc$q)
df_mc$Rmg_CP <- rmg_cp(df_mc$q)

# Limitar range Y para visualização
p6 <- ggplot(df_mc, aes(x = q)) +
  geom_line(aes(y = CMe, color = "Custo Médio"), size = 1.2) +
  geom_line(aes(y = CMg, color = "Custo Marginal"), size = 1, linetype = "dashed") +
  geom_line(aes(y = Demanda_CP, color = "Demanda (Curto Prazo)"), size = 1.2) +
  
  # Área de Lucro
  annotate("rect", xmin = 0, xmax = q_cp, ymin = custo_medio(q_cp), ymax = p_cp, alpha = 0.2, fill = "green") +
  annotate("text", x = q_cp/2, y = (p_cp + custo_medio(q_cp))/2, label = "Lucro\nEcon.", fontface = "bold") +
  
  scale_color_manual(values = c("Custo Médio" = "black", "Custo Marginal" = "red", "Demanda (Curto Prazo)" = "blue")) +
  labs(title = "Módulo 06: Concorrência Monopolística (Curto Prazo)",
       subtitle = "Empresa obtém lucro devido à diferenciação, atraindo novas firmas no longo prazo",
       x = "Quantidade",
       y = "Preço / Custos",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  ylim(0, 100)

ggsave("output/mod06_conc_monopolistica.png", plot = p6, width = 9, height = 7, bg = "white")
print("Módulo 06 executado com sucesso.")
