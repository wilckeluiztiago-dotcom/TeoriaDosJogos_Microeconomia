# Módulo 15: Matching Pennies (Fiscalização vs Sonegação)
# Autor: Luiz Tiago Wilcke
# Descrição: Jogo sem Equilíbrio de Nash em Estratégias Puras (Soma Zero).

source("R/00_setup_theme.R")

# Cenário: Auditor Fiscal vs Contribuinte
# Auditor: Fiscalizar (F) ou Não Fiscalizar (N)
# Contribuinte: Sonegar (S) ou Cumprir (C)
# Payoffs (Auditor, Contribuinte):
# (F, S) -> Auditor ganha multa (+10), Contribuinte paga multa (-10)
# (F, C) -> Auditor gasta custo (-2), Contribuinte ok (0) -> (-2, 0)
# (N, S) -> Auditor perde receita (-10), Contribuinte ganha imposto (+10)
# (N, C) -> (0, 0)

dados_mp <- data.frame(
  Auditor = c("Fiscalizar", "Fiscalizar", "Nada Fazer", "Nada Fazer"),
  Contribuinte = c("Sonegar", "Cumprir", "Sonegar", "Cumprir"),
  PayoffAud = c(10, -2, -10, 0),
  PayoffCon = c(-10, 0, 10, 0)
)

dados_mp$Label <- paste0("Aud: ", dados_mp$PayoffAud, "\nCon: ", dados_mp$PayoffCon)

# Ciclo de Melhores Respostas
# Se Contribuinte = Sonegar -> Auditor = Fiscalizar
# Se Auditor = Fiscalizar -> Contribuinte = Cumprir
# Se Contribuinte = Cumprir -> Auditor = Nada Fazer
# Se Auditor = Nada Fazer -> Contribuinte = Sonegar
# CICLO SEM FIM -> Não há Nash Puro

p15 <- ggplot(dados_mp, aes(x = Auditor, y = Contribuinte)) +
  geom_tile(fill = "gray95", color = "black", size = 1) +
  geom_text(aes(label = Label), size = 6) +
  
  # Setas indicando o ciclo (manual para ilustração)
  annotate("segment", x = 1, xend = 2, y = 2, yend = 2, arrow = arrow(length = unit(0.3, "cm")), color = "red", size = 1.5) + # Sonegar -> Fiscalizar
  annotate("segment", x = 2, xend = 2, y = 2, yend = 1, arrow = arrow(length = unit(0.3, "cm")), color = "red", size = 1.5) + # Fiscalizar -> Cumprir
  annotate("segment", x = 2, xend = 1, y = 1, yend = 1, arrow = arrow(length = unit(0.3, "cm")), color = "red", size = 1.5) + # Cumprir -> Nada
  annotate("segment", x = 1, xend = 1, y = 1, yend = 2, arrow = arrow(length = unit(0.3, "cm")), color = "red", size = 1.5) + # Nada -> Sonegar

  labs(title = "Módulo 15: Matching Pennies (Ciclo de Fiscalização)",
       subtitle = "Não existe par estável de estratégias puras: O jogo é circular",
       x = "Estratégia Auditor",
       y = "Estratégia Contribuinte",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  coord_fixed()

ggsave("output/mod15_matching_pennies.png", plot = p15, width = 7, height = 6, bg="white")
print("Módulo 15 executado com sucesso.")
