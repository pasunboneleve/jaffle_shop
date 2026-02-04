with customers as (

    select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (

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
    left join payments on payments.order_id = orders.order_id
    group by 1, 2
)

select * from final