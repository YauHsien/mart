# Mart Repo

## Relationships between domain objects to repositories

- Member
  - :user_account (aggregate)
    - :user_token

- Shop
  - :shop (aggregate)
    - :tutorship
      - :user_account
    - :sku
      - :course (aggregate)
        - :course_plan
        - :lesson
      - :pricing
        - :promotion
      - :sales_order\_item
        - :sales_order
          - :user_account

- Sales Order
  - :sales_order (aggregate)
    - :user_account
    - :sales_order\_item
    - :payment

- Classroom
  - :room (aggregate)
    - :course_plan
      - :course
        - :lesson
    - :tutorship
      - :user_account
        - :user_token
    - :studentship
      - :user_account
        - :user_token
        - :bought_ticket
          - :bought_package
    - :vlog

- Accounting
  - :payment (appregate)
    - :user_account
    - :sales_order
      - :sales_order_item
        - :skus
          - :pricing
            - :promotion

- Portfolio
  - :user_account (aggregate)
    - :bought_package
      - :bought_ticket
      - :sales_order\_item
      - :skus
        - :course
          - :course_plan
          - :lesson
        - :pricing
          - :promotion

## Domain events

- Field event:
  - Key: `{table, id: id, field: field}`
  - Value: just `value`.

- Structure event:
  - Key: `{parent, child}`
  - Value: `{parent_id, child_id}`
  - By custom.
