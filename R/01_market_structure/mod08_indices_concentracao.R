# Módulo 08: Índices de Concentração (Setor Bancário Brasil)
# Autor: Luiz Tiago Wilcke
# Descrição: Cálculo do HHI (Herfindahl-Hirschman Index) e CR5 para o setor bancário brasileiro.

source("R/00_setup_theme.R")

# Dados REAIS aproximados (Base: Relatórios de Economia Bancária BCB Recentes)
# Market Share em Crédito (%)
bancos <- c("Caixa", "Banco do Brasil", "Itaú", "Bradesco", "Santander", "Outros")
share <- c(22.5, 18.2, 16.5, 15.1, 9.8, 17.9) # Exemplo representativo

df_bancos <- data.frame(Banco = bancos, Share = share)

# Cálculo CR5 (Concentration Ratio 5 maiores)
cr5 <- sum(df_bancos$Share[1:5])

# Cálculo HHI
# HHI = Somatório (Share^2). Se Share em %, HHI vai de 0 a 10.000.
# Nota: 'Outros' deve ser tratado com cuidado, mas para simplificação assumiremos que é pulverizado.
# Para o cálculo correto do HHI da parte "Outros", o ideal seria ter cada banco pequeno.
# Como proxy, vamos calcular o HHI dos Top 5 e adicionar uma estimativa para o resto.
hhi_top5 <- sum(df_bancos$Share[1:5]^2)
hhi_total_est <- hhi_top5 + (17.9 / 50)^2 * 50 # Supõe 50 bancos pequenos dividindo o resto

# Classificação CADE / DOJ
classificacao <- ifelse(hhi_total_est > 2500, "Altamente Concentrado", 
                        ifelse(hhi_total_est > 1500, "Moderadamente Concentrado", "Desconcentrado"))

# Plotagem
p8 <- ggplot(df_bancos, aes(x = reorder(Banco, -Share), y = Share, fill = Banco)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(Share, "%")), vjust = -0.5) +
  
  annotate("text", x = 4, y = 20, label = paste("CR5: ", cr5, "%"), size = 5, color = "red", fontface = "bold") +
  annotate("text", x = 4, y = 18, label = paste("HHI Estimação: ", round(hhi_total_est)), size = 5, color = "darkblue", fontface = "bold") +
  annotate("text", x = 4, y = 16, label = classificacao, size = 4, color = "darkblue") +
  
  scale_fill_brewer(palette = "Blues") +
  labs(title = "Módulo 08: Concentração Bancária no Brasil",
       subtitle = "Market Share (Crédito) e Índices de Concentração",
       x = "Instituição Financeira",
       y = "Participação de Mercado (%)",
       caption = "Autor: Luiz Tiago Wilcke | Dados: Estimativas baseadas no BCB") +
  theme_economico() +
  theme(legend.position = "none")

ggsave("output/mod08_indices_concentracao.png", plot = p8, width = 9, height = 6, bg = "white")
print("Módulo 08 executado com sucesso.")
