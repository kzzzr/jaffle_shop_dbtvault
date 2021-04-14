{{
    config(
        enabled=True
    )
}}

{%- set source_model = "ods_v_payment" -%}
{%- set src_pk = "PAY_PK" -%}
{%- set src_fk = ["USER_PK", "ACCOUNT_PK", "BILLING_PERIOD_PK"] -%}
{%- set src_payload = ["sum", "pay_doc_type", "pay_doc_num"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ dbtvault.t_link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                   src_payload=src_payload, src_eff=src_eff,
                   src_source=src_source, source_model=source_model) }}
