# Steam-sales-analysis
A personal project looking into data of top 1000 most reviewed video games on platform Steam

# Readme/Documentation


This is a personal project in which the goal was to look for trends and shared characteristics among the top 1000 most popular/most reviewed video games on the Steam storefront. This readme details the data cleaning process for the dataset used for this project and explains the file contents available in the repository.

Steam is one of the biggest, most influential digital store platforms for video games, with over 120 million monthly active users, and peak concurrent users record of 33 million (January 2024). 
In 2024, Steam is a host of well over 50 000 video games, and just in 2023 alone over 14 000 new games were released on the platform. Most major video games publishers release games on Steam, as it’s one of the key platforms for generating revenue and growing intellectual properties in video game market. Therefore, data analysis of trends on the platform can be a crucial step for success of a particular game.

The analysis for this project used dataset from Kaggle, available at the link below:

https://www.kaggle.com/datasets/rahuldabholkar/steam-pc-games

The dataset was created in February of 2023 and it contains data for all 50 000+ games available on Steam.
All credits for creating the dataset goes to Rahul Dabholkar.


## Data cleaning and exploratory data analysis (EDA) process of the project:

1. Downloaded the dataset (**games_data.csv**) and converted it to the JSON format due to problems with loading it in CSV with Python.

2. Loaded the dataset and created a dataframe using pandas library and Jupyter Notebook.

3. Checked dataframe integrity with pandas, created main dataset for analysis with top 1000 most reviewed games on Steam. Simplified the number of genres from 132 to 46, simplified multiplayer_or_singleplayer column. The code along with more detailed comments is available in a **steam sales.ipynb** file.

4. Saved the dataset in xlsx for further cleaning in Excel (**steam_sales_cleaned_in_pandas.xlsx**).

5. Data cleaning in excel: trimmed whitespaces, removed one duplicate (Resident Evil 4), removed one game with ”????” title, removed ”” symbols from some game titles and developer names for unification and correct sorting, made each column the correct datatype,  standardized publisher names (ex. ”Ubisoft Entertainment” to just ”Ubisoft”). Furthermore, in price and dc_price (discounted_price) columns deleted the ”” symbols, changed Free to Play to 0 (zero) and converted the prices from INR to USD (all prices were multiplied by 0.012 as of currency rates from February 2024). Also, standardized multiplayer_or_singleplayer column (changed the ”MMO” and ”online multiplayer” to just ”multiplayer”). The cleaned data can be viewed in a file named **steam_sales_cleaned_in_excel.xlsx**.

6. Data analysis in SQL. Most of the analysis was conducted using the BigQuery Google Cloud, with some support of MySQL Workbench. The Sandbox (free) version of BigQuery doesn’t allow for inserting new data into created tables, therefore a couple of supplementary tables were created along with the needed data using MySQL Workbench and then imported into BigQuery.

7. All queries along with commentary can be viewed in a **steam_sales_queries.txt** file.

8. Further analysis (ex. mean, standard deviation and correlation of variables) utilizing R language and RStudio IDE. Created visualizations using ggplot2 library. The raw code is available in a **steam_sales_analysis.R** file. Also, created the **steam_sales_%.xlsx** file, which has the same contents as steam_sales_cleaned_in_excel, except the percent_positive column datatype was changed from percentage to numbers, since in the original file RStudio was having problems with converting this particular column from character/string type to integers or doubles/floats.

9. Created PowerBI interactive dashboard in PowerBI Desktop. The dashboard is accessible through the **steam_sales_dashboard.pbix** file.

10. Created brief presentation summarizing the analysis’ findings. The presentation was created in Apple Keyonote and then exported to a pdf format (**steam sales analysis.pdf**).
