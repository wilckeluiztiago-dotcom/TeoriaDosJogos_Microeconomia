# Módulo 47: Economia Comportamental (Jogo do Ultimato)
# Autor: Luiz Tiago Wilcke
# Descrição: Racionalidade vs Justiça (Fairness).

source("R/00_setup_theme.R")

# Proponente oferece x de 100. Respondente aceita ou rejeita.
# Nash: Proponente oferece epsilon (1), Respondente aceita (1 > 0).
# Empírico: Ofertas < 30% são rejeitadas frequentemente (Punição Altruísta).

ofertas <- seq(0, 100, 5)
prob_aceite <- pmin(1, pmax(0, (ofertas - 10) / 40)) # Modelo simples sigmoid
lucro_esperado_proponente <- (100 - ofertas) * prob_aceite

df_ultimato <- data.frame(Oferta = ofertas, ProbAceite = prob_aceite, LucroEsp = lucro_esperado_proponente)

p47 <- ggplot(df_ultimato, aes(x = Oferta)) +
  geom_line(aes(y = LucroEsp, color = "Lucro Esperado Proponente"), size = 1.5) +
  geom_line(aes(y = ProbAceite * 100, color = "Probabilidade de Aceite (%)"), size = 1, linetype = "dashed") +
  
  geom_vline(xintercept = 40, color = "blue", alpha = 0.5) +
  annotate("text", x = 40, y = 10, label = "Oferta Ótima Real (~40%)", angle = 90, vjust = -1) +
  
  geom_point(x = 1, y = 99, color = "red") +
  annotate("text", x = 5, y = 100, label = "Nash (Oferta Minima)", color = "red", hjust = 0) +
  
  scale_y_continuous(sec.axis = sec_axis(~., name = "Probabilidade (%)")) +
  scale_color_manual(values = c("Lucro Esperado Proponente" = "#002776", "Probabilidade de Aceite (%)" = "gray50")) +
  
  labs(title = "Módulo 47: Jogo do Ultimato (Justiça)",
       subtitle = "O medo da rejeição irracional leva a ofertas justas (40-50%) e não mínimas",
       x = "Valor Oferecido ao Respondente (% do Bolo)",
       y = "Valor Esperado",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico() +
  theme(legend.position = "bottom")

ggsave("output/mod47_jogo_ultimato.png", plot = p47, width = 8, height = 6, bg="white")
print("Módulo 47 executado com sucesso.")
