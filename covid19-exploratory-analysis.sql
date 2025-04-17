#exploratory analysis on the covid19 data
#How have new cases and deaths changed over time globally?
select * from staged_table;

select `date` , sum(new_cases) as new_cases, sum(new_deaths) 
from staged_table group by `date`order by `date` desc;

#What is the trend of vaccinations over time?
select `date`, sum(total_vaccinations) as total_vaccination
from staged_table 
group by `date` order by `date` ;

select date_format(`date`, '%Y-%m') as `month`, sum(total_vaccinations) as total_vaccination
from staged_table
group by `month`
order by `month`;

#Which countries had the highest total cases, deaths, and vaccinations?
SELECT 
  location AS country,
  SUM(total_cases) AS total_cases,
  SUM(total_deaths) AS total_deaths,
  SUM(total_vaccinations) AS total_vaccinations
FROM staged_table
GROUP BY location
ORDER BY total_deaths DESC;

#What percentage of each country’s population is fully vaccinated?
select * from staged_table;

select location as country, (people_fully_vaccinated / population) * 100 as `people_fully_vaccinated%`
from staged_table 
group by country
order by `people_fully_vaccinated%` desc;

#Is there a relationship between vaccination rate and new cases?
select * from staged_table;
select location as country , round(avg(new_cases) ,2)as rate_of_newcases, 
round(avg(people_fully_vaccinated),2) as high_rate_vac
from staged_table
group by location
order by high_rate_vac desc;

#How do hospitalization and ICU numbers vary across countries?
select location as country , sum(icu_patients) as icu_patients, sum(hosp_patients) as hospital_patients
from staged_table
group by location 
order by icu_patients desc;