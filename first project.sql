--select *
--from portfolioprojects..CovidDeaths
--order by 3,4


--select *
--from portfolioprojects..CovidVaccinations
--order by 3,4

--looking at total cases vs total deaths
--shows the likelihood of dying if you contract covid in the united states

--select location, date, total_cases, total_deaths, (total_deaths * 1.0/total_cases) * 100 AS Mortality_Rate
--from portfolioprojects..CovidDeaths
--Where location like '%states%'
--order by 1,2


--looking at the total_cases vs population
-- Shows percentage of population with covid

--select location, date,population, total_cases, (total_cases* 1.0/population) * 100 as percentPopulationInfected
--from portfolioprojects..CovidDeaths
--Where location like '%states%'
--order by 1,2

--Looking at countries with highest infection rate compared to population

--select location, population, max(total_cases) as highestInfectionCount, max((total_cases* 1.0/population)) * 100 as percentOfPopulationInfected
--from portfolioprojects..CovidDeaths
----Where location like '%states%'
--Group by location, population
--order by percentOfPopulationInfected desc


--Showing countries with the highest death count per population

--select location, max(cast(total_deaths as int)) as totalDeathCount
--from portfolioprojects..CovidDeaths
----Where location like '%states%'
--where continent is not null
--Group by location
--order by totalDeathCount desc

--LETS BREAK THINGS DOWN BY CONTINENT
--select continent, max(cast(total_deaths as int)) as totalDeathCount
--from portfolioprojects..CovidDeaths
----Where location like '%states%'
--where continent is not null
--Group by continent
--order by totalDeathCount desc

--SHOWING CONTINENTS WITH THE HIGHEST DEATH COUNT PER POPULATION
--select continent, max(cast(total_deaths as int)) as totalDeathCount
--from portfolioprojects..CovidDeaths
----Where location like '%states%'
--where continent is not null
--Group by continent
--order by totalDeathCount desc


--GLOBAL NUMBERS

--select sum(new_cases) as Total_Cases, sum(cast(new_deaths as integer)) as Total_Deaths, sum(cast(new_deaths as integer))/sum(new_cases * 1.0) * 100 AS DeathPercentage
--from portfolioprojects..CovidDeaths
----Where location like '%states%'
--Where continent is not null
----Group by date
--order by 1,2


--Looking at Total population VS Vaccination

--With PopsVsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
--as
--(
--Select  dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
------,(RollingPeopleVaccinated/population)*100
----From portfolioprojects..CovidDeaths dea
----join portfolioprojects..CovidVaccinations vac
----on dea.location = vac.location
----and dea.date= vac.date
----where dea.continent is not null
------order by 2,3
----)
----Select *,(RollingPeopleVaccinated/Population)*100 as f
----From PopsVsVac



--With PopsVsVac (Continent, Location, Date, Population, NewVaccinations, RollingPeopleVaccinated) 
--as 
--(
--   Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--   SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
--   From portfolioprojects..coviddeaths dea 
--   join portfolioprojects..CovidVaccinations vac 
--   on dea.location = vac.location 
--   and dea.date = vac.date 
--   where dea.continent is not null 
--   --order by 2,3 
--) 

--Select *, (RollingPeopleVaccinated * 1.0 /Population) * 100 
--From PopsVsVac;


--TEMP TABLE

--DROP Table if exists  #PercentPopulationVaccinated
--Create Table #PercentPopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar (255),
--Date datetime,
--Population numeric,
--new_vaccinations numeric,
--RollingPeopleVaccinated numeric,

--)

--Insert into #PercentPopulationVaccinated

--   Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--   SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
--   From portfolioprojects..coviddeaths dea 
--   join portfolioprojects..CovidVaccinations vac 
--   on dea.location = vac.location 
--   and dea.date = vac.date 
--   where dea.continent is not null 
--   --order by 2,3

   
--Select *, (RollingPeopleVaccinated * 1.0 /Population) * 100 
--From #PercentPopulationVaccinated


-- Creating View to store data for later visualisations

--Create view PeoplePopulationVaccinated as
--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--   SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
--   From portfolioprojects..coviddeaths dea 
--   join portfolioprojects..CovidVaccinations vac 
--   on dea.location = vac.location 
--   and dea.date = vac.date 
--   where dea.continent is not null;
--   --order by 2,3

--SELECT *
--FROM INFORMATION_SCHEMA.VIEWS
--WHERE TABLE_NAME = 'PeoplePopulationVaccinated';

select * 
from PeoplePopulationVaccinated



