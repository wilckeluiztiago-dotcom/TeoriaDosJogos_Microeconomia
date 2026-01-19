# Módulo 17: Pedra-Papel-Tesoura (Ciclos de Mercado)
# Autor: Luiz Tiago Wilcke
# Descrição: Generalização para 3 estratégias cíclicas. O único Nash é (1/3, 1/3, 1/3).

source("R/00_setup_theme.R")

# Vamos simular uma dinâmica evolutiva simples (Replicator Dynamics)
# P' = P * (Fitness_P - Media_Fitness)
# R' = R * (Fitness_R - Media_Fitness)
# S' = S * (Fitness_S - Media_Fitness)

# Matriz Payoff (R, P, S) vs (R, P, S):
#   R  P  S
# R 0 -1  1
# P 1  0 -1
# S -1 1  0

time_steps <- 100
dt <- 0.1
R <- numeric(time_steps); P <- numeric(time_steps); S <- numeric(time_steps)
R[1] <- 0.4; P[1] <- 0.5; S[1] <- 0.1 # Início fora do equilíbrio

for(t in 1:(time_steps-1)) {
  # Fitness
  fR <- 0*R[t] + (-1)*P[t] + 1*S[t]
  fP <- 1*R[t] + 0*P[t] + (-1)*S[t]
  fS <- (-1)*R[t] + 1*P[t] + 0*S[t]
  
  fAvg <- R[t]*fR + P[t]*fP + S[t]*fS
  
  # Update
  R[t+1] <- R[t] + R[t] * (fR - fAvg) * dt
  P[t+1] <- P[t] + P[t] * (fP - fAvg) * dt
  S[t+1] <- S[t] + S[t] * (fS - fAvg) * dt
  
  # Normalizar (para evitar drift numérico)
  soma <- R[t+1] + P[t+1] + S[t+1]
  R[t+1] <- R[t+1]/soma
  P[t+1] <- P[t+1]/soma
  S[t+1] <- S[t+1]/soma
}

df_rps <- data.frame(
  Tempo = 1:time_steps,
  Pedra = R,
  Papel = P,
  Tesoura = S
)
library(tidyr)
df_long <- pivot_longer(df_rps, cols = c("Pedra", "Papel", "Tesoura"), names_to = "Estrategia", values_to = "Proporcao")

p17 <- ggplot(df_long, aes(x = Tempo, y = Proporcao, color = Estrategia)) +
  geom_line(size = 1.2) +
  theme_economico() +
  scale_color_manual(values = c("Pedra" = "gray40", "Papel" = "blue", "Tesoura" = "red")) +
  
  labs(title = "Módulo 17: Dinâmica Predador-Presa (PPT)",
       subtitle = "As estratégias oscilam em torno do equilíbrio (1/3, 1/3, 1/3)",
       x = "Tempo (Iterações)",
       y = "Proporção da População usando Estratégia",
       caption = "Autor: Luiz Tiago Wilcke")

ggsave("output/mod17_pedra_papel_tesoura.png", plot = p17, width = 8, height = 6, bg="white")
print("Módulo 17 executado com sucesso.")
