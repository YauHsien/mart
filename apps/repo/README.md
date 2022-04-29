# Mart Repo

## Domain aggregates to repositories

- Portfolio
  - :bought_package & :bought\_ticket
  - Course
  - :sales_order\_item & Pricing

- Member
  - :user_account
  - Shop
  - Portfolio
  - Basket
  - Sales order
  - Payment

- Shop
  - :shop
  - Course
  - Listings
  - Sales order

- Course
  - :shop & :sku
  - :course_plan
  - :course
  - :lesson
  - :tutorship

- Listings
  - :sku
  - Pricing
  - Course

- Sales order
  - :user_account
  - :sales_order
  - :sales_order\_item
  - Listings
  - Payment

- Basket
  - :user_account
  - :basket
  - :sales_order\_item
  - Listings

- Classroom
  - :room
  - :bought\_ticket & :bought_package
  - :studentship & :user_account & :user\_token
  - :tutorship & :shop & :user_account & :user\_token
  - Course
  - :vlog

- Payment
  - :payment
  - :sales_order & Pricing
  - :shop & :tutorship & Payable (by Classroom)
  
- Pricing
  - :sku
  - :pricing
  - :promotion

## Repo messaging

- M.Core.Common.RepoMessage
