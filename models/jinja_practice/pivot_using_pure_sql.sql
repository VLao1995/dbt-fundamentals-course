SELECT
orderid,
sum(case when paymentmethod = 'bank_transfer' then amount else 0 end) bank_transfer_amount,
sum(case when paymentmethod = 'credit_card' then amount else 0 end) credit_card_amount,
sum(case when paymentmethod = 'coupon' then amount else 0 end) coupon_amount,
sum(case when paymentmethod = 'gift_card' then amount else 0 end) gift_card_amount,
FROM {{ source('stripe', 'payment') }}
WHERE status = 'success'
GROUP BY 1 ORDER BY 1