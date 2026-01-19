# Teoria dos Jogos Aplicada à Microeconomia (Brasil)

**Autor:** Luiz Tiago Wilcke  
**Linguagem:** R (ggplot2)  
**Módulos:** 50 Simulações e Visualizações  
**Dados:** CADE, Banco Central do Brasil, Leilões do Pré-Sal (Petrobras)

---

## 📌 Descrição do Projeto
Este projeto desenvolve uma suite completa de **50 módulos computacionais em R** para modelar interações estratégicas na economia brasileira. O objetivo é conectar a teoria matemática rigorosa (Teoria dos Jogos) com aplicações práticas e dados reais (Concentração Bancária, Leilões de 5G, Regulação Antitruste).

Cada módulo gera visualizações gráficas de alta qualidade utilizando `ggplot2` com um tema profissional padronizado.

## 🚀 Como Executar
O projeto é orquestrado pelo script `main.R`.

```bash
Rscript main.R
```
Os gráficos serão gerados na pasta `output/`.

---

## 📚 Estrutura dos Módulos

### 1. Fundamentos e Estruturas de Mercado
Análise de monopólios, oligopólios e concorrência.
- **Mod 01:** Monopólio vs Concorrência Perfeita (Deadweight Loss)
- **Mod 02:** Duopólio de Cournot (Competição por Quantidade: $q_i = R_i(q_j)$)
- **Mod 03:** Duopólio de Bertrand (Paradoxo: $P = Cmg$)
- **Mod 04:** Liderança de Stackelberg (Vantagem do Líder)
- **Mod 05:** Cartéis e Incentivos à Traição
- ... (até Mod 10)

### 2. Teoria dos Jogos Estática
Equilíbrios de Nash em jogos simultâneos.
- **Mod 11:** Equilíbrio de Nash ($BR_i(s_{-i}) = s_i$)
- **Mod 12:** Dilema do Prisioneiro (Instabilidade de Acordos)
- **Mod 13:** Jogos de Coordenação (Padrões Tecnológicos - 5G)
- **Mod 15:** Matching Pennies (Ciclos de Fiscalização)
- ... (até Mod 20)

### 3. Teoria dos Jogos Dinâmica
Jogos sequenciais, tempo e credibilidade.
- **Mod 21:** Forma Extensiva (Árvores de Decisão)
- **Mod 22:** Indução Reversa (Backward Induction)
- **Mod 23:** SPNE (Subgame Perfect Nash Equilibrium)
- **Mod 24:** Ameaças Credíveis e Compromisso (Queimando Pontes)
- **Mod 28:** Jogos Repetidos e o Fator de Desconto ($\delta > \frac{g}{g+l}$)
- ... (até Mod 30)

### 4. Leilões e Negociação
Mecanismos de alocação e barganha.
- **Mod 31:** Leilão de Primeiro Preço (Bid Shading: $b = \frac{N-1}{N}v$)
- **Mod 32:** Leilão de Vickrey (Truthful Bidding: $b = v$)
- **Mod 34:** Winner's Curse (Leilões de Petróleo)
- **Mod 37:** Barganha de Nash (Maximização do Produto $(u_1 - d_1)(u_2 - d_2)$)
- ... (até Mod 40)

### 5. Tópicos Avançados
Regulação, Informação e Comportamento.
- **Mod 41:** Regulação Antitruste (CADE e Índices HHI)
- **Mod 42:** Seleção Adversa (Market for Lemons - Akerlof)
- **Mod 43:** Moral Hazard (Mercado de Seguros)
- **Mod 44:** Sinalização (Modelo de Spence)
- **Mod 45:** Jogo Evolutivo (Replicator Dynamics)
- ... (até Mod 50)

---

## 📐 Equações Fundamentais

### Equilíbrio de Nash
Um perfil de estratégias $s^* = (s_1^*, \dots, s_n^*)$ é um Equilíbrio de Nash se:
$$ u_i(s_i^*, s_{-i}^*) \geq u_i(s_i, s_{-i}^*) \quad \forall s_i \in S_i, \forall i $$

### Duopólio de Cournot
A quantidade de equilíbrio para custos simétricos $c$ e demanda $P = a - bQ$ é:
$$ q_1^* = q_2^* = \frac{a - c}{3b} $$

### Índice de Lerner (Poder de Mercado)
Medida de poder de monopólio inversamente proporcional à elasticidade $\varepsilon$:
$$ L = \frac{P - Cmg}{P} = -\frac{1}{\varepsilon} $$

### Barganha de Rubinstein
A fatia do proponente em um jogo de ofertas alternadas infinitas:
$$ x^* = \frac{1 - \delta_2}{1 - \delta_1 \delta_2} $$

---

**Autor:** Luiz Tiago Wilcke  
Estudante de Estatística - Unisociesc
