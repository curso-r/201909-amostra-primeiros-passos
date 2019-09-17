# antes de continuarmos, vamos instalar pacotes!!!
install.packages("tidyverse")
install.packages("writexl")

# 1. Vamos carregar uma tabela do Excel -----------------------------------

library(readxl)

base <- read_excel("data-raw/CO-Pinheiros-201709.xlsx")
View(base)

# 2. Vamos ler todas as bases de CO, criando uma única base ---------------

library(purrr)

arquivos <- list.files(path = "data-raw/", full.names = TRUE)

for(arq in arquivos) {

  if(arq == arquivos[1]) {
    base_completa <- read_excel(path = arq)
  } else {
    base_completa <- rbind(
      base_completa, 
      read_excel(path = arq)
    )
  }

}

base_completa <- map_dfr(arquivos, read_excel)

# 3. Vamos ler todos os arquivos de CO e NO, criando uma única base -------

library(dplyr)

arquivos_CO <- list.files(
  path = "data-raw/", 
  pattern = "CO",
  full.names = TRUE
)

arquivos_NO <- list.files(
  path = "data-raw/", 
  pattern = "NO",
  full.names = TRUE
)

base_CO <- map_dfr(arquivos_CO, read_excel)
base_NO <- map_dfr(arquivos_NO, read_excel)

base_CO <- select(base_CO, time, conc_CO = mass_conc)
base_NO <- select(base_NO, time, conc_NO = mass_conc)

base_completa_2 <- left_join(base_CO, base_NO, by = "time")


