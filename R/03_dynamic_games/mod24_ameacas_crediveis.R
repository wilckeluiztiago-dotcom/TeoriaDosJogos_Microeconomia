# Módulo 24: Ameaças Credíveis e Compromisso (Queimando Pontes)
# Autor: Luiz Tiago Wilcke
# Descrição: Como tornar uma ameaça de Lutar credível alterando os payoffs (Compromisso).

source("R/00_setup_theme.R")

# Se Incumbente investe em capacidade excessiva (Sunk Cost), o custo marginal de lutar cai ou o custo de acomodar sobe.
# Novo Payoff Incumbente:
# (E, L) -> (-5, -5) -> Com investimento -> (-1, -1) (Luta eficiente)
# (E, A) -> (5, 5) -> Com perda de reputação/capacidade ociosa -> (5, 2)
# Agora Lutar (-1) < Acomodar (2)? Não.
# Vamos assumir que Lutar se torna melhor que Acomodar.
# Ex: Contrato de "Menor Preço Garantido" faz com que acomodar (cortar preço só pra um) seja caríssimo.

cenarios <- c("Sem Compromisso", "Com Dispositivo de Compromisso")
melhor_resposta_incumbente <- c("Acomodar (5)", "Lutar (-1 > -50)") # Exemplo ilustrativo

df_threat <- data.frame(Cenario = cenarios, Resposta = melhor_resposta_incumbente, Valor = c(5, 10))

p24 <- ggplot(df_threat, aes(x = Cenario, y = Valor, fill = Cenario)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Resposta), vjust = 1.5, color = "white", fontface = "bold") +
  
  labs(title = "Módulo 24: Tornando Ameaças Credíveis",
       subtitle = "Dispositivos de compromisso alteram os incentivos ex-post",
       y = "Valor Estratégico",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  theme(legend.position = "none")

ggsave("output/mod24_ameacas_crediveis.png", plot = p24, width = 8, height = 6, bg="white")
print("Módulo 24 executado com sucesso.")
