# Domain objects

## Installation

The package can be installed by adding `mart_domain` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mart_domain, ">= 1.0.0"}
  ]
end
```

## Member aggregate

```
┌────────────────────────────────────────────────────┐
│ Member                                             │
├────────────────────────────────────────────────────┤
│create(username, password)                          │
│create(username, password, datetime)                │
│set_password(user_account, password)                │
│set_password(user_account, password, datetime)      │
│verify_password(user_account, plain_password)       │
│new_token(user_account)                             │
│new_token(user_account, expired_when)               │
│renew_token(user_account, plain_token)              │
│renew_token(user_account, plain_token, expired_when)│
└────────────────────────────────────────────────────┘
```

## Listings aggregate

```
 (root)
┌──────┐    >┌───┐
│Course├─────┤SKU│
└┬───┬─┘    *└───┘
 │SKU│
 └──┬┘
   v│
┌───┴──┐
│ Shop │
└──────┘
```

APIs:
- `create(id, create_at, course_name, course_plan, lessons, use_count \\ 0)`
- `create_sku(id, create_at, name)`
- `create_shop(id, create_at, name)`
- `get_sku_list(course)`
- `get_shop(course, sku)`
- `add_sku(course, sku, shop)`

## Studio aggregate

```
                (root)
┌───────┐<    ┌─────────┐    >┌───────┐
│Course ├─────┤ Course  ├─────┤Lessons│
│ Plan  │     └┬───────┬┘    *└───────┘
└───────┘      │chapter│
               └──┬────┘
                 v│
              ┌───┴────┐
              │ Lesson │
              └────────┘
```

APIs:
- `create(id, create_at, course_name, course_plan, use_count \\ 0)`
- `create_lesson(id, create_at, chapter, description)`
- `get_plan(course)`
- `get_lessons(course)`
- `get_lesson(course, chapter)`
- `add_lesson(course, chapter, lesson)`

## Customer aggregate

```
    (root)
┌────────────┐     >┌───────┐
│User account├──────┤Basket │
└────────────┘      └───┬───┘
                       v│*
                    ┌───┴───┐
                    │ Item  │
                    ├───────┤
                    │  SKU  │
                    └───────┘
```

APIs:
- `create(user_account)`
- `get_basket(user_account)`
- `get_basket_items(user_account)`
- `add_basket(UserAccount.t(), Basket.t())`
- `add_basket_item(UserAccount.t(), Item.t())`

## Pricing aggregate

```
   (root)
┌───────────┐    >┌───────────┐
│    SKU    ├─────┤ Promotion │
└┬─────────┬┘    *└───────────┘
 │promotion│
 │   id    │
 └────┬────┘
     v│
┌─────┴─────┐
│ Promotion │
└───────────┘
```

APIs:
- `create(item)`
- `create_pormotion(id, description, price)`
- `get_promotion(sku)`
- `get_promotion(sku, promotion_id)`
- `add_promotion(sku, promotion)`

## Sales aggregate

```

                     (root)
┌────────────────────────────────────────────┐    >┌─────────────┐
│                                            ├─────┤ Sales order │
│                                            │    *└─────────────┘
│                                            │    >┌────────────────┐
│                     Shop                   ├─────┤Paid sales order│
│                                            │    *└────────────────┘
│                                            │    >┌──────────────────┐
│                                            ├─────┤Unpaid sales order│
└┬──────────────────────────────────────────┬┘    *└──────────────────┘
 │                     SKU                  │
 └──────┬─────────────┬──────────────────┬──┘
       v│*           v│*                v│*
┌───────┴───┐┌────────┴───────┐┌─────────┴────────┐
│Sales order││Paid sales order││Unpaid sales order│
└───────────┘└────────────────┘└──────────────────┘

```

APIs:
- `create(shop, sales_order_list \\ [])`
- `create_sales_order(id, create_at, sku_list \\ [], payment \\ nil)`
- `create_pyament(id, create_at, amount)`
- `get_sales_orders(shop)`
- `get_sales_orders(shop, sku)`
- `get_paid_sales_orders(shop)`
- `get_paid_sales_orders(shop, sku)`
- `get_unpaid_sales_orders(shop)`
- `get_unpaid_sales_orders(shop, sku)`
- `add_sales_order(shop, sales_order)`
- `add_sales_order(shop, sales_order, sku_rate_list, payment)`
