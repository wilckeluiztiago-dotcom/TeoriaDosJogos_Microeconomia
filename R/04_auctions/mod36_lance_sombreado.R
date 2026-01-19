# Módulo 36: Lance Sombreado (Bid Shading) e Competição
# Autor: Luiz Tiago Wilcke
# Descrição: O quanto devo "esconder" do meu valor real? Depende de N.

source("R/00_setup_theme.R")

N_concorrentes <- seq(2, 50, 1)
fator_shading <- (N_concorrentes - 1) / N_concorrentes # Lance = Fator * Valor

df_shading <- data.frame(N = N_concorrentes, Fator = fator_shading)

p36 <- ggplot(df_shading, aes(x = N, y = Fator)) +
  geom_line(size = 1.2, color = "darkgreen") +
  
  geom_hline(yintercept = 1, linetype = "dashed", color = "gray") +
  annotate("text", x = 40, y = 0.95, label = "Valor Real (Sem Shading)", color = "gray") +
  
  labs(title = "Módulo 36: Agressividade do Lance vs Concorrência",
       subtitle = "Com poucos concorrentes, o lance ótimo é muito abaixo do valor real (Bid Shading).",
       x = "Número de Concorrentes",
       y = "Proporção do Valor Real Ofertada",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  ylim(0.5, 1.05)

ggsave("output/mod36_lance_sombreado.png", plot = p36, width = 8, height = 6, bg="white")
print("Módulo 36 executado com sucesso.")
