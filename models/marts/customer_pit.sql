WITH all_history AS (

SELECT 
	
	hc.customer_pk 
	, scd.first_name 
	, scd.last_name 
	, scd.email 
	, scd.effective_from 
	, COALESCE(lead(effective_from) OVER (PARTITION BY hc.customer_pk ORDER BY scd.effective_from), '9999-12-31') AS effective_to

FROM {{ ref('hub_customer') }} hc 
	LEFT JOIN {{ ref('sat_customer_details') }} scd ON scd.customer_pk = hc.customer_pk
	
-- WHERE hc.customer_pk IN ('ec8956637a99787bd197eacd77acce5e')	

)

SELECT 

	  customer_pk 
	, first_name 
	, last_name 
	, email 
	, effective_from 
	, effective_to
	
FROM all_history	
	
WHERE TRUE
    -- current_timestamp BETWEEN effective_from AND effective_to -- '2021-12-10 20:55:03'
    -- '2022-08-01 20:45:00' BETWEEN effective_from AND effective_to -- '2021-12-10 20:55:03'
	-- AND customer_pk IN ('ec8956637a99787bd197eacd77acce5e')


--SELECT 
--	customer_pk
--	,first_name
--	,last_name
--	,email
--FROM dbt.customer_pit
--WHERE customer_pk IN ('6974ce5ac660610b44d9b9fed0ff9548')
--	AND '2022-08-01 20:23:35' BETWEEN effective_from AND effective_to -- '2022-08-01 20:23:33'
--;