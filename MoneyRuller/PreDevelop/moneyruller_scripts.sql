долги

select * from fin_accounts t
where t.type_id=3 and state=1 and rest<>0
..............................................................

транзакции по счёту

select * from transactions where deb_acc_id=36 or cre_acc_id=36 order by id
..............................................................