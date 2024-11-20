select * from coviddeaths
--total cases vs total deaths
select location, date, total_cases,total_deaths,
(total_deaths/total_cases)*100 as Deathpercentage ,population
from coviddeaths
where location like 'Georgia'
order by 1,2

--total cases vs total deaths
-- % of population got covid
select location, date, population,total_cases,(total_cases/population)*100 as Deathpercentage 
from coviddeaths
where location like 'Georgia'
order by 1,2
------
----looking at countirs with highest infection rate 
--compared to population
select location,population,max(total_cases),max(total_cases/population)*100 as percentpopiioninfected 
from coviddeaths
group by location, population
 order by percentpopiioninfected desc

 ---- showing cointries with highest death count per populayion
 select location,max(cast(total_deaths as int)) as totaldeathcount
from coviddeaths
where continent is not null
group by location
 order by totaldeathcount desc
-----
 -- let's break things down by continent
 select location,max(cast(total_deaths as int)) as totaldeathcount
from coviddeaths
where continent is  null
group by location
 order by totaldeathcount desc

 --- showing continents with highest death count per ppulation
  select location,max(cast(total_deaths as int)), as totaldeathcount
from coviddeaths
where continent is  null
group by location
 order by totaldeathcount 
 


---- Global numberss
select sum(new_cases) as totalcases ,sum(cast(new_deaths as int)) as totaldeaths,sum(cast(new_deaths as int))/sum(new_cases)*100
as deathpercentage
--(total_cases/population)*100 as Deathpercentage 
from coviddeaths
--where location like 'Georgia'
where continent is not null
--group by date
order by 1,2


------------------------
-- total population vs vaccinations
select dea.continent, dea.location,dea.date,dea.population
,vac.new_vaccinations, SUM(convert(int,VAC.NEW_VAccinations))
over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
--(rollingpeoplevaccinated/population) * 100
from CovidDeaths dea left join covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
WHERE DEA.CONTINENT IS NOT NULL
AND POPULATION IS NOT NULL
ORDER BY 2,3

-- use cte
with popvsvac (continent,location,date,population,new_vaccinations,
rollingpeoplevaccinated) as 
(
select dea.continent, dea.location,dea.date,dea.population
,vac.new_vaccinations, SUM(convert(int,VAC.NEW_VAccinations))
over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
--(rollingpeoplevaccinated/population) * 100
from CovidDeaths dea left join covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
WHERE DEA.CONTINENT IS NOT NULL
AND POPULATION IS NOT NULL
)
 
--SELECT *,(rollingpeoplevaccinated/population)*100 FROM POPVSVAC
----------
drop table if exists #percentpopulationvaccinated
CREATE table #percentpopulationvaccinated
(continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rollingpeoplevaccinated numeric)
 
 insert into #percentpopulationvaccinated
 select dea.continent, dea.location,dea.date,dea.population
,vac.new_vaccinations, SUM(convert(int,VAC.NEW_VAccinations))
over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
--(rollingpeoplevaccinated/population) * 100
from CovidDeaths dea left join covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
WHERE DEA.CONTINENT IS NOT NULL
AND POPULATION IS NOT NULL


SELECT *,(rollingpeoplevaccinated/population)*100 FROM 
#percentpopulationvaccinated

--- creating view to store date for later visualizations
create view PercentPopulationVaccinated as 
select dea.continent, dea.location,dea.date,dea.population
,vac.new_vaccinations, SUM(convert(int,VAC.NEW_VAccinations))
over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
--(rollingpeoplevaccinated/population) * 100
from CovidDeaths dea left join covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
WHERE DEA.CONTINENT IS NOT NULL
AND POPULATION IS NOT NULL
