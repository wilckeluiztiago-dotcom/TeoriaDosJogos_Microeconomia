# Módulo 28: Jogos Repetidos Infinitos (Grim Trigger)
# Autor: Luiz Tiago Wilcke
# Descrição: Condição de sustentabilidade de Cartel (Cooperação) com horizonte infinito (Fator de Desconto).

source("R/00_setup_theme.R")

# Payoffs (Dilema do Prisioneiro): 
# Cooperar (C) = 10
# Trair (D) = 15 (vs C) ou 5 (vs D)
# Punicao (P) = 5

# Valor Presente da Cooperação Eterna: V_c = 10 / (1 - delta)
# Valor Presente da Traição (Trai hoje, punido para sempre): V_d = 15 + (delta * 5) / (1 - delta)

# Cooperação Sustentável se V_c >= V_d
# 10/(1-d) >= 15 + 5d/(1-d)
# 10 >= 15(1-d) + 5d -> 10 >= 15 - 15d + 5d -> 10d >= 5 -> d >= 0.5

deltas <- seq(0.1, 0.9, 0.01)
vp_coop <- 10 / (1 - deltas)
vp_defect <- 15 + (deltas * 5) / (1 - deltas)

df_grim <- data.frame(Delta = deltas, VP_Coop = vp_coop, VP_Traicao = vp_defect)

p28 <- ggplot(df_grim, aes(x = Delta)) +
  geom_line(aes(y = VP_Coop, color = "Cooperar Sempre"), size = 1.2) +
  geom_line(aes(y = VP_Traicao, color = "Trair e ser Punido"), size = 1.2) +
  
  geom_vline(xintercept = 0.5, linetype = "dashed") +
  annotate("text", x = 0.55, y = 100, label = "Limiar Crítico (Delta = 0.5)", hjust = 0, fontface = "bold") +
  
  scale_color_manual(values = c("Cooperar Sempre" = "#009c3b", "Trair e ser Punido" = "#C8102E")) +
  
  labs(title = "Módulo 28: Sustentabilidade de Cartéis (Grim Trigger)",
       subtitle = "Se o futuro é importante (Delta > 0.5), cooperar é melhor que trair",
       x = "Fator de Desconto (Paciência)",
       y = "Valor Presente dos Payoffs",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  ylim(0, 200)

ggsave("output/mod28_jogos_repetidos_infinitos.png", plot = p28, width = 8, height = 6, bg="white")
print("Módulo 28 executado com sucesso.")
