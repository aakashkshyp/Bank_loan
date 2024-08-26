/*create database*/

create database BankLoan

/*Use Database*/
use BankLoan

/*Select all the  data from table*/
select  * from bank_loan_data;

/*calculate total loan application*/
select count(id) as Total_Loan_application from bank_loan_data;

/* calculate month to month loan application (MTM)*/
select count(id) as Total_Loan_application from bank_loan_data 
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

/*calculate month over month loan application*/
select count(id) as pmtd_loan_application from bank_loan_data
where month(issue_date)=11 AND YEAR(issue_date)=2021;

/*calculate total funded amount*/
select sum(annual_income) as total_funded_amount from bank_loan_data

/*calaculate mtd total funded amount*/
select sum(annual_income) as mtd_total_funded_amount from bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

/*calculate previous month total funded amount*/
select sum(issue_date) as pmtd_total_funded_amount from bank_loan_data
where MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

/*total amount received*/
select sum(total_payment) as total_funded_amount from bank_loan_data;

/*calculate for current month*/
select sum(total_payment) as mtd_total_funded_amount from bank_loan_data
where month(issue_date)=12 AND YEAR(issue_date)=2021;

/*calculate for previous month to date*/
select sum(total_payment) as pmtd_total_funded_amount from bank_loan_data
where month(issue_date)=11 AND YEAR(issue_date)=2021;

/*AVERAGE INTEREST RATE*/
select avg(int_rate) as avg_int_rate from bank_loan_data;

/*average interest in %*/
select avg(int_rate) *100 as avg_int_rate from bank_loan_data;

/*average interest in % in round number*/
select ROUND(avg(int_rate) , 4) * 100 as avg_int_rate from bank_loan_data;

/*average interst rate in current month*/
select ROUND(avg(int_rate),4)* 100 as MTD_avg_interest from bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

/*average interest for previous month*/
select ROUND(avg(int_rate),4)* 100 as PMTD_avg_interest from bank_loan_data
where MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

/*average DEbt to income ration(DTI)*/
select ROUND(AVG(dti),4)* 100 as Avg_dti from bank_loan_data;

/*average debt for current month*/
select ROUND(avg(dti),4)*100 as MTD_avg_dti from bank_loan_data
where MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

/*average dti for prevvious month*/
select ROUND(avg(dti),4)*100 as PMTD_avg_dti from bank_loan_data
where MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

/*        DASHBOARD 1  */

/* good loan appliation % */

/*total no of application % received for good loan and bad loan */

select 
	(count(case when loan_status='Fully Paid' or loan_status='Current' then  id END)*100)
	/
	count(id) as good_loan_percentage
	from bank_loan_data;


/*good loan application*/
select count(id) as good_loan_application from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current';


/*good loan funded amount*/

select sum(loan_amount) as good_loan_funded_amount from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current';

/*good loan total amount received*/
select sum(total_payment) as good_loan_received_amount from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current';

/* total no of application rec for bad loans*/
select 
	(count(case when loan_status='Charged off' then  id END)*100)
	/
	count(id) as good_loan_percentage
	from bank_loan_data;

/*total bad loan application*/
select count(id) from bank_loan_data where loan_status='charged off';

/*bad loan funded amount*/
select sum(loan_amount) as bad_loan_funded_amount from bank_loan_data
where loan_status='Charged Off';

/*bad loan ampunt receivves*/
select sum(total_payment) as bad_loan_funded_amount from bank_loan_data
where loan_status='Charged Off';

/*loan status grid view*/
select 
loan_status,
count(id) as total_loan_applications,
sum(total_payment) as total_amount_received,
sum(loan_amount) as total_funded_amount,
avg(int_rate * 100) as interest_rate,
avg(dti*100) as DTI
from 
bank_loan_data
group by
loan_status;

/*loan status grid view for mtd */
select 
loan_status,
sum(total_payment) as MTD_total_amount_received,
sum(loan_amount) as MTD_total_funded_amount
from bank_loan_data
where month(issue_date)=12
group by loan_status;


/*DASHBOARD 2*/

/*month trend by issue data query*/
select 
MONTH(issue_date) as month_number,
DATENAME(month,issue_date) as month_name,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_recceived_amount
from bank_loan_data
group by MONTH(issue_date),datename(month,issue_date)
order by MONTH(issue_date);

/*regional analysis by state*/
select 
address_state,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_recceived_amount
from bank_loan_data
group by address_state
order by count(id) desc;

/*loan term query*/
select 
emp_length,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_recceived_amount
from bank_loan_data
group by emp_length
order by count(id) desc;

/*loan purpose breakdown*/
select 
purpose,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_recceived_amount
from bank_loan_data
group by purpose
order by count(id) desc;

/*home ownership analysis :- using trww map is power bi*/
select 
home_ownership,
count(id) as total_loan_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_recceived_amount
from bank_loan_data
group by home_ownership
order by count(id) desc;


/*DASHBOARD 3 GRID*/
