WorldCupFinal
=============

Code to harvest and visualize tweets sent during the world cup final.

How to harvest tweets
---------------------

To do this I used the TwitteR package in R. The script I wrote takes a list of keywords to search for and goes to twitter one at a time and searches for these keywords. This is all run in the main_process.r script above (which sources in a script to do the actual tweet retrieval). This will not work straight out of the box as you have to set up your twitter credentials and save them as an R object to be loaded in on line 18. More info on this can be found in this [useful blog post](http://thinktostart.wordpress.com/2013/05/22/twitter-authentification-with-r)

How to create a word cloud
--------------------------

The 'main_process.r' script above churned out a TONNE of .rdata files so I used the 'summerise.r' script to take all of these and combine them into one manageable dataframe (saved as 'AllTweets.rdata'). From this I saved the text of the tweets to a .txt file. Now, there are ways to do word clouds in R but they aren't great looking. I first used the online tool [wordle](http://www.wordle.net/) to produce this image

![wordle wordcloud](https://raw.githubusercontent.com/AugustT/WorldCupFinal/master/graphs/wordle.jpg)

This was pretty good to my eye but then I found [tagxedo](http://www.tagxedo.com/) which goes to another level by allowing you to upload an image which it will use to shape and colour the wordcloud. So I used the world cup logo for my word cloud and created the image below.

![tagxedo wordcloud](https://raw.githubusercontent.com/AugustT/WorldCupFinal/master/graphs/cup_small.jpg)

The hard core coders will probably think, 'Why didn't you do it all in R?', I think the above picture is answer enough.

How to create a animated kml
----------------------------

I came across the sp and rgdal packages in R pretty recently and was excited to find out that R can write spatial layers as .kml files which can be opened in Google Earth. I was also amazed to see that you can write .kml files using time and date stamped data and then animate them in Google earth. I used the 'graphs.r' file to read in the tweets and create the animated .kml file 'worldcup.kml' (in the graphs folder above). 

Opening this .kml file in Google Earth you can create tour viewpoints which Google Earth will pan between. I also changed the icon to the World Cup Logo. With all these changes made I saved the tour as a .kmz file, this allows you to save tour points and icon changes etc (again, in the graphs folder above).

Using [CamStudio](http://camstudio.org/) I then filmed my screen as I panned around the globe with the animation playing. Once I was done I uplaoded the video to YouTube and added a bit of backing music, here is the result:

[![World Cup Tweets From Space](http://img.youtube.com/vi/nVdeXUwnBo0/0.jpg)](http://www.youtube.com/watch?v=nVdeXUwnBo0)
