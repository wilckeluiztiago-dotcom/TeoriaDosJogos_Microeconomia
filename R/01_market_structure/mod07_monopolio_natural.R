# Módulo 07: Monopólio Natural e Regulação
# Autor: Luiz Tiago Wilcke
# Descrição: Economias de escala onde o Custo Médio é decrescente, justificando infraestrutura única (ex: Saneamento, Transmissão de Energia).

source("R/00_setup_theme.R")

# Função de Custo com Alto Custo Fixo e Baixo Custo Marginal
CF <- 1000
Cmg <- 10
custo_total_nat <- function(q) { CF + Cmg * q }
custo_medio_nat <- function(q) { CF/q + Cmg }

# Demanda
demanda <- function(q) { 100 - 0.5 * q }

# Plotagem
df_nat <- data.frame(q = seq(10, 150, length.out = 100))
df_nat$CMe <- custo_medio_nat(df_nat$q)
df_nat$Cmg <- Cmg
df_nat$Demanda <- demanda(df_nat$q)

p7 <- ggplot(df_nat, aes(x = q)) +
  geom_line(aes(y = CMe, color = "Custo Médio (Decrescente)"), size = 1.2) +
  geom_line(aes(y = Cmg, color = "Custo Marginal"), size = 1.2, linetype = "dashed") +
  geom_line(aes(y = Demanda, color = "Demanda"), size = 1.2) +
  
  # Preço de Regulação (P = Cmg) -> Prejuízo
  annotate("point", x = 180, y = 10,  color = "red") + # (Ilustrativo)
  
  scale_color_manual(values = c("Custo Médio (Decrescente)" = "#009c3b", "Custo Marginal" = "#C8102E", "Demanda" = "#002776")) +
  labs(title = "Módulo 07: Monopólio Natural",
       subtitle = "Custo Médio sempre decrescente: Uma única firma é mais eficiente, mas precisa de regulação",
       x = "Quantidade de Clientes",
       y = "Custos / Preço",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  ylim(0, 100)

ggsave("output/mod07_monopolio_natural.png", plot = p7, width = 8, height = 6, bg = "white")
print("Módulo 07 executado com sucesso.")
