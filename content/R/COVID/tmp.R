# The Race to Open
OR.County.COVID %>% filter(RankC > 26) %>%  
    ggplot(aes(x = RankC, y = Number.of.cases, fill=County, color=County, label=County)) +  
    geom_col() +  
    geom_text(hjust = "left") +  
    geom_text(aes(label=as.character(New.Cases)), hjust = "right", color="white") +  
    scale_x_discrete("") +  
    coord_flip(clip="off") +  
    scale_fill_viridis_d() +  
    scale_color_viridis_d() +  
    guides(fill=FALSE, color=FALSE) +  
    labs(title='Cases in Oregon by County',  
         subtitle='{frame_time}',  
         caption='Source: OHA Data',  
         y="Confirmed COVID-19 Cases") +  
    hrbrthemes::theme_ipsum(plot_title_size = 32, subtitle_size = 24, caption_size = 20, base_size = 20) +  
    gganimate::transition_time(Scraped.date) -> p1  #<<
