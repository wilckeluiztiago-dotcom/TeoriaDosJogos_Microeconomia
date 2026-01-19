# Módulo 37: Solução de Barganha de Nash
# Autor: Luiz Tiago Wilcke
# Descrição: Divisão de um excedente (ex: Negociação Salarial). Maximização do Produto de Nash.

source("R/00_setup_theme.R")

# Excedente Total = 100
# Ponto de Desacordo (BATNA - Best Alternative to Negotiated Agreement)
batna_A <- 10 # Empregado consegue 10 em outro lugar
batna_B <- 20 # Empregador lucra 20 se contratar outro

# Excedente a ser dividido S = 100.
# Nash maximiza (x - d_A) * (y - d_B) sujeito a x + y = 100
# (x - 10) * (100 - x - 20) -> Maximizar (x - 10)(80 - x)
# Derivada: 80 - x - (x - 10) = 80 - 2x + 10 = 90 - 2x = 0 -> 2x = 90 -> x = 45.
# y = 100 - 45 = 55.

# Solução Geral: x* = (S - d_B + d_A) / 2 = (100 - 20 + 10) / 2 = 90 / 2 = 45.
# Divisão do excedente líquido (100 - 30 = 70). Cada um leva 35 acima do BATNA.
# A: 10 + 35 = 45. B: 20 + 35 = 55.

df_barganha <- data.frame(item = c("BATNA", "Excedente Negociado (Split)"), 
                          A = c(10, 35), 
                          B = c(20, 35))

library(tidyr)
df_long <- pivot_longer(df_barganha, cols = c("A", "B"), names_to = "Agente", values_to = "Valor")

p37 <- ggplot(df_long, aes(x = Agente, y = Valor, fill = item)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("BATNA" = "gray", "Excedente Negociado (Split)" = "#009c3b")) +
  
  geom_text(aes(label = Valor), position = position_stack(vjust = 0.5), color = "white", fontface = "bold") +
  annotate("text", x = 1.5, y = 105, label = "Valor Total = 100", fontface = "bold") +
  
  labs(title = "Módulo 37: Solução de Barganha de Nash",
       subtitle = "O excedente (verde = 70) é dividido igualmente acima dos BATNAs (cinza)",
       x = "Agente (A = Empregado, B = Empregador)",
       y = "Valor Final Obtido",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod37_solucao_barganha.png", plot = p37, width = 8, height = 6, bg="white")
print("Módulo 37 executado com sucesso.")
