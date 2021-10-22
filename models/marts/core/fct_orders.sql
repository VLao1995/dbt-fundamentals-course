with order_payments as (
    select
        order_id,
        sum(case when status = 'success' then amount end) as amount
    from {{ ref('stg_payments') }}
    group by 1
)

select
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    coalesce(order_payments.amount, 0) as amount
from {{ ref('stg_orders' )}} orders
left join order_payments using (order_id)


