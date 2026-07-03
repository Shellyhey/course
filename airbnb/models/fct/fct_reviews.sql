{{ config(
    materialized='incremental',
    on_schema_change='fail'
    ) 
}}
WITH SRC_REVIEWS AS (
    SELECT * 
    FROM {{ ref('src_reviews') }}
)
SELECT * FROM SRC_REVIEWS
WHERE REVIEW_text IS NOT NULL
{% if is_incremental() %}
  AND REVIEW_DATE > (SELECT MAX(REVIEW_DATE) FROM {{ this }})
{% endif %}