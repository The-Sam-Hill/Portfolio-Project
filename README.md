# Portfolio-Project
## Practice with SQL and Visualizations.
In this project I pull data from https://ourworldindata.org/covid-deaths to do some basic analysis and cleaning in SQL and then translate some of the data found into a Tableau dashboard.

I downloaded the data from the website listed above and then imported the CSV file into SSMS. After doing this, I ran various SQL queries to get different results and analyses from the data. You can view these scrips in the file `SQL Practice with Covid-19 Data.sql` It is not a deep dive into the data. It is just a peek into the windown of the dataset. I plan to amend the files into the future as I learn more advance SQL queries to get a more comprehensive look into the data.

After running these queries, I wanted to import some of my findings into Tableau for some visualizations of my findings. Since I only have Tableau public, I cannot directly link SSMS to Tableau. To get around this, I had to write SQL queries found in `Tableau Project Covid Dataset.sql` to get my data exported to Tableau. You can see these tables in excel from the following files:

* `Death Percentage table 1.xlsx`
* `Death count by Continent table 2.xlsx`
* `Infection count by country table 3.xlsx`
* `Total Infections by day table 4.xlsx`

After creating these files, I was finally able to import my findings into Tableau. You can view my created dashboard by downloading the `Covid Data for Tableau Practice With Dashboards.twbx` or by going to https://public.tableau.com/app/profile/william.hill8445
