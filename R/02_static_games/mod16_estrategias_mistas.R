# Módulo 16: Estratégias Mistas (Solução do Jogo de Fiscalização)
# Autor: Luiz Tiago Wilcke
# Descrição: Cálculo das probabilidades de equilíbrio para o jogo do Módulo 15.

source("R/00_setup_theme.R")

# Payoffs do Auditor (uA)
# Se Contribuinte joga Sonegar com prob p e Cumprir com (1-p)
# E(uA | Fiscalizar) = p(10) + (1-p)(-2) = 10p - 2 + 2p = 12p - 2
# E(uA | Nada) = p(-10) + (1-p)(0) = -10p
# No equilíbrio misto, E(uA | F) = E(uA | N)
# 12p - 2 = -10p -> 22p = 2 -> p* (Sonegar) = 2/22 = 1/11 ~= 9%

# Payoffs do Contribuinte (uC)
# Se Auditor joga Fiscalizar com prob q e Nada com (1-q)
# E(uC | Sonegar) = q(-10) + (1-q)(10) = -10q + 10 - 10q = 10 - 20q
# E(uC | Cumprir) = q(0) + (1-q)(0) = 0
# No equilíbrio: 10 - 20q = 0 -> 20q = 10 -> q* (Fiscalizar) = 0.5

# Plot das Funções de Payoff Esperado do Contribuinte
q_range <- seq(0, 1, 0.01)
e_val_sonegar <- 10 - 20 * q_range
e_val_cumprir <- rep(0, length(q_range))

df_mixed <- data.frame(q = q_range, EV_Sonegar = e_val_sonegar, EV_Cumprir = e_val_cumprir)

p16 <- ggplot(df_mixed, aes(x = q)) +
  geom_line(aes(y = EV_Sonegar, color = "Esperado Sonegar"), size = 1.2) +
  geom_line(aes(y = EV_Cumprir, color = "Esperado Cumprir"), size = 1.2) +
  
  geom_vline(xintercept = 0.5, linetype = "dashed", size = 1) +
  annotate("text", x = 0.5 + 0.15, y = 5, label = "Nash Misto (q=0.5)", fontface = "bold") +
  
  scale_color_manual(values = c("Esperado Sonegar" = "#C8102E", "Esperado Cumprir" = "#002776")) +
  labs(title = "Módulo 16: Equilíbrio em Estratégias Mistas",
       subtitle = "Contribuinte é indiferente entre Sonegar e Cumprir quando Auditor fiscaliza 50% das vezes",
       x = "Probabilidade de Fiscalização (q)",
       y = "Payoff Esperado do Contribuinte",
       color = "Estratégia",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod16_estrategias_mistas.png", plot = p16, width = 8, height = 6, bg="white")
print("Módulo 16 executado com sucesso.")
