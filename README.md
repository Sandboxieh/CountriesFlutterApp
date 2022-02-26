
![alt text](https://i.ibb.co/WkJDDGZ/metidelogo.png)

## Countries Interview Application

This is an interview application coded with dart using **Flutter SDK 2.0.5.**
    
  
## Table of contents

- [Demo](#demo)
- [Explanation](#explanation)
- [Tasks](#tasks)

## Demo 

A demo video available on youtube: https://youtu.be/sW_05GZXKRc

![https://youtu.be/sW_05GZXKRc](https://i.ibb.co/L5jqyvs/app.png)
  
## Explanation

***Splashscreen:*** 
In order to create the splashscreen I used the splashscreen package from pub.dev to make it easier and doesn't affect app performance.
***Home:*** 
In order to create the homepage I used basic and modern UI, fetching data from the api with basic user authentication then building a list of countries and displaying it via cards, once data is fetched the json response is saved in a file and when app restarts with no wifi, before fetching I tested if file is filled then get the country list from file else get the list from the api, one thing is I could have used hive database to cache the api respones but that will affect app performance so I sticked with file, kept it simple and clean so the user can use the app offline.
***Ordered items:***
So most of the countries from the json response has longitude and latitude position while others don't,
I used Haversine formula to calculate distance in km between Metide HR longitude & latitude and the country longitude & latitude,
based on that distance I sorted the countries list from the nearest to the farthest.
***Notes:***
So In order for the user to add a note for a specific country even offline, I used sqflite flutter package to save data locally and added for the user the ability to see their notes related to that specific country, update a note, delete a note and add a new note.
***Pull to refresh:***
I used flutter basic pull to refresh feature which is RefreshIndicator to refresh the data from the api.
***Unit & UI Test:***
For the unit testing I tested the form field validation while adding a new note if the title / content are empty or filled so bascially four tests two for the title and two for the content.
For the user interface test I used adding a new note interface, first assigning a key to form fields and the button to add a note, then filling them with data and testing if everything went corrent and the note was added.
  
## Tasks
![alt text](https://i.ibb.co/tDMHtQN/task.png)
