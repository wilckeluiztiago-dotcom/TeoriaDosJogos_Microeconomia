# Módulo 46: Desenho de Mecanismos (Principal-Agente)
# Autor: Luiz Tiago Wilcke
# Descrição: Contrato ótimo para incentivar esforço observando apenas o resultado.

source("R/00_setup_theme.R")

# Principal quer esforço Alto (e=1). Resultado pode ser Bom ou Ruim.
# P(Bom | Alto) = 0.8. P(Bom | Baixo) = 0.4.
# Custo esforçoAgente = 10.
# O Principal paga salario W_b se Bom e W_r se Ruim.
# Restrição Participação (Agente aceita): 0.8 W_b + 0.2 W_r - 10 >= 0 (Reserva = 0)
# Restrição Incentivo (Agente prefere Alto): 0.8 W_b + 0.2 W_r - 10 >= 0.4 W_b + 0.6 W_r - 0
# 0.4 W_b - 0.4 W_r >= 10 -> W_b - W_r >= 25.
# Para minimizar custo, Principal faz as restrições ativas (binding).

# Solução Numérica:
# W_b - W_r = 25
# 0.8 W_b + 0.2 W_r = 10
# 0.8(W_r + 25) + 0.2 W_r = 10 -> 0.8 W_r + 20 + 0.2 W_r = 10 -> W_r = -10 (Impossível se proteção limitada).
# Se Responsabilidade Limitada (W >= 0): W_r = 0. W_b = 25.
# Custo Esperado = 0.8 * 25 = 20.

cenarios <- c("Salário Fixo", "Incentivo (Risco Agente)")
payoff_agente <- c("10 (Sem Esforço)", "10 (Com Esforço)")
payoff_principal <- c("Lucro Baixo", "Lucro Alto - Bônus")

df_mech <- data.frame(
  Resultado = c("Bom", "Ruim"),
  Pagamento = c(25, 0)
)

p46 <- ggplot(df_mech, aes(x = Resultado, y = Pagamento, fill = Resultado)) +
  geom_bar(stat = "identity", width = 0.5) +
  geom_text(aes(label = Pagamento), vjust = -0.5, size = 6) +
  scale_fill_manual(values = c("Bom" = "#009c3b", "Ruim" = "#C8102E")) +
  
  labs(title = "Módulo 46: Contrato Ótimo (Incentivos)",
       subtitle = "Para induzir esforço, o Principal deve criar um 'gap' de 25 entre pagamento por sucesso e fracasso",
       y = "Pagamento ao Agente",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  theme(legend.position = "none")

ggsave("output/mod46_principal_agente.png", plot = p46, width = 7, height = 6, bg="white")
print("Módulo 46 executado com sucesso.")
