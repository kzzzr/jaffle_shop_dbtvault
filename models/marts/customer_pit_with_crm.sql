
WITH all_history AS (

SELECT 
	
	hc.customer_pk 
	, scd.first_name 
	, scd.last_name 
	, scd.email 
	, scd2.age 
	, scd2.country 
	, scd.effective_from AS scd_effective_from
	, COALESCE(lead(scd.effective_from) OVER (PARTITION BY hc.customer_pk ORDER BY scd.effective_from), '9999-12-31') AS scd_effective_to
	, scd2.effective_from AS scd2_effective_from
	, COALESCE(lead(scd2.effective_from) OVER (PARTITION BY hc.customer_pk ORDER BY scd2.effective_from), '9999-12-31') AS scd2_effective_to
	
	
FROM {{ ref('hub_customer') }} hc 
	LEFT JOIN {{ ref('sat_customer_details') }} scd ON scd.customer_pk = hc.customer_pk
	LEFT JOIN {{ ref('sat_customer_details_crm') }} scd2 ON scd2.customer_pk = hc.customer_pk
	
-- WHERE hc.customer_pk IN ('c9e1074f5b3f9fc8ea15d152add07294')	

)

SELECT 

	  customer_pk 
	, first_name 
	, last_name 
	, email 
	, age
	, country
	, scd_effective_from 
	, scd_effective_to
	, scd2_effective_from 
	, scd2_effective_to
	
FROM all_history	
	
WHERE 1=1
	-- AND current_timestamp BETWEEN scd_effective_from AND scd_effective_to -- '2021-12-10 20:55:03'
	-- AND current_timestamp BETWEEN scd2_effective_from AND scd2_effective_to -- '2021-12-10 20:55:03'
	-- AND customer_pk IN ('c9e1074f5b3f9fc8ea15d152add07294')


--SELECT 
--	customer_pk
--	,first_name
--	,last_name
--	,email
--	,"age"
--	,country
--FROM dbt.customer_pit_with_crm
--WHERE customer_pk IN ('6974ce5ac660610b44d9b9fed0ff9548')
--	AND current_timestamp BETWEEN scd_effective_from AND scd_effective_to -- '2022-08-01 20:23:33'
--	AND current_timestamp BETWEEN scd2_effective_from AND scd2_effective_to -- '2022-08-01 20:23:33'
