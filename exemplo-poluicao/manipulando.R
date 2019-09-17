# 4. Pipe -----------------------------------------------------------------

# g(f(x)) = x %>% f() %>% g()

# Receita de bolo sem pipe. Tente entender o que é preciso fazer.

esfrie(
  asse(
    coloque(
      bata(
        acrescente(
          recipiente(
            rep(
              "farinha", 
              2
            ), 
            "água", "fermento", "leite", "óleo"
          ), 
          "farinha", até = "macio"
        ), 
        duração = "3min"
      ), 
      lugar = "forma", tipo = "grande", untada = TRUE
    ), 
    duração = "50min"
  ), 
  "geladeira", "20min"
)

# Veja como o código acima pode ser reescrito utilizando-se o pipe. 
# Agora realmente se parece com uma receita de bolo.

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", até = "macio") %>%
  bata(duração = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
  asse(duração = "50min") %>%
  esfrie("geladeira", "20min")

# ATALHO: CTRL + SHIFT + M

# 5. Vamos criar uma tabela descritiva ------------------------------------

library(dplyr)
library(tidyr)
library(readxl)
library(lubridate)
wamorim@curso-r.com

base_completa <- read_excel("exemplo-poluicao/docs/tabelas.xlsx")

base_completa %>% 
  mutate(
    dayofweek = lubridate::wday(
      date, 
      label = TRUE,
      locale = "pt_BR.UTF-8"
    )
  ) %>%
  gather(poluente, conc, mass_co, mass_no) %>%
  group_by(poluente, dayofweek) %>%
  summarise(media_poluente = mean(conc, na.rm = TRUE)) %>% 
  spread(dayofweek, media_poluente) %>%
  ungroup() %>% 
  mutate(
    poluente = case_when(
      poluente == "mass_co" ~ "CO",
      TRUE ~ "NO"
    )
  ) %>% 
  writexl::write_xlsx("minha_tabela.xlsx")
  
  
  
  
  
  
  
  
  
  
