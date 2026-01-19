# Módulo 35: Teorema da Equivalência de Receita
# Autor: Luiz Tiago Wilcke
# Descrição: Demonstração numérica que, sob certas condições, o Leilão de 1º e 2º Preço geram a mesma receita esperada para o vendedor.

source("R/00_setup_theme.R")

# Monte Carlo: 10.000 Leilões com 2 participantes, Valores ~ Uniforme(0, 100)
set.seed(123)
n_sim <- 10000
v1 <- runif(n_sim, 0, 100)
v2 <- runif(n_sim, 0, 100)

# Receita 2º Preço (Vickrey)
# A estratégia é: Lance = Valor. O vendedor recebe o SEGUNDO maior lance.
lance2_J1 <- v1
lance2_J2 <- v2
receita_vickrey <- pmin(lance2_J1, lance2_J2) # O menor entre os dois é o segundo maior (são apenas 2)
# Nota: O vencedor é o maior. O preço é o menor. Se V1 > V2, V1 ganha e paga V2.

# Receita 1º Preço
# Estratégia ótima simétrica: Lance = (N-1)/N * Valor = 1/2 * Valor.
lance1_J1 <- 0.5 * v1
lance1_J2 <- 0.5 * v2
receita_primeiro <- pmax(lance1_J1, lance1_J2) # Vendedor recebe o MAIOR lance.

df_receita <- data.frame(
  Tipo = c("1º Preço (Esperada)", "2º Preço (Esperada)"),
  Receita = c(mean(receita_primeiro), mean(receita_vickrey))
)

p35 <- ggplot(df_receita, aes(x = Tipo, y = Receita, fill = Tipo)) +
  geom_bar(stat = "identity", width = 0.5) +
  geom_text(aes(label = round(Receita, 2)), vjust = -0.5, size = 6, fontface = "bold") +
  
  labs(title = "Módulo 35: Teorema da Equivalência de Receita",
       subtitle = "A receita esperada é idêntica (~33.3) para ambos os mecanismos (com riscos neutros)",
       y = "Receita Média do Vendedor",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  theme(legend.position = "none")

ggsave("output/mod35_equivalencia_receita.png", plot = p35, width = 7, height = 6, bg="white")
print("Módulo 35 executado com sucesso.")
