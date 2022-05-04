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
