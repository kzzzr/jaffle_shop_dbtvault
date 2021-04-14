{{
    config(
        enabled=True
    )
}}

{%- set source_model = ["ods_v_payment"] -%}
{%- set src_pk = "BILLING_PERIOD_PK" -%}
{%- set src_nk = "BILLING_PERIOD_KEY" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}