# Módulo 02: Duopólio de Cournot (Competição por Quantidade)
# Autor: Luiz Tiago Wilcke
# Descrição: Simula duas empresas competindo por quantidade (ex: Duas grandes companhias aéreas em uma rota específica).

source("R/00_setup_theme.R")

# Parâmetros
a <- 200 # Demanda de mercado
b <- 1
c1 <- 20 # Custo marginal empresa 1
c2 <- 20 # Custo marginal empresa 2 (simétrico para facilitar o gráfico base)

# Funções de Reação
# Empresa 1 maximiza lucro: (a - b(q1 + q2) - c1)q1
# dLucro1/dq1 = a - 2bq1 - bq2 - c1 = 0 -> q1* = (a - c1 - bq2) / 2b
funcao_reacao_1 <- function(q2) { (a - c1 - b * q2) / (2 * b) }

# Empresa 2 dLucro2/dq2 = a - bq1 - 2bq2 - c2 = 0 -> q2* = (a - c2 - bq1) / 2b
funcao_reacao_2 <- function(q1) { (a - c2 - b * q1) / (2 * b) }

# Equilíbrio de Nash (Interseção)
# q1 = (a - c - b((a - c - bq1)/2b)) / 2b
# ... Solução analítica para custos simétricos: q1 = q2 = (a-c)/3b
q_nash <- (a - c1) / (3 * b)

# Dados para plotagem das curvas de reação
q_range <- seq(0, (a - c1)/b, length.out = 100)
df_reacao <- data.frame(q_competidor = q_range)

# Calcular Q1 ótimo dado Q2 (Reaction Curve 1)
df_reacao$q1_otimo <- pmax(0, (a - c1 - b * df_reacao$q_competidor) / (2 * b))

# Calcular Q2 ótimo dado Q1 (Reaction Curve 2 - note que o eixo X será q1 neste caso)
# Para plotar na mesma estrutura, vamos criar um segundo dataframe
df_rc1 <- data.frame(x = df_reacao$q1_otimo, y = df_reacao$q_competidor, curve = "Reação Empresa 1 (x dado y)")
# A curva de reação 2 nos dá q2 (y) dado q1 (x)
df_rc2 <- data.frame(x = q_range, y = pmax(0, (a - c2 - b * q_range) / (2 * b)), curve = "Reação Empresa 2 (y dado x)")

# Plotagem
p2 <- ggplot() +
  # Curva de Reação da Empresa 1 (q1 em função de q2, mas plotamos q1 no eixo X)
  # R1: q1 = (A - q2)/2. Se q2=0, q1=A/2. Se q1=0, q2=A.
  geom_line(data = df_rc2, aes(x = x, y = y, color = "Empresa 2 (Azul)"), size = 1.2) +
  geom_path(data = df_rc1, aes(x = x, y = y, color = "Empresa 1 (Verde)"), size = 1.2) + # Usando path para inverter os eixos corretamente visualmente se necessário
  
  # Ponto de Equilíbrio de Nash
  geom_point(aes(x = q_nash, y = q_nash), size = 5, color = "red") +
  annotate("text", x = q_nash + 10, y = q_nash + 10, label = paste("Nash: q1=q2=", round(q_nash, 1)), fontface = "bold") +
  
  scale_color_manual(values = c("Empresa 1 (Verde)" = "#009c3b", "Empresa 2 (Azul)" = "#002776")) +
  labs(title = "Módulo 02: Duopólio de Cournot - Curvas de Reação",
       subtitle = "Interseção define o Equilíbrio de Nash das quantidades",
       x = "Quantidade Produzida Empresa 1",
       y = "Quantidade Produzida Empresa 2",
       color = "Empresas",
       caption = "Autor: Luiz Tiago Wilcke | Teoria dos Jogos e Microeconomia") +
  theme_economico() +
  coord_fixed(ratio = 1)

ggsave("output/mod02_duopolio_cournot.png", plot = p2, width = 8, height = 8, bg = "white")
print("Módulo 02 executado com sucesso.")
