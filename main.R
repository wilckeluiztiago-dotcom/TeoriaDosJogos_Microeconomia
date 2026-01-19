# Projeto: Teoria dos Jogos e Microeconomia no Brasil
# Autor: Luiz Tiago Wilcke
# Script Principal: Executa todos os 50 módulos e gera os gráficos na pasta output/

start_time <- Sys.time()
cat("=== Iniciando Execução do Projeto Teoria dos Jogos ===\n")
cat("Autor: Luiz Tiago Wilcke\n")
cat("Data:", format(Sys.time(), "%d/%m/%Y %H:%M"), "\n\n")

# Listar todos os arquivos R nos subdiretórios, exceto setup e main
files <- list.files("R", recursive = TRUE, full.names = TRUE, pattern = "\\.R$")
files <- files[!grepl("00_setup_theme.R", files)] # Remove setup (chamado internamente)
files <- sort(files) # Garante ordem numérica

sucesso <- 0
falha <- 0

for (f in files) {
  cat("Executando:", basename(f), "...\n")
  tryCatch({
    source(f, echo=FALSE)
    sucesso <- sucesso + 1
  }, error = function(e) {
    cat("ERRO em", basename(f), ":", e$message, "\n")
    falha <- falha + 1
  })
}

cat("\n=== Finalizado ===\n")
cat("Módulos Executados com Sucesso:", sucesso, "\n")
cat("Falhas:", falha, "\n")
cat("Tempo Total:", round(difftime(Sys.time(), start_time, units = "secs"), 2), "segundos\n")
cat("Outputs salvos em: /home/luiztiagowilcke188/Área de trabalho/ModeloTeoriaDosJogos/output/\n")
