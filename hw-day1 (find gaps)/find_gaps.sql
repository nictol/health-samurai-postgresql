-- Дана таблица с числовой последовательностью из которой были удалены некоторые последовательности значений
-- Задача - найти все удаленные последовательности

--input
create table gaps
(
    id integer primary key
);

insert into gaps (id)
select x
from generate_series(1, 10000) x;

delete
from gaps
where id between 102 and 105;

delete
from gaps
where id between 134 and 176;

--decision

select min(id) + 1 as from,
       max(id) - 1 as to
from (select id,
             lead(id, 1) over (order by id) - lag(id, 1) over (order by id) as dif
      from gaps) sub
where sub.dif > 2
group by sub.dif
order by min(id);

