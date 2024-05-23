with recursive nums (n, fib_n, fib_n_minus_1) as (
       values (0::numeric, 1::numeric, 0::numeric)
      ),
      fib (n, fib_n, fib_n_minus_1) as (
       select n, fib_n, fib_n_minus_1
       from nums
       union all
       select n + 1, fib_n + fib_n_minus_1, fib_n
       from fib f
       where n < 99
     )
select n as nth, fib_n as value
from fib
order by n;


