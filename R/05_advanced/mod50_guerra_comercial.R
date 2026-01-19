# Módulo 50: Guerra Comercial (Tarifas e Protecionismo)
# Autor: Luiz Tiago Wilcke
# Descrição: Dilema do Prisioneiro Internacional. Tarifas protegem localmente mas geram retaliação.

source("R/00_setup_theme.R")

# País A e País B.
# Livre Comércio (LC, LC) -> (100, 100)
# (Tarifa, LC) -> (120, 50) [Termos de troca melhoram para quem taxa unilateralmente]
# (Tarifa, Tarifa) -> (80, 80) [Guerra Comercial - Nash]

dados_trade <- data.frame(
  PaisA = c("Livre Comércio", "Livre Comércio", "Tarifa (Proteção)", "Tarifa (Proteção)"),
  PaisB = c("Livre Comércio", "Tarifa (Proteção)", "Livre Comércio", "Tarifa (Proteção)"),
  WelfareA = c(100, 50, 120, 80),
  WelfareB = c(100, 120, 50, 80)
)

dados_trade$Nash <- ifelse(dados_trade$WelfareA == 80 & dados_trade$WelfareB == 80, "Nash (Guerra)", "Instável/Ótimo")
dados_trade$Label <- paste0("A: ", dados_trade$WelfareA, "\nB: ", dados_trade$WelfareB)

p50 <- ggplot(dados_trade, aes(x = PaisA, y = PaisB)) +
  geom_tile(aes(fill = Nash), color = "black") +
  geom_text(aes(label = Label), size = 6, fontface = "bold") +
  
  scale_fill_manual(values = c("Nash (Guerra)" = "#C8102E", "Instável/Ótimo" = "lightblue")) +
  
  labs(title = "Módulo 50: Guerra Comercial (Dilema)",
       subtitle = "O incentivo unilateral de proteger a indústria leva ao pior equilíbrio conjunto",
       x = "Estratégia País A",
       y = "Estratégia País B",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod50_guerra_comercial.png", plot = p50, width = 7, height = 6, bg="white")
print("Módulo 50 executado com sucesso.")
