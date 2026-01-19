# Módulo 43: Risco Moral (Seguros)
# Autor: Luiz Tiago Wilcke
# Descrição: Alteração de comportamento após contrato (redução de esforço de prevenção).

source("R/00_setup_theme.R")

# Esforço (e) custa C(e) = e^2. Reduz probabilidade de perda P(L|e) = 1 - e.
# Perda L = 100.
# Sem Seguro: Minimizar (1-e)*100 + e^2.
# Derivada: -100 + 2e = 0 -> e* = 50 (Nível ótimo de cuidado).
# Com Seguro Total (Paga 100 se perder): Indivíduo não perde nada. Minimiza e^2.
# Derivada: 2e = 0 -> e* = 0 (Nenhum cuidado).
# Com Franquia (Paga 20 se perder): Minimizar (1-e)*20 + e^2.
# Derivada: -20 + 2e = 0 -> e* = 10 (Cuidado parcial).

cobertura <- c("0% (Sem Seguro)", "80% (Com Franquia)", "100% (Seguro Total)")
esforco_otimo <- c(50, 10, 0) # Simplificado

df_moral <- data.frame(Cobertura = cobertura, Esforco = esforco_otimo)

p43 <- ggplot(df_moral, aes(x = Cobertura, y = Esforco, fill = Cobertura)) +
  geom_bar(stat = "identity", width = 0.5) +
  geom_text(aes(label = Esforco), vjust = -0.5, fontface = "bold") +
  
  scale_fill_brewer(palette = "Reds", direction = -1) +
  
  labs(title = "Módulo 43: Risco Moral (Moral Hazard)",
       subtitle = "Quanto maior a cobertura do seguro, menor o esforço de prevenção do segurado",
       y = "Nível de Esforço de Prevenção",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  theme(legend.position = "none")

ggsave("output/mod43_risco_moral.png", plot = p43, width = 8, height = 6, bg="white")
print("Módulo 43 executado com sucesso.")
