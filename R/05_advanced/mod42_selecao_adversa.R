# Módulo 42: Seleção Adversa (Mercado de Limões)
# Autor: Luiz Tiago Wilcke
# Descrição: Colapso do mercado quando compradores não distinguem qualidade (Carros Usados).

source("R/00_setup_theme.R")

# Carros bons valem 100 (Vendedor) e 120 (Comprador).
# Carros ruins valem 50 (Vendedor) e 60 (Comprador).
# Se Comprador não distingue, oferece preço médio.
# Se mix 50/50: Preço Máx Comprador = 0.5*120 + 0.5*60 = 90.
# Vendedor de Carro Bom (Valor 100) NÃO aceita 90. Sai do mercado.
# Só sobram ruins. Preço cai para 60.

proporcao_bons <- seq(0, 1, 0.01)
preco_reserva_vendedor_bom <- 100
preco_disposto_comprador <- proporcao_bons * 120 + (1 - proporcao_bons) * 60

df_lemons <- data.frame(ProbBom = proporcao_bons, PrecoOferta = preco_disposto_comprador)

# Mercado existe se PrecoOferta >= PrecoReservaVendedorBom (para vender bons)
df_lemons$Status <- ifelse(df_lemons$PrecoOferta >= 100, "Mercado Completo", "Apenas Ruins (Seleção Adversa)")

p42 <- ggplot(df_lemons, aes(x = ProbBom, y = PrecoOferta, color = Status)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 100, linetype = "dotted") +
  annotate("text", x = 0.1, y = 102, label = "Preço Mínimo Vendedor (Bom)", color = "gray40", hjust = 0) +
  
  scale_color_manual(values = c("Mercado Completo" = "#009c3b", "Apenas Ruins (Seleção Adversa)" = "#C8102E")) +
  
  labs(title = "Módulo 42: Seleção Adversa (Akerlof)",
       subtitle = "Se a proporção de bons carros é baixa (< 0.67), o preço médio expulsa os bons vendedores",
       x = "Proporção de Carros Bons no Mercado",
       y = "Preço que Comprador Aceita Pagar",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  theme(legend.position = "bottom")

ggsave("output/mod42_selecao_adversa.png", plot = p42, width = 8, height = 6, bg="white")
print("Módulo 42 executado com sucesso.")
