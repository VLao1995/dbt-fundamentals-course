{%- set payment_methods = ['bank_transfer', 'credit_card', 'coupon', 'gift_card'] -%}

SELECT
orderid,
{%- for payment_method in payment_methods %}
sum(case when paymentmethod = '{{payment_method}}' then amount else 0 end) {{payment_method}}_amount,
{%- endfor %}
FROM {{ source('stripe', 'payment') }}
WHERE status = 'success'
GROUP BY 1 ORDER BY 1