# my_youtube

A new Flutter project(Youtube Data Api).

## Getting Started

##DEPENDENCIES 

#for state management
 
 stacked: ^1.7.6
 
 get_it: ^4.0.4
 
 stacked_services: ^0.5.4+2

#for network

http: ^0.12.2 

connectivity: ^0.4.9+3

#image  

cached_network_image: ^2.3.2+1

#videoplayer

youtube_player_flutter: ^7.0.0+7

#data parsing

intl: ^0.16.1
 



##Features///

## App uses MMVM architecture to reduce code complexity and provide more flexibility.

1) onTextChange search query ( this Query work after entering text length > 3  and debounce for 500ms to reduce API Quota Usage)

![til](app_state.gif)

2) inifinite listscroll fully implemented

![till](player-state.gif)

3) video player for playing selected videos

4) comment are also fetched from API and visible on screen.

![til](network_state.gif)


5) forever stream for network connection runs to provide the network state

