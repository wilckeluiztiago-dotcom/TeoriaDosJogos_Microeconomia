# Módulo 12: O Dilema do Prisioneiro (Cartéis de Preço)
# Autor: Luiz Tiago Wilcke
# Descrição: Aplicação clássica explicando por que cartéis são instáveis (Guerra de Preços).

source("R/00_setup_theme.R")

# Payoff Matrix (Empresa A, Empresa B)
# Estratégias: Preço Alto (Cooparar), Preço Baixo (Trair)
# (Alto, Alto) -> (10, 10)
# (Alto, Baixo) -> (0, 15)
# (Baixo, Alto) -> (15, 0)
# (Baixo, Baixo) -> (5, 5) -> Nash

dados_jogo <- data.frame(
  EmpresaA = c("Preço Alto", "Preço Alto", "Preço Baixo", "Preço Baixo"),
  EmpresaB = c("Preço Alto", "Preço Baixo", "Preço Alto", "Preço Baixo"),
  PayoffA = c(10, 0, 15, 5),
  PayoffB = c(10, 15, 0, 5)
)

# Criar heatmap de Payoffs
dados_jogo$Label <- paste0("A: ", dados_jogo$PayoffA, "\nB: ", dados_jogo$PayoffB)
dados_jogo$Nash <- ifelse(dados_jogo$PayoffA == 5 & dados_jogo$PayoffB == 5, "Sim", "Não")

p12 <- ggplot(dados_jogo, aes(x = EmpresaA, y = EmpresaB)) +
  geom_tile(aes(fill = Nash), color = "white", size = 2) +
  geom_text(aes(label = Label), size = 6, fontface = "bold") +
  
  scale_fill_manual(values = c("Sim" = "#ffdf00", "Não" = "gray90")) + # Nash em destaque
  
  labs(title = "Módulo 12: O Dilema do Prisioneiro (Instabilidade de Cartel)",
       subtitle = "Embora (Alto, Alto) seja melhor globalmente, a estratégia dominante é (Baixo, Baixo)",
       x = "Estratégia Empresa A",
       y = "Estratégia Empresa B",
       fill = "Equilíbrio de Nash?",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  coord_fixed()

ggsave("output/mod12_dilema_prisioneiro.png", plot = p12, width = 7, height = 6, bg="white")
print("Módulo 12 executado com sucesso.")
