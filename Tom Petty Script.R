#Load Spotify package and get access
library(spotifyr)
Sys.setenv(SPOTIFY_CLIENT_ID = '097f7729a69e451da9624441ccdb54bd')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'd1b68552cb2843929b58db9b964f87e9')

access_token <- get_spotify_access_token()

#load other needed packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(knitr)
library(purrr)
library (tidygeocoder)
library(leaflet)
library(kableExtra)
library(igraph)
library(ggraph)

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

#geocode locations and save as its own csv

touring_geo <- touring_data %>% geocode (City, method = 'osm', lat = latitude , long = longitude)%>% 
  write_csv(file="data/touring_geo.csv")
view(touring_geo)

#read in geocoded csv
touring_geo=read_csv("data/touring_geo.csv")

#Map the locations with leaflet
map_tour <- leaflet(touring_geo) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addCircleMarkers(radius = 1, popup = touring_geo$City,
                   color = "#7625be")
map_tour

#Find the top 5 most visited cities
top_5<-touring_geo%>%
  filter(City != "NA")%>%
  count(City)%>%
  arrange(desc(n))
top_5

kable(top_5, caption = "Top 5 Touring Locations") %>%
  kable_styling(latex_options = "striped")%>%
  row_spec(1:5, background = "#Cab5dc")%>%
  scroll_box(width = "600px", height="350px")
