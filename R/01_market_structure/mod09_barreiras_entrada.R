# Módulo 09: Barreiras à Entrada e Preço Limite
# Autor: Luiz Tiago Wilcke
# Descrição: Estratégia de Preço Limite para deter a entrada de concorrentes.

source("R/00_setup_theme.R")

# Cenário: Incumbente com custo baixo, Entrante com custo alto (Fixo + variável)
# Se Incumbente cobrar P_monopolio, Entrante entra e lucra.
# Incumbente deve baixar preço para P_limite tal que Lucro_Entrante < 0.

custo_fixo_entrante <- 500
cmg_entrante <- 30
demanda_residual <- function(p, q_incumbente) { 100 - p - 0.5 * q_incumbente } # Simplificação

# Gráfico Ilustrativo do Lucro da Entrante em função do Preço de Mercado estabelecido pela Incumbente
precos_mercado <- seq(20, 80, 1)

lucro_entrante_potencial <- function(p) {
  # Entrante pega uma fatia pequena ou precisa investir
  # Modelo simplificado: Se P > Cmg_entrante + CustoFixoMedio, entra.
  q_viavel <- 10 # Tamanho mínimo escala eficiente
  receita <- p * q_viavel
  custo <- custo_fixo_entrante + cmg_entrante * q_viavel
  return(receita - custo)
}

df_barreiras <- data.frame(Preco = precos_mercado)
df_barreiras$Lucro_Entrante <- sapply(df_barreiras$Preco, lucro_entrante_potencial)
df_barreiras$Decisao <- ifelse(df_barreiras$Lucro_Entrante > 0, "Entrar", "Não Entrar")

p9 <- ggplot(df_barreiras, aes(x = Preco, y = Lucro_Entrante, fill = Decisao)) +
  geom_bar(stat = "identity") +
  geom_hline(yintercept = 0, size = 1) +
  
  scale_fill_manual(values = c("Entrar" = "#009c3b", "Não Entrar" = "#C8102E")) +
  
  annotate("text", x = 30, y = -100, label = "Preço Limite", fontface = "bold") +
  geom_vline(xintercept = 80, linetype = "dotted") + # Preço de Monopólio seria alto
  
  labs(title = "Módulo 09: Estratégia de Preço Limite",
       subtitle = "Incumbente define preço baixo para tornar o lucro da entrante negativo",
       x = "Preço de Mercado Definido pela Incumbente",
       y = "Lucro Potencial da Entrante",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod09_barreiras_entrada.png", plot = p9, width = 8, height = 6, bg = "white")
print("Módulo 09 executado com sucesso.")
