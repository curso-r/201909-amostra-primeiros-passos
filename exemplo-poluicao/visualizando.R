# 6. Vamos criar alguns gráficos ------------------------------------------

# Séries temporais dos poluentes

library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)

base_completa <- read_excel("exemplo-poluicao/docs/tabelas.xlsx")

# Primeiro começamos manipulando a base
base_completa %>% 
  gather(poluente, conc, mass_co, mass_no) %>% 
  mutate(
    poluente = case_when(
      poluente == "mass_co" ~ "CO",
      TRUE ~ "NO"
    )
  ) %>% 
  # Aqui começa o gráfico. Repare que usamos o "+" em vez do %>% para juntar as linhas.
  ggplot(aes(x = date, y = conc)) +
  geom_line() +
  facet_wrap(~poluente, scales = "free") + #Teste retirar o "scales" da função
  labs(x = "Data", y = "Concentração")

# Médias horárias

base_completa %>% 
  gather(poluente, conc, mass_co, mass_no) %>% 
  mutate(
    poluente = case_when(
      poluente == "mass_co" ~ "CO",
      TRUE ~ "NO"
    )
  ) %>%
  group_by(poluente, hour) %>% 
  summarise(conc_media = mean(conc, na.rm = TRUE)) %>% 
  ggplot(aes(x = hour, y = conc_media)) +
  geom_line() +
  facet_wrap(~poluente, scales = "free") +
  labs(x = "Hora do dia", y = "Concentração")
