# Módulo 39: Leilão do 5G no Brasil (Estudo de Caso)
# Autor: Luiz Tiago Wilcke
# Descrição: Análise dos ágios pagos no Leilão de 2021.

source("R/00_setup_theme.R")

# Dados Reais (Aproximados/Arredondados) do Leilão 5G (Faixa 3.5 GHz)
# Lote B1 (Claro): Preço Mínimo ~ 68 milhões. Lance Final ~ 338 milhões. (Ágio gigante? Não, eram obrigações de investimento, mas vamos focar no componente caixa/competição).
# Vamos considerar o "Valor Econômico" total.
# Dados simplificados para ilustração:
operadoras <- c("Claro", "Vivo", "TIM", "Brisanet")
lances <- c(338, 420, 351, 1250) # Valores ilustrativos de lotes diferentes para comparação de ágio relativo
minimo <- c(68, 68, 68, 500)
agios_percentual <- (lances - minimo) / minimo * 100

df_5g <- data.frame(Operadora = operadoras, Lance = lances, Minimo = minimo, Agio = agios_percentual)

p39 <- ggplot(df_5g, aes(x = Operadora, y = Agio, fill = Operadora)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(round(Agio), "%")), vjust = -0.5, fontface = "bold") +
  
  scale_fill_brewer(palette = "Set1") +
  
  labs(title = "Módulo 39: Ágio no Leilão do 5G (Brasil 2021)",
       subtitle = "Alta competição gerou ágios significativos sobre o preço mínimo",
       y = "Ágio (%)",
       caption = "Autor: Luiz Tiago Wilcke | Dados fictícios p/ ilustração da dinâmica") +
  theme_economico() +
  theme(legend.position = "none")

ggsave("output/mod39_leilao_5g.png", plot = p39, width = 8, height = 6, bg="white")
print("Módulo 39 executado com sucesso.")
