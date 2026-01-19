# Módulo 14: Caça ao Cervo (Stag Hunt) - Risco vs Cooperação
# Autor: Luiz Tiago Wilcke
# Descrição: Investimento conjunto (Cervo) é arriscado se o outro não investir. Investimento seguro (Lebre) paga menos.

source("R/00_setup_theme.R")

# Cenário: Investir em Infraestrutura no Brasil (Risco Alto, Retorno Alto) vs Bonds USA (Risco Baixo, Retorno Baixo)
# (Investir, Investir) -> (10, 10) [Cervo - Payoff Dominant]
# (Seguro, Seguro) -> (5, 5) [Lebre - Risk Dominant]
# (Investir, Seguro) -> (0, 5)
# (Seguro, Investir) -> (5, 0)

dados_stag <- data.frame(
  InvA = c("Infraestrutura (Arriscado)", "Infraestrutura (Arriscado)", "Tesouro (Seguro)", "Tesouro (Seguro)"),
  InvB = c("Infraestrutura (Arriscado)", "Tesouro (Seguro)", "Infraestrutura (Arriscado)", "Tesouro (Seguro)"),
  PayoffA = c(10, 0, 5, 5),
  PayoffB = c(10, 5, 0, 5)
)

dados_stag$Label <- paste0("Inv A: ", dados_stag$PayoffA, "\nInv B: ", dados_stag$PayoffB)
dados_stag$TipoEq <- ifelse(dados_stag$PayoffA == 10, "Ótimo Social", 
                            ifelse(dados_stag$PayoffA == 5 & dados_stag$PayoffB == 5, "Seguro (Risco)", "Não Eq"))

p14 <- ggplot(dados_stag, aes(x = InvA, y = InvB)) +
  geom_tile(aes(fill = TipoEq), color = "black", size = 1) +
  geom_text(aes(label = Label), size = 5) +
  
  scale_fill_manual(values = c("Ótimo Social" = "#009c3b", "Seguro (Risco)" = "#ffdf00", "Não Eq" = "azure2")) +
  
  labs(title = "Módulo 14: Caça ao Cervo (Investimento)",
       subtitle = "O medo de o outro não cooperar pode levar ao equilíbrio inferior (Seguro)",
       x = "Decisão Investidor A",
       y = "Decisão Investidor B",
       fill = "Tipo de Equilíbrio",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  coord_fixed()

ggsave("output/mod14_stag_hunt.png", plot = p14, width = 8, height = 6, bg="white")
print("Módulo 14 executado com sucesso.")
