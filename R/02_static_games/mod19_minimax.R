# Módulo 19: Teorema Minimax (Estratégia de Segurança)
# Autor: Luiz Tiago Wilcke
# Descrição: Visualização da estratégia que garante o melhor pior cenário (Maximin).

source("R/00_setup_theme.R")

# Jogo: Goleiro vs Cobrador de Pênalti
# Goleiro quer MINIMIZAR a chance de gol. Cobrador quer MAXIMIZAR.
# P(Gol) depende da direção (Esq, Dir) de ambos.
# Matriz (Cobrador Linha, Goleiro Coluna):
#       Esq   Dir
# Esq   0.6   0.9
# Dir   0.9   0.6
# Supomos chutar Cruzado é mais difícil de pegar (0.9 vs 0.6 se acertar canto)

# Probabilidade de Chutar Esquerda (p)
p_vals <- seq(0, 1, 0.01)

# Se Goleiro Pula Esquerda (q=1): P(Gol) = p(0.6) + (1-p)(0.9)
prob_gol_se_goleiro_esq <- p_vals * 0.6 + (1 - p_vals) * 0.9

# Se Goleiro Pula Direita (q=0): P(Gol) = p(0.9) + (1-p)(0.6)
prob_gol_se_goleiro_dir <- p_vals * 0.9 + (1 - p_vals) * 0.6

# Função Min (Pior cenário para o cobrador dado que goleiro adivinha)
# O Goleiro vai escolher a estratégia que MINIMIZA a chance de gol.
# O Cobrador quer MAXIMIZAR esse MÍNIMO.

df_minimax <- data.frame(p = p_vals, 
                         Esq = prob_gol_se_goleiro_esq, 
                         Dir = prob_gol_se_goleiro_dir)
df_minimax$PiorCenario <- pmin(df_minimax$Esq, df_minimax$Dir)

p19 <- ggplot(df_minimax, aes(x = p)) +
  geom_line(aes(y = Esq, color = "Goleiro Pula Esquerda"), size = 1) +
  geom_line(aes(y = Dir, color = "Goleiro Pula Direita"), size = 1) +
  geom_line(aes(y = PiorCenario), size = 2, color = "black", alpha = 0.5) +
  
  geom_point(aes(x = 0.5, y = 0.75), size = 5, color = "purple") +
  annotate("text", x = 0.5, y = 0.77, label = "Minimax (p=0.5, V=0.75)", fontface = "bold", color = "purple") +
  
  labs(title = "Módulo 19: Teorema Minimax (Pênaltis)",
       subtitle = "A linha preta é o mínimo que o cobrador garante. O pico é a estratégia ótima.",
       x = "Probabilidade do Cobrador Chutar na Esquerda (p)",
       y = "Probabilidade de Gol Esperada",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod19_minimax.png", plot = p19, width = 8, height = 6, bg="white")
print("Módulo 19 executado com sucesso.")
