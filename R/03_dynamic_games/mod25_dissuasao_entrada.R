# Módulo 25: Dissuasão de Entrada (Investimento em Capacidade)
# Autor: Luiz Tiago Wilcke
# Descrição: Modelo de Dixit de investimento em capacidade para dissuadir entrada.

source("R/00_setup_theme.R")

# Incumbente escolhe Capacidade K.
# Custo Marginal reduz com K até certo ponto.
# Se K for alto, o Cmg ex-post é baixo, tornando a ameaça de guerra de preços credível.

capacidade <- seq(0, 100, 1)
custo_marginal_ex_post <- 50 - 0.4 * capacidade
lucro_entrante_se_guerra <- 30 - 1.0 * custo_marginal_ex_post # Simplificado

df_deterrence <- data.frame(
  Capacidade = capacidade,
  Cmg = custo_marginal_ex_post,
  Lucro_Entrante = lucro_entrante_se_guerra
)

df_deterrence$Entrada <- ifelse(df_deterrence$Lucro_Entrante > 0, "Ocorre", "Bloqueada")

p25 <- ggplot(df_deterrence, aes(x = Capacidade)) +
  geom_line(aes(y = Lucro_Entrante), size = 1.2, color = "purple") +
  geom_hline(yintercept = 0, linetype = "dashed") +
  
  geom_area(aes(y = ifelse(Lucro_Entrante < 0, Lucro_Entrante, 0)), fill = "red", alpha = 0.2) +
  annotate("text", x = 80, y = -5, label = "Entrada Bloqueada", color = "red", fontface = "bold") +
  
  labs(title = "Módulo 25: Dissuasão de Entrada (Modelo de Dixit)",
       subtitle = "Ao investir em capacidade (K > 60), a Incumbente torna o lucro da Entrante negativo",
       x = "Capacidade Instalada (K)",
       y = "Lucro Esperado da Entrante",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod25_dissuasao_entrada.png", plot = p25, width = 8, height = 6, bg="white")
print("Módulo 25 executado com sucesso.")
