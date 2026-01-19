# Configuração do Tema e Bibliotecas
# Autor: Luiz Tiago Wilcke

# Verificar e carregar pacotes
required_packages <- c("ggplot2", "dplyr", "tidyr", "gridExtra")

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    warning(paste("Pacote", pkg, "não encontrado. Tentando instalar..."))
    # install.packages(pkg, repos = "http://cran.us.r-project.org")
    #library(pkg, character.only = TRUE)
  }
}

library(ggplot2)

# Definir tema padrão para os gráficos
theme_economico <- function() {
  theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(face = "bold", hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5, color = "gray40"),
      axis.title = element_text(face = "bold"),
      legend.position = "bottom",
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "white", color = NA),
      plot.background = element_rect(fill = "white", color = NA)
    )
}

# Cores padrão (inspiradas no Brasil mas sóbrias)
cores_brasil <- c("#009c3b", "#ffdf00", "#002776", "#C8102E") # Verde, Amarelo, Azul e um Vermelho complementar
