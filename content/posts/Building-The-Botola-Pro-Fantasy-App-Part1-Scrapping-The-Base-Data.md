---
title: "Building the BotolaPro Fantasy App Part1: Scrapping the Base Data"
date: 2025-12-28
draft: false
tags: ["Backend", "software", "systems", "Architecture"]
categories: ["Backend", "software", "Architecture"]
slug: "Building the BotolaPro Fantasy App Part1: Scrapping the Base Data"
description: "Building a fantasy football app for Morocco’s Botola Pro as a learning project, focusing on system architecture, data scraping challenges, and real-world constraints in mobile application development."
keywords: ["Go", "Backend", "Software Engineering", "Systems", "Fantasy Game", "Mobile App", "Architecture"]
---


# Building the BotolaPro Fantasy App Part1: Scrapping the Base Data

# Introduction:

If you are following my previous blogs, you may have noticed that i wrote a blog post about why i stopped watching football. You might be thinking: what is this guy doing? He Said he stopped watching football, and now he’s trying to build football game. Let me clarify why i’m doing this.

My main Goal is to learn about mobile application development. While exploring ideas, I realized that there is no fantasy app for the Moroccan Botola Pro League. I thought this could be a good exercise to apply the skills I will learn during my mobile development journey, and it also seemed quite challenging.

i found out that there’s no fantasy app for the moroccan botola pro league, i thoughts it may be a good exercice to apply the skills that i will learn in the mobile development, and quite challenging.

This project is not really about football itself. it’s about the technical challanges and what i can learn from this exercise. I have always liked building things from a simple idea into a complete product that can be useful for users.

I am forcing myself to commit to this challange until I finish it. Let’s get into the details.

# Architecture:

For those who don’t know what a fantasy game is, it’s a game where users have a limited budget. Each user can chose to buy 15 players within this budget: 11 starter and 4 on the bench.

After each game week, depending on the performance of the real players  that you selected in the league, you receive a total of points. These points determine your ranking on the leaderboard, either globally or privately among your friends.

it sounds easy to implement, but it involves a lot of details. The first thing i thought about was the data.

- **Base Data**:  which includes Teams, Players, Fixtures,….
- **Stats Data** which includes players stats, match results,…

I searched for paid or free APIs that could provide this data, but i didn’t find a good one that fully met my needs. So i decided to scrape some websites to collect the informations. I know this can be legally questionable, but as i mentioned earlier, this is purely a learning project meant to explore technical concepts.

Beyond the data, i need to create an engine that calculates the result after each game week. The Engine updates each player’s performance and ensures that every user receives the latest points for their squad once the games are completed.

Finally, There’s the  core API, which handles all user actions within the app and manages its interaction with the calculation engine.

I decoupled the application into 3 components, as shown below:

![image.png](/images/Building-The-Botola-Pro-Fantasy-App-Part1-Scrapping-The-Base-Data/image1.png)

This is My first version of the architecture, as i get more involved the project, new  constraints may appear, and the design will probably evolve.

So I will explain each Service Separately:

### Scrapper Service:

It’s main purpose is to scrape data related to  finished games of each fixtures, and stats of each players, and any other useful data that helps the engine to do it’s job correctly.

### Engine Service:

This Service is responsible for calculating the players points after each match in a game week. it’s regularly receives data from the Scraper Service and it updates it’s Database with latest data of the  played games.

### Core API Service:

This is the API that users interact with to fetch their data, such as squad, leaderboard, account management,… it acts as the main entry point of the application.

And about the technologies i plan to use for this project, they are as follows:

1. ✅ **GraphQL** for Core API → React Native (Typescript)
2. ✅ **RabbitMQ** for Scraper → Engine communication
3. ✅ **REST** for Core API → Engine (simpler to start)
4. ✅ **Python** for scraper (Python has very good libraries for web scraping)
5. ✅ **Go** for Core API and Engine.
6. ✅ GitHub Actions for CI/CD.
7. ✅ Docker (K8S if i needed it).
8. ✅ AWS For Deployment.

# Base Data Scrapping:

I started scraping the base data (Teams, Players, Fixtures,…). It turned out to be a fun and challenging task. I reversed-engineered the API of SofaScore API to collect the teams, players. However when it come to fixtures I noticed thato nly past fixtures were available from the start of the league up to the current game week (week 8).

To get the full season schedule, I moved to the official website of the moroccan federation of football, where i found all the program of the whole season. The challenge with the Moroccan league is that it does not have fully scheduled the Calendar like the premiere league where match dates and times are known in advance. In Morocco, each game week is scheduled separately. this is something I need to take into account, as the scraper should be triggered every time a new game week schedule is published.

To Accomplish this task I used:

**ZenDriver** for scraping Data, and **SQLAlchemy** ORM to interact with Database and  store Data.

Here’s the Final Result of scrapping:

![Teams Data](/images/Building-The-Botola-Pro-Fantasy-App-Part1-Scrapping-The-Base-Data/image2.png)

Teams Data

![Fixtures Data](/images/Building-The-Botola-Pro-Fantasy-App-Part1-Scrapping-The-Base-Data/image3.png)

Fixtures Data

![Players Data](/images/Building-The-Botola-Pro-Fantasy-App-Part1-Scrapping-The-Base-Data/image4.png)

Players Data

# Next Steps:

After defining the architecture of the project, I decided to start with the scraper Service and the UI design. I chose to begin with the Scraper Service because all the other services depend on it.

![image.png](/images/Building-The-Botola-Pro-Fantasy-App-Part1-Scrapping-The-Base-Data/image5.png)

As for the UI, I’m not very good at UI design, which is why I chose to work on it simultaneously with the Scraper Service.

See you in the next blog post, where I’ll share my progress. If you’ve followed along until here, thank you for your time.
