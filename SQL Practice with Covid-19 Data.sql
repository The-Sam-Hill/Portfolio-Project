Select *
From Portfolio_Project..CovidDeath
Order by 3, 4

-- Verifying data transferred properly
Select *
From Portfolio_Project..CovidVax
Order by 3, 4



Select location, date, total_cases, new_cases, total_deaths, population
From Portfolio_Project..CovidDeath
order by 1, 2

--Looking at Total Deaths vs. Total Cases 
--Shows the likelihood of dying if you contract covid in the U.S.
Select location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
From Portfolio_Project..CovidDeath
where location like '%states%'
order by 1, 2


--Looking at total cases vs population
--shows % of population who got covid in the U.S.
Select location, date, Population,  total_cases, (total_cases/population)*100 as Population_Percentage
From Portfolio_Project..CovidDeath
where location like '%states%'
order by 1, 2

--Looking at countries with highest Percetage rate
Select location, Population,  MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentofPop
From Portfolio_Project..CovidDeath
group by population, location
order by PercentofPop desc


-- looking at the U.S. Percentage
Select location, Population,  MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentofPop
From Portfolio_Project..CovidDeath
where location like '%states%'
group by population, location
order by PercentofPop desc


--Showing Countries with Highest Death Count Per Population
--I casted total_deaths to bigint because 1. it was an nvarchar column
--2. In case the current numbers where the int would not be big enough for some of the deathcount numbers
--I used the where function to clear out the continent data in my data
Select Location, MAX(cast(total_deaths as bigint)) as TotalDeathCount
From Portfolio_Project..CovidDeath
where continent is not null
group by location
order by TotalDeathCount desc


-- Here is the death count broken down by continent
Select continent, MAX(cast(total_deaths as bigint)) as TotalDeathCount
From Portfolio_Project..CovidDeath
where continent is not null
group by continent
order by TotalDeathCount desc

--Global Numbers overall
Select Sum(new_cases) as total_cases, sum(cast(new_deaths as bigint)) as total_deaths, 
	Sum(cast(new_deaths as bigint))/Sum(new_cases)*100 as deathpercentages
From Portfolio_Project..CovidDeath
Where continent is not null
order by 1, 2

--Global Numbers by day
Select date, Sum(new_cases) as total_cases, sum(cast(new_deaths as bigint)) as total_deaths, 
	Sum(cast(new_deaths as bigint))/Sum(new_cases)*100 as deathpercentages
From Portfolio_Project..CovidDeath
Where continent is not null
Group by date
order by 1, 2


--Joining CovidDeath table with Covid Vax
select *
from Portfolio_Project..CovidDeath death
join Portfolio_Project..CovidVax vax
	on death.location = vax.location
	and death.date = vax.date;

-- looking at total Pop vs total Vaxxed
select death.continent, death.location, death.date, death.population, vax.new_vaccinations
from Portfolio_Project..CovidDeath death
join Portfolio_Project..CovidVax vax
	on death.location = vax.location
	and death.date = vax.date
Where death.continent is not null
order by 2,3

--looking at total Pop vs total Vaxxed with rolling numbers using a CTE
With PeopleVaxxed (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaxxed)
as 
(
select	death.continent, death.location, death.date, death.population, vax.new_vaccinations,
		Sum(Cast(vax.new_vaccinations as bigint)) over (Partition by death.location order by death.location,
		death.date) as RollingPeopleVaxxed
From Portfolio_Project..CovidDeath death
join Portfolio_Project..CovidVax vax
	on death.location = vax.location
	and death.date = vax.date
where death.continent is not null
)
Select *, (RollingPeopleVaxxed/Population)*100 as VaxxedPercentage
From PeopleVaxxed


--Temp Table
Drop table if exists PeopleVaxxed
Create Table PeopleVaxxed
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vax numeric,
RollingVaxxed numeric
)
insert into PeopleVaxxed
select	death.continent, death.location, death.date, death.population, vax.new_vaccinations,
		Sum(Cast(vax.new_vaccinations as bigint)) over (Partition by death.location order by death.location,
		death.date) as RollingPeopleVaxxed
From Portfolio_Project..CovidDeath death
join Portfolio_Project..CovidVax vax
	on death.location = vax.location
	and death.date = vax.date

Select *
From PeopleVaxxed


--Creating a View
Create View PercentPeopleVaxed as
select	death.continent, death.location, death.date, death.population, vax.new_vaccinations,
		Sum(Cast(vax.new_vaccinations as bigint)) over (Partition by death.location order by death.location,
		death.date) as RollingPeopleVaxxed
From Portfolio_Project..CovidDeath death
join Portfolio_Project..CovidVax vax
	on death.location = vax.location
	and death.date = vax.date
where death.continent is not null