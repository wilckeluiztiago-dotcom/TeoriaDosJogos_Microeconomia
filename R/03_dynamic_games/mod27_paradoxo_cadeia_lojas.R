# Módulo 27: Paradoxo da Cadeia de Lojas (Jogos Finitos)
# Autor: Luiz Tiago Wilcke
# Descrição: Indução reversa mostra que em jogos finitos a cooperação/reputação não se sustenta.

source("R/00_setup_theme.R")

# Cadeia de Lojas em 20 cidades. Entrante em cada cidade sequencialmente.
# Se Lutar em T=20 não racional, então Entrante entra em 20.
# Se Entrante entra em 20, Lutar em 19 não cria reputação para 20. 
# Unraveling até T=1.

cidades <- 20:1
decisao_racional <- rep("Acomodar (Sem Reputação)", 20)
decisao_intuitiva <- c(rep("Lutar (Construir Reputação)", 15), rep("Acomodar", 5))

df_chain <- data.frame(
  Cidade = cidades,
  Teoria = 1, # Dummy
  Pratica = ifelse(cidades > 5, 2, 1)
)

p27 <- ggplot(df_chain, aes(x = Cidade)) +
  geom_step(aes(y = Pratica, color = "Comportamento Humano (Intuição)"), size = 1.2) +
  geom_line(aes(y = Teoria, color = "Teoria dos Jogos (Indução Reversa)"), size = 1.2, linetype = "dashed") +
  
  scale_y_continuous(breaks = c(1, 2), labels = c("Acomodar", "Lutar")) +
  scale_x_reverse() +
  
  labs(title = "Módulo 27: O Paradoxo da Cadeia de Lojas (Selten)",
       subtitle = "A teoria prediz Acomodação sempre, mas na prática luta-se no início para criar reputação",
       x = "Cidades Restantes (Cronológico: 20 -> 1)",
       y = "Decisão da Incumbente",
       color = "Modelo",
       caption = "Autor: Luiz Tiago Wilcke") +
  theme_economico()

ggsave("output/mod27_paradoxo_cadeia_lojas.png", plot = p27, width = 8, height = 6, bg="white")
print("Módulo 27 executado com sucesso.")
