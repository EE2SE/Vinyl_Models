-- Drop the check constraint for 'amount'
alter table prod.buy_price
drop constraint if exists ck__buy_price__non_neg_amount;

-- Drop the 'amount' column
alter table prod.buy_price
drop column if exists amount;