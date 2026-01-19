# Módulo 40: Leilão da Cessão Onerosa (Petróleo)
# Autor: Luiz Tiago Wilcke
# Descrição: Distribuição do Excedente da Cessão Onerosa (Búzios e Itapu).

source("R/00_setup_theme.R")

# Novembro 2019. Áreas: Búzios, Itapu, Sepia, Atapu.
# Búzios e Itapu arrematados pela Petrobras (com sócios chineses em Búzios).
# Sepia e Atapu sem lances na primeira rodada (Modelagem ruim? Risco alto? Preço alto?) -> Winner's Curse avoidance.

areas <- c("Búzios", "Itapu", "Sépia", "Atapu")
status <- c("Arrematado", "Arrematado", "Sem Oferta", "Sem Oferta")
bonus_assinatura <- c(68.2, 1.77, 0, 0) # Bilhões de Reais

df_oil <- data.frame(Area = areas, Status = status, Bonus = bonus_assinatura)

p40 <- ggplot(df_oil, aes(x = Area, y = Bonus, fill = Status)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("Arrematado" = "#009c3b", "Sem Oferta" = "gray")) +
  
  geom_text(aes(label = paste("R$", Bonus, "Bi")), vjust = -0.5, size = 5) +
  
  labs(title = "Módulo 40: Mega Leilão do Pré-Sal (2019)",
       subtitle = "Apenas os campos de menor risco/maior retorno (Búzios) atraíram lances",
       y = "Bônus de Assinatura (Bilhões R$)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod40_leilao_petroleo.png", plot = p40, width = 8, height = 6, bg="white")
print("Módulo 40 executado com sucesso.")
