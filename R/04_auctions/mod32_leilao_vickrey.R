# Módulo 32: Leilão de Segundo Preço (Vickrey)
# Autor: Luiz Tiago Wilcke
# Descrição: O vencedor paga o lance do SEGUNDO colocado.
# Propriedade Mágica: A estratégia dominante é oferecer seu VALOR REAL (Truthful Bidding).

source("R/00_setup_theme.R")

# Simulação
# Meu Valor: 100.
# Cenários de Lance do Oponente (Maior rival): de 0 a 150.
# Se eu ofertar 100 (Verdade):
#   - Se Rival < 100 (ex: 80): Ganho. Pago 80. Lucro = 100 - 80 = 20.
#   - Se Rival > 100 (ex: 120): Perco. Lucro 0.
# Se eu ofertar 120 (Mentira para cima):
#   - Se Rival 110: Ganho. Pago 110. Lucro = 100 - 110 = -10 ( prejuízo!).
#   - Se Rival 80: Ganho. Pago 80. Lucro = 20 (Igual).

# Portanto, mentir nunca melhora o resultado, e pode piorar.

rival_bids <- seq(50, 150, 1)

lucro_truthful <- ifelse(rival_bids < 100, 100 - rival_bids, 0)
lucro_overbid <- ifelse(rival_bids < 120, 100 - rival_bids, 0) # Bid = 120

df_vickrey <- data.frame(Rival = rival_bids, Truth = lucro_truthful, Overbid = lucro_overbid)

p32 <- ggplot(df_vickrey, aes(x = Rival)) +
  geom_line(aes(y = Truth, color = "Lance = Valor Real (100)"), size = 2) +
  geom_line(aes(y = Overbid, color = "Lance Exagerado (120)"), size = 1.2, linetype="dashed") +
  
  geom_hline(yintercept = 0, color = "black") +
  
  annotate("text", x = 110, y = -5, label = "Prejuízo por Overbidding", color = "red") +
  
  scale_color_manual(values = c("Lance = Valor Real (100)" = "#009c3b", "Lance Exagerado (120)" = "#C8102E")) +
  
  labs(title = "Módulo 32: Leilão de Vickrey (2º Preço)",
       subtitle = "Dizer a verdade é dominante. Lances exagerados geram risco de 'Winners Curse' (pagar acima do valor).",
       x = "Lance do Maior Rival",
       y = "Lucro do Licitante",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod32_leilao_vickrey.png", plot = p32, width = 8, height = 6, bg="white")
print("Módulo 32 executado com sucesso.")
