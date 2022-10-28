-- This is C_{d} \in C (demand commodities)
select *
from commodities
where comm_desc  like '%demand%' AND comm_desc not like '%for%'

-- This is c \in C (list of all commodities)
select count(*)
from commodities

--Sector-based emissions (only contains SOX, NOX, CO2, and PM2.5)
select *
from commodities
where comm_desc  like '%emissions from the%'

-- Count of various type of commodities (three disjoint sets)
-- d: demand commodities (C^{d} in C): 51 entries
-- e: emissions commodities (C^{e} in C): 23 entries
-- p: products  commodities (C({p} in C): 385
select flag, count(flag)
from commodities
group by flag

select *
from commodities

-- Set of user-defined seasons (i.e., s \in S)
select *
from time_season


-- Set of all technologies (t \in T)
select *
from technologies


-- Set of all baseload electric technolgies (i.e., T^{b} \in T)
select *
from technologies
-- where flag == 'pb'
-- where flag == 'ps'
-- where flag == 'r'
where flag == 'p'

-- Count of all technolgies by flag. 
select flag, count(*)
from technologies
group by flag

select *
from technologies
where  sector like '%indus%'

-- Set of vintages
select DISTINCT vintage
from Efficiency
ORDER by vintage asc



select *
from CapacityCredit



SELECT A.*, B.comm_desc as 'input_comm_desc', C.tech_desc
FROM efficiency  A
INNER join commodities B
ON A.input_comm = B.comm_name
INNER JOIN technologies  C
ON (C.tech = A.tech) and (A.input_comm = B.comm_name)
WHERE regions == "CA" AND A.tech LIKE '%hyd%'


-- sector does not include industrial.
SELECT A.*, B.exist_cap, B.exist_cap_units, B.regions
FROM technologies A
INNER JOIN ExistingCapacity B
ON A.tech = B.tech
WHERE A.tech_desc LIKE '%natural gas%' AND B.regions == 'CA'

-- There are seven total sectors. 
SELECT sector, count(*)
FROM technologies
group by sector


-- How are commodities linked to technologies? (LinkedTechs)
SELECT *
from commodities
where  comm_desc like '%natural gas%'

select *
from technologies
limit 10

select *
from commodity_labels

select *
from LinkedTechs

SELECT A.*, B.exist_cap, B.exist_cap_units, B.regions
FROM technologies A
INNER JOIN ExistingCapacity B
ON A.tech = B.tech
WHERE A.tech_desc LIKE '%natural gas%' AND B.regions == 'CA' 






/* There is no industrial sector for California within the existing 
capacity for a set  of technologies.*/
SELECT K.SECTOR, COUNT(K.SECTOR) as 'CA_SECT_CNT'
FROM (
				SELECT A.*, B.*
				FROM technologies A
				INNER JOIN ExistingCapacity B
				ON A.tech = B.tech 

	) AS K
GROUP BY K.SECTOR





/* Disjoint Union betwen wind, solar, and geothermal (TOTAL 574 RECORDS)
It seems that the in the future state, there is *no* natural gas in California using the OEO. 
The timeline seem to start from 2020. 
*/
select K.TECH_TYPE, COUNT(K.TECH_TYPE)
FROM (
	SELECT A.*, 'WIND' as TECH_TYPE, B.regions, B. periods, B.maxcap
	FROM technologies A
	INNER JOIN MaxCapacity B
	ON A.tech = B.tech
	WHERE  B.regions == 'CA'  and A.tech_desc like '%wind%'
	UNION 
	SELECT A.*,  'SOLAR' as TECH_TYPE, B.regions, B. periods, B.maxcap
	FROM technologies A
	INNER JOIN MaxCapacity B
	ON A.tech = B.tech
	WHERE  B.regions == 'CA'  and A.tech_desc like '%solar%'
	UNION 
	SELECT A.*,  'GEOTHERMAL' as TECH_TYPE, B.regions, B. periods, B.maxcap
	FROM technologies A
	INNER JOIN MaxCapacity B
	ON A.tech = B.tech
	WHERE  B.regions == 'CA'  and A.tech_desc like '%geot%'
) AS K
GROUP BY K.TECH_TYPE



SELECT K.periods, count(K.periods) as 'CNT_ROWS_PER_PERIOD'
FROM (
		SELECT A.*, 'WIND' as TECH_TYPE, B.regions, B. periods, B.maxcap
		FROM technologies A
		INNER JOIN MaxCapacity B
		ON A.tech = B.tech
		WHERE  B.regions == 'CA'  and A.tech_desc like '%wind%'
		UNION 
		SELECT A.*,  'SOLAR' as TECH_TYPE, B.regions, B. periods, B.maxcap
		FROM technologies A
		INNER JOIN MaxCapacity B
		ON A.tech = B.tech
		WHERE  B.regions == 'CA'  and A.tech_desc like '%solar%'
		UNION 
		SELECT A.*,  'GEOTHERMAL' as TECH_TYPE, B.regions, B. periods, B.maxcap
		FROM technologies A
		INNER JOIN MaxCapacity B
		ON A.tech = B.tech
		WHERE  B.regions == 'CA'  and A.tech_desc like '%geot%'
) AS K
GROUP BY K.periods


SELECT K.periods, count(K.periods) as 'CNT_ROWS_PER_PERIOD'
FROM (
		SELECT A.*, 'WIND' as TECH_TYPE, B.regions, B. periods, B.maxcap
		FROM technologies A
		INNER JOIN MaxCapacity B
		ON A.tech = B.tech
		WHERE  A.tech_desc like '%wind%'
		UNION 
		SELECT A.*,  'SOLAR' as TECH_TYPE, B.regions, B. periods, B.maxcap
		FROM technologies A
		INNER JOIN MaxCapacity B
		ON A.tech = B.tech
		WHERE   A.tech_desc like '%solar%'
		UNION 
		SELECT A.*,  'GEOTHERMAL' as TECH_TYPE, B.regions, B. periods, B.maxcap
		FROM technologies A
		INNER JOIN MaxCapacity B
		ON A.tech = B.tech
		WHERE  A.tech_desc like '%geot%'
) AS K
GROUP BY K.periods

SELECT K.sector, COUNT(K.SECTOR) as 'CNT_ROWS_PER_PERIOD'
FROM (
	SELECT A.*, B.*
	FROM technologies A
	INNER JOIN MaxCapacity B
	ON A.tech = B.tech
	WHERE  B.regions == 'CA') AS K
GROUP BY K.sector


SELECT *
FROM commodities
where comm_desc like "%fuel%"

SELECT * FROM commodities WHERE comm_desc LIKE '%" + w + "%'