inicialmente a ideia do projeto era buscar dados sobre a utlização do spotify pelo usuário por meio da API, entretanto,
obtive muitos problemas ao tentar conseguir autênticar a conta e então conseguir os dados. Revirei pelo menos 90% da
internet tentando encontrar meu erro. Mesmo dando ctrl C + crtl V em códigos alheios a autorização não funcionava, perdi
*muito* tempo tentando encontrar o erro mas ainda não consegui. Isso é o que eu tenho até agora:

install.packages('spotifyr')
install.packages("tidyverse")
install.packages('knitr', dependencies = TRUE)
install.packages('ggjoy')
install.packages("ggplot2", dependencies = TRUE)

library(spotifyr)
library(ggjoy)    
library(ggplot2)   
library(tidyverse) 
library(knitr)     
library(lubridate) 

#Autenticação

Sys.setenv(SPOTIFY_CLIENT_ID = 'eaacab911c8f4b49bb075c73f6cdc1a6')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '2fde2e9a7bde4ce6ae3574cdee508b0b')
access_token <- get_spotify_access_token()

#Tracks recentes

get_my_recently_played(limit = 5) %>% 
  mutate(artist.name = map_chr(track.artists, function(x) x$name[1]),
         played_at = as_datetime(played_at)) %>% 
  select(track.name, artist.name, track.album.name, played_at) %>% 
  head()
  
#Top Artistas

get_my_top_artists_or_tracks(type = 'artists', time_range = 'long_term', limit = 5) %>% 
  select(name, genres) %>% 
  rowwise %>% 
  mutate(genres = paste(genres, collapse = ', ')) %>% 
  kable()
