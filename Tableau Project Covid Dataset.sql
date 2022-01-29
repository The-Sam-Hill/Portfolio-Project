-- This Query is to get an total death and death percentage to the total cases for a total death rate
select SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as bigint)) as Total_Deaths, Sum(cast(new_deaths as bigint))/SUM(new_cases)*100 as DeathPercentage
From Portfolio_Project..CovidDeath
Where continent is not null
order by 1,2

--This Query is to get Total Deaths Per Continent)
Select location as Location, SUM(cast(new_deaths as bigint)) as TotalDeathCount
From Portfolio_Project..CovidDeath
Where continent is null
--I had to include this to exclude these numbers because they are not continents and irrelevent for this examination
and location not in ('World', 'European Union', 'International', 'Upper middle income', 'High income', 'Lower middle income', 'Lower middle income', 'Low income')
Group by location
order by TotalDeathCount desc

--This Query is to count the total infections for each listed country in the data
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Portfolio_Project..CovidDeath
Group by Location, Population
order by PercentPopulationInfected desc

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Portfolio_Project..CovidDeath
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc