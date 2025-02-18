create procedure Sales.uspGetCurrencyInformation
as
select CurrencyCode, Name from Sales.Currency
go

alter procedure Sales.uspGetCurrencyInformation
as
select CurrencyCode, Name, ModifiedDate from Sales.Currency
go

drop procedure Sales.uspGetCurrencyInformation

exec Sales.uspGetCurrencyInformation

execute Sales.uspGetCurrencyInformation

Sales.uspGetCurrencyInformation

exec sp_helptext 'Sales.uspGetCurrencyInformation'

select definition from sys.sql_modules
where object_id=(OBJECT_ID(N'Sales.uspGetCurrencyInformation'))

select OBJECT_DEFINITION(OBJECT_ID(N'Sales.uspGetCurrencyInformation'))


alter procedure Sales.uspGetCurrencyInformation
with encryption
as
select CurrencyCode, Name, ModifiedDate from Sales.Currency
go

create procedure Sales.uspGetCurrencyInformation
@currencyCode char(3)
as
select currencycode, name from Sales.Currency where CurrencyCode=@currencyCode

exec Sales.uspGetCurrencyInformation @CurrencyCode='USD'

exec Sales.uspGetCurrencyInformation 'USD'

alter procedure Sales.uspGetCurrencyInformation
@currencyCode char(3) = 'USD'
as
select currencycode, name from Sales.Currency where CurrencyCode=@currencyCode

exec Sales.uspGetCurrencyInformation

exec Sales.uspGetCurrencyInformation @CurrencyCode = default

exec Sales.uspGetCurrencyInformation default

create procedure Sales.uspGetCurrencyRate
@CurrencyRateIDList varchar(50)
AS
declare @SQLString nvarchar(1000)
set @SQLString = N'
select CurrencyRateID, CurrencyRateDate, FromCurrencyCode, ToCurrencyCode, AverageRate, EndOfDayRate
from Sales.CurrencyRate where CurrencyRateID in('+@CurrencyRateIDList+');'

execute sp_executesql @SQLString
go

exec Sales.uspGetCurrencyRate @CurrencyRateIDList = '1,4,6,7'

alter procedure Sales.uspGetCurrencyInformation
@CurrencyCodeList varchar(200) = 'USD'
as
declare @sqlstring nvarchar(1000)
set @sqlstring=N'select CurrencyCode, Name from Sales.Currency where CurrencyCode in ('+@CurrencyCodeList+');'
execute sp_executesql @sqlstring;
go

exec Sales.uspGetCurrencyInformation @CurrencyCodeList='''USD'',''AUD'',''CAD'',''MXN''';

create procedure Sales.uspGetCurrencyInformationXML
@xmlList varchar(1000)
as
declare @xmlDocHandle int
declare @CurrencyCodeTable table(
CurrencyCode char(3)
)

execute sp_xml_preparedocument @xmldochandle OUTPUT, @xmlList;

insert into @CurrencyCodeTable(CurrencyCode)
select CurrencyCode from OPENXML (@xmlDocHandle,'/ROOT/Currency',1)
with(
CurrencyCode char(3)
);
select c.CurrencyCode, c.Name, c.ModifiedDate
from Sales.Currency c
join
@CurrencyCodeTable tvp
on c.CurrencyCode = tvp.CurrencyCode

execute sp_xml_removedocument @xmlDocHandle
go

execute Sales.uspGetCurrencyInformationXML @xmllist = '
<ROOT>
<Currency CurrencyCode="USD"></Currency>
<Currency CurrencyCode="AUD"></Currency>
<Currency CurrencyCode="CAD"></Currency>
<Currency CurrencyCode="MXN"></Currency>
</ROOT>';

create procedure Sales.uspGetCurrencyRatesXML
@XMLList varchar(1000),
@CurrencyRateDate datetime
as
declare @xmlDocHandle int
declare @CurrencyCodeTable table
(
FromCurrencyCode char(3),
ToCurrencyCode char(3)
)

execute sp_xml_preparedocument @xmlDocHandle OUTPUT, @XMLList;

insert into @CurrencyCodeTable(FromCurrencyCode, ToCurrencyCode)
select FromCurrencyCode, ToCurrencyCode
from OPENXML (@xmlDocHandle, '/ROOT/CurrencyList',1)	
with(
FromCurrencyCode char(3),
ToCurrencyCode char(3)
);
select cr.CurrencyRateID, cr.FromCurrencyCode,
cr.ToCurrencyCode, cr.AverageRate, cr.EndOfDayRate,
cr.CurrencyRateDate
from Sales.CurrencyRate cr
join
@CurrencyCodeTable tvp
on
cr.FromCurrencyCode = tvp.FromCurrencyCode
and cr.ToCurrencyCode = tvp.ToCurrencyCode
where CurrencyRateDate = @CurrencyRateDate

execute sp_xml_removedocument @xmlDocHandle

exec Sales.uspGetCurrencyRatesXML @xmlList ='
<ROOT>
<CurrencyList FromCurrencyCode="USD" ToCurrencyCode="AUD"></CurrencyList>
<CurrencyList FromCurrencyCode="USD" ToCurrencyCode="EUR"></CurrencyList>
<CurrencyList FromCurrencyCode="USD" ToCurrencyCode="GBP"></CurrencyList>
<CurrencyList FromCurrencyCode="USD" ToCurrencyCode="MXN"></CurrencyList>
</ROOT>', @CurrencyRateDate = '2011-05-31';


create procedure Sales.uspGetCurrencyName
@CurrencyCode char(3),
@CurrencyName varchar(50) output
as
select @CurrencyName = Name from Sales.Currency
where CurrencyCode = @CurrencyCode;
go

declare @CurrencyNameOutput varchar(50) 
execute Sales.uspGetCurrencyName
@CurrencyCode='USD',
@CurrencyName = @CurrencyNameOutput OUTPUT
print @CurrencyNameOutput
go

alter procedure Sales.uspGetCurrencyName
@CurrencyCode char(3),
@CurrencyName varchar(50) output
as
select @CurrencyName = Name from Sales.Currency
where CurrencyCode = @CurrencyCode;
if @CurrencyName is null
begin
return 1;
end
else
begin
return 0;
end
go

declare @CurrencyNameOutput varchar(50)
declare @ReturnCode int
exec @ReturnCode = Sales.uspGetCurrencyName
@CurrencyCode = 'USD',
@CurrencyName = @CurrencyNameOutput output;

print @CurrencyNameOutput
print @ReturnCode

create procedure Sales.uspGetCurrencyTable
as
select CurrencyCode, Name from Sales.Currency
go

exec Sales.uspGetCurrencyTable

create procedure Sales.uspGetCurrencyInfoAndDetail
@CurrencyCode char(3),
@CurrencyRateDate date
as
select CurrencyCode, Name from Sales.Currency
where CurrencyCode = @CurrencyCode;

select FromCurrencyCode, ToCurrencyCode,
AverageRate, EndOfDayRate, CurrencyRateDate
from Sales.CurrencyRate 
where FromCurrencyCode = @CurrencyCode
and CurrencyRateDate = @CurrencyRateDate
go

exec Sales.uspGetCurrencyInfoAndDetail
@CurrencyCode='USD',
@CurrencyRateDate='2011-05-31'
with result sets
(
(
[Currency Code] char(3),
[Currency Name] varchar(50)
),
(
[From Currency] char(3),
[To Currency] char(3),
[Average Rate] numeric(7,4),
[End Of Day Rate] numeric(7,4),
[Currency As-Of Date] date
)
)

create procedure Sales.uspInsertNewCurrency
@CurrencyCode char(3)
as
select CurrencyCode, Name 
from Sales.Currency
where CurrencyCode = @CurrencyCode
go

create table Sales.NewCurrency
(
CurrencyCode char(3),
Name varchar(50)
)

insert into Sales.NewCurrency(CurrencyCode, Name)
exec Sales.uspInsertNewCurrency @CurrencyCode='CAD'

select CurrencyCode, Name from Sales.NewCurrency