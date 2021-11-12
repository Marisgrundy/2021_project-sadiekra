#Load Spotify package and get access
library(spotifyr)
Sys.setenv(SPOTIFY_CLIENT_ID = '097f7729a69e451da9624441ccdb54bd')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'd1b68552cb2843929b58db9b964f87e9')

access_token <- get_spotify_access_token()

#load other needed packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(dplyr)
library(knitr)
library(purrr)
library (ggmap)
library(leaflet)
library(kableExtra)

#load touring data
touring_data <-read.csv('data/locations.csv')
view(touring_data)

#load spotify music data
#Find artist id to access artist information
tom_petty <- get_artist_audio_features("Tom Petty and the Heartbreakers")
View(tom_petty)

#Load album dataset
petty_albums <- get_artist_albums(
  id= "4tX2TplrkIP4v05BNC903e",
  include_groups = c("album", "single", "appears_on", "compilation"),
  market = NULL,
  limit = 20,
  offset = 0,
  authorization = get_spotify_access_token(),
  include_meta_info = FALSE
)
View(petty_albums)
#Make table of albums
petty_albums%>%
  kable()
