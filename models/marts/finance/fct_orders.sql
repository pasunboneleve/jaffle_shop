with orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }} 

), 

payments as (

    select * from {{ ref('stg_stripe__payments') }}

),

final as (
    select
    orders.order_id,
    orders.customer_id,
    sum(payments.amount) as amount
    from orders
    left join payments using (order_id)
    where orders.status = 'completed'
    and payments.status = 'success'
    group by 1, 2
)

select * from final