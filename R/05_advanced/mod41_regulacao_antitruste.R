# Módulo 41: Regulação Antitruste (CADE - Brasil)
# Autor: Luiz Tiago Wilcke
# Descrição: Análise de concentração pré e pós-fusão usando critérios do CADE.

source("R/00_setup_theme.R")

# Critérios CADE:
# HHI < 1500: Baixa concentração.
# 1500 <= HHI < 2500: Moderada. Aumento > 200 levanta preocupações.
# HHI >= 2500: Alta. Aumento > 100 levanta preocupações.

cenarios <- c("Fusão A (Pequena)", "Fusão B (Média)", "Fusão C (Mega)")
hhi_pre <- c(1200, 1800, 2600)
delta_hhi <- c(100, 300, 150)
hhi_pos <- hhi_pre + delta_hhi

decisao_cade <- function(hhi, delta) {
  if (hhi < 1500) return("Aprovado (Sumário)")
  if (hhi < 2500) {
    if (delta > 200) return("Análise Complexa") else return("Aprovado")
  }
  if (delta > 100) return("Restrições/Remédios") else return("Aprovado")
}

decisoes <- mapply(decisao_cade, hhi_pos, delta_hhi)

df_cade <- data.frame(Cenario = cenarios, HHI_Inicial = hhi_pre, HHI_Final = hhi_pos, Decisao = decisoes)
library(tidyr)
df_cade_long <- pivot_longer(df_cade, cols = c("HHI_Inicial", "HHI_Final"), names_to = "Momento", values_to = "HHI")

p41 <- ggplot(df_cade_long, aes(x = Cenario, y = HHI, fill = Momento)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_hline(yintercept = 2500, linetype = "dashed", color = "red") +
  annotate("text", x = 0.6, y = 2600, label = "Limite Alta Concentração", color = "red", hjust = 0) +
  
  geom_text(data = df_cade, aes(x = Cenario, y = HHI_Final + 200, label = Decisao, fill = NULL), fontface = "bold") +
  
  scale_fill_manual(values = c("HHI_Inicial" = "gray", "HHI_Final" = "#002776")) +
  labs(title = "Módulo 41: Análise de Fusões (CADE)",
       subtitle = "Critérios baseados no Guia de Análise de Atos de Concentração Horizontal",
       y = "Índice HHI",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod41_regulacao_antitruste.png", plot = p41, width = 8, height = 6, bg="white")
print("Módulo 41 executado com sucesso.")
