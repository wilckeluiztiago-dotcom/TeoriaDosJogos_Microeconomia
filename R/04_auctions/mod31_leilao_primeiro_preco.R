# Módulo 31: Leilão de Primeiro Preço (Envelope Fechado)
# Autor: Luiz Tiago Wilcke
# Descrição: Os participantes entregam lances secretos. O maior leva e paga o que ofertou.
# Estratégia Dominante: "Bid Shading" (Oferecer menos que o valor real).

source("R/00_setup_theme.R")

# Simulação: N licitantes com valorações Uniforme[0, 100]
# Teoria: Lance Ótimo b(v) = (N-1)/N * v

N_participantes <- 2:10
Valor_Real <- 100 # Supondo que eu valoro o item em 100

lance_otimo <- (N_participantes - 1) / N_participantes * Valor_Real
lucro_esperado <- (Valor_Real - lance_otimo) * (lance_otimo / Valor_Real)^(N_participantes - 1) # Prob Vencer * Margem

df_bid <- data.frame(Participantes = N_participantes, Lance = lance_otimo)

p31 <- ggplot(df_bid, aes(x = Participantes, y = Lance)) +
  geom_line(size = 1.2, color = "blue") +
  geom_point(size = 4, color = "blue") +
  
  geom_hline(yintercept = Valor_Real, linetype = "dashed", color = "red") +
  annotate("text", x = 9, y = 98, label = "Valor Real (100)", color = "red") +
  
  labs(title = "Módulo 31: 'Bid Shading' em Leilões de 1º Preço",
       subtitle = "Quanto mais concorrentes (N), mais agressivo (próximo ao valor real) deve ser o lance",
       x = "Número de Participantes (N)",
       y = "Lance Ótimo ($)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod31_leilao_primeiro_preco.png", plot = p31, width = 8, height = 6, bg="white")
print("Módulo 31 executado com sucesso.")
