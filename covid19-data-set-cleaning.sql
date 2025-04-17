use  new_schema;
select * from synthetic_covid19_data;

select * from synthetic_covid19_data where total_cases = null or continent = '';

# stage the table
create table staged_table as 
select * from synthetic_covid19_data;

select * from staged_table;

#check for duplicates 
with duplicates_check as
 (
select * ,
row_number() over (partition by `date`, continent, location, new_cases, total_deaths, 
total_tests, new_tests, positive_rate, tests_per_case, total_vaccinations, 
people_vaccinated, people_fully_vaccinated, hosp_patients, icu_patients,
reproduction_rate, stringency_index, population, population_density, median_age) 
as row_num from staged_table
)
select * from duplicates_check where row_num > 1;

#standardizing
select * from staged_table where location = 'USA';

select distinct(continent) from staged_table;

update staged_table
set continent = 'Asia' where location = 'India';

update staged_table
set continent = 'North America' where location = 'USA';

update staged_table
set continent = 'Europe' where location = 'Russia';

select distinct (location) from staged_table;

update staged_table
set continent = 'Asia' where location = 'Japan';

update staged_table
set continent = 'Europe' where location = 'Germany';

update staged_table 
set continent = 'South America' where location = 'Brasil';
select * from staged_table;
update staged_table
set continent = 'North America' where location = 'Canada';