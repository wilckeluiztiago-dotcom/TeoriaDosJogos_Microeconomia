# Módulo 23: Equilíbrio Perfeito em Subjogos (SPNE)
# Autor: Luiz Tiago Wilcke
# Descrição: Diferença entre Nash simples e SPNE.

source("R/00_setup_theme.R")

# Jogo de Entrada de Mercado
# J1 (Entrante): Entrar (E) ou Fora (O)
# J2 (Incumbente, se E): Lutar (L) ou Acomodar (A)
# Payoffs:
# (O) -> (0, 10)
# (E, L) -> (-5, -5)
# (E, A) -> (5, 5)

# Nash Equilibria na forma normal:
# 1. (E, A) -> J1 entra, J2 acomoda. Payoffs: (5, 5). SPNE.
# 2. (O, L) -> J1 fica fora porque TEME que J2 lute. J2 diz que lutará. Nash, mas NÃO SPNE.

df_spne <- data.frame(
  Estrategia = c("(Entrar, Acomodar)", "(Ficar Fora, Lutar)"),
  Tipo = c("SPNE (Credível)", "Nash Imperfeito (Ameaça Vazia)"),
  PayoffJ1 = c(5, 0),
  PayoffJ2 = c(5, 10) # 10 se J1 ficasse fora
)

p23 <- ggplot(df_spne, aes(x = Estrategia, y = PayoffJ1, fill = Tipo)) +
  geom_bar(stat = "identity") +
  labs(title = "Módulo 23: SPNE vs Nash Imperfeito",
       subtitle = "O Equilíbrio (Ficar Fora, Lutar) baseia-se em uma ameaça não credível de lutar",
       y = "Payoff do Entrante (J1)",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  scale_fill_manual(values = c("SPNE (Credível)" = "#009c3b", "Nash Imperfeito (Ameaça Vazia)" = "#C8102E"))

ggsave("output/mod23_spne.png", plot = p23, width = 8, height = 6, bg="white")
print("Módulo 23 executado com sucesso.")
