# Módulo 26: Preços Predatórios (Teoria do Bolso Fundo)
# Autor: Luiz Tiago Wilcke
# Descrição: Empurrar o preço abaixo do custo para quebrar o concorrente financeiramente.

source("R/00_setup_theme.R")

# Tempo
t <- 1:20
preco_equilibrio <- 100
custo_marginal <- 80

# Estratégia Predatória
preco_predatorio <- c(rep(100, 5), rep(60, 5), rep(120, 10)) # Normal, Predação, Monopólio
caixa_concorrente <- numeric(20)
caixa_concorrente[1] <- 500 # Caixa Inicial

for(i in 2:20) {
  lucro <- (preco_predatorio[i-1] - custo_marginal) * 10 # Q=10
  caixa_concorrente[i] <- caixa_concorrente[i-1] + lucro
  if(caixa_concorrente[i] < 0) caixa_concorrente[i] <- 0 # Falência
}

df_pred <- data.frame(Tempo = t, Preco = preco_predatorio, Caixa = caixa_concorrente)

p26 <- ggplot(df_pred) +
  geom_line(aes(x = Tempo, y = Preco, color = "Preço de Mercado"), size = 1.2) +
  geom_line(aes(x = Tempo, y = Caixa/5, color = "Caixa Concorrente (Escala 1/5)"), size = 1.2, linetype = "dashed") +
  
  geom_hline(yintercept = custo_marginal, color = "gray", linetype = "dotted") +
  annotate("text", x = 2, y = 85, label = "Custo Marginal") +
  
  annotate("rect", xmin = 6, xmax = 10, ymin = 0, ymax = 150, alpha = 0.1, fill = "red") +
  annotate("text", x = 8, y = 140, label = "Fase de Predação", color = "red") +
  
  labs(title = "Módulo 26: Preços Predatórios",
       subtitle = "Empresa dominante impõe prejuízo até a concorrente sair (Caixa = 0), depois sobe o preço",
       x = "Período",
       y = "Preço ($)",
       color = "Indicador",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod26_precos_predatorios.png", plot = p26, width = 9, height = 6, bg="white")
print("Módulo 26 executado com sucesso.")
