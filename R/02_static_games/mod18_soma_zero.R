# Módulo 18: Jogos de Soma Zero (Derivativos Financeiros)
# Autor: Luiz Tiago Wilcke
# Descrição: Modelagem de um Contrato Futuro onde o ganho de um é a perda exata do outro.

source("R/00_setup_theme.R")

# Cenário: Contrato Futuro de Dólar (Mini Dólar WDO)
# Preço de Ajuste vs Preço de Venda
# Comprador ganha se Preço Sobe. Vendedor ganha se Preço Cai.
# Soma Payoffs = 0 (desconsiderando taxas)

preco_entrada <- 5.00
cenarios_preco_final <- seq(4.50, 5.50, by = 0.01)

payoff_comprador <- (cenarios_preco_final - preco_entrada) * 1000 # 1000 USD nocional
payoff_vendedor <- -payoff_comprador

df_soma_zero <- data.frame(
  PrecoFinal = cenarios_preco_final,
  Comprador = payoff_comprador,
  Vendedor = payoff_vendedor
)

p18 <- ggplot(df_soma_zero, aes(x = PrecoFinal)) +
  geom_line(aes(y = Comprador, color = "Comprador (Long)"), size = 1.2) +
  geom_line(aes(y = Vendedor, color = "Vendedor (Short)"), size = 1.2) +
  
  geom_hline(yintercept = 0, color = "black") +
  geom_vline(xintercept = preco_entrada, linetype = "dotted") +
  
  annotate("text", x = 5.4, y = 400, label = "Ganho Comprador", color = "#009c3b") +
  annotate("text", x = 4.6, y = 400, label = "Ganho Vendedor", color = "#C8102E") +
  
  scale_color_manual(values = c("Comprador (Long)" = "#009c3b", "Vendedor (Short)" = "#C8102E")) +
  
  labs(title = "Módulo 18: Jogo de Soma Zero (Mercado Futuro)",
       subtitle = "O que um ganha, o outro perde (Payoff Simétrico)",
       x = "Preço Final do Ativo (R$)",
       y = "Resultado Financeiro (R$)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod18_soma_zero.png", plot = p18, width = 8, height = 6, bg="white")
print("Módulo 18 executado com sucesso.")
