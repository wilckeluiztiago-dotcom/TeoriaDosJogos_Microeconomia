# Módulo 13: Jogo de Coordenação (Padrões Tecnológicos)
# Autor: Luiz Tiago Wilcke
# Descrição: Batalha dos Sexos aplicada à escolha de padrão tecnológico (ex: 5G SA vs NSA).

source("R/00_setup_theme.R")

# Cenário: Duas operadoras (Vivo e Claro) decidindo qual padrão 5G priorizar.
# Elas ganham mais se escolherem o mesmo padrão (interoperabilidade/escala).
# Vivo prefere SA, Claro prefere NSA.
# (SA, SA) -> (3, 2)
# (NSA, NSA) -> (2, 3)
# (SA, NSA) -> (0, 0)
# (NSA, SA) -> (0, 0)

dados_coord <- data.frame(
  Vivo = c("Padrão SA", "Padrão SA", "Padrão NSA", "Padrão NSA"),
  Claro = c("Padrão SA", "Padrão NSA", "Padrão SA", "Padrão NSA"),
  UtilidadeVivo = c(3, 0, 0, 2),
  UtilidadeClaro = c(2, 0, 0, 3)
)

dados_coord$Label <- paste0("Vivo: ", dados_coord$UtilidadeVivo, "\nClaro: ", dados_coord$UtilidadeClaro)
dados_coord$EqNash <- ifelse(dados_coord$UtilidadeVivo > 0 & dados_coord$UtilidadeClaro > 0, "Nash", "-")

p13 <- ggplot(dados_coord, aes(x = Vivo, y = Claro)) +
  geom_tile(aes(fill = EqNash), color = "black", size = 1) +
  geom_text(aes(label = Label), size = 6) +
  
  scale_fill_manual(values = c("Nash" = "#009c3b", "-" = "white")) +
  
  labs(title = "Módulo 13: Jogo de Coordenação (Padrões 5G)",
       subtitle = "Dois Equilíbrios de Nash: O desafio é coordenar qual adotar",
       x = "Estratégia Vivo",
       y = "Estratégia Claro",
       fill = "É Equilíbrio?",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  coord_fixed()

ggsave("output/mod13_coordenacao.png", plot = p13, width = 7, height = 6, bg="white")
print("Módulo 13 executado com sucesso.")
