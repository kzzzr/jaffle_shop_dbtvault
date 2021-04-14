{{
    config(
        enabled=True
    )
}}

{%- set yaml_metadata -%}
source_model:
  'rt': 'ods_payment'
derived_columns:
  USER_KEY: 'user_id'
  ACCOUNT_KEY: 'account'
  BILLING_PERIOD_KEY: 'billing_period'
  RECORD_SOURCE: '!PAYMENT – DATA LAKE'
hashed_columns:
  USER_PK: 'user_id'
  ACCOUNT_PK: 'account'
  BILLING_PERIOD_PK: 'billing_period'
  PAY_PK: 
      - 'user_id'
      - 'account'
      - 'billing_period'
  USER_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'phone'

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}


WITH staging AS (
{{ dbtvault.stage(include_source_columns=true,
                  source_model=source_model,
                  derived_columns=derived_columns,
                  hashed_columns=hashed_columns,
                  ranked_columns=none) }}
)

SELECT *, 
       {{ var('load_date') }} AS LOAD_DATE,
       pay_date AS EFFECTIVE_FROM
FROM staging