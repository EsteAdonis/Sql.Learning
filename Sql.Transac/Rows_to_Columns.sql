use adonis;

Create table Input_Table (
    SalesDate date,
    CutomerId varchar(10),
    Amount money
);
Go;

Select Cast( DateAdd(mm, - Rand() * 12, GetDate() ) as Date )

Select Cast ((Rand() * 352.00) as decimal(10,2)) as Amount


Insert Input_Table values(Cast( DateAdd(mm, - Rand() * 12, GetDate()) as Date), 'Cust-3', Cast ((Rand() * 352.00) as decimal(10,2)));
Insert Input_Table values(Cast( DateAdd(mm, - Rand() * 12, GetDate()) as Date), 'Cust-3', Cast ((Rand() * 352.00) as decimal(10,2)));
Insert Input_Table values(Cast( DateAdd(mm, - Rand() * 12, GetDate()) as Date), 'Cust-3', Cast ((Rand() * 352.00) as decimal(10,2)));
Insert Input_Table values(Cast( DateAdd(mm, - Rand() * 12, GetDate()) as Date), 'Cust-3', Cast ((Rand() * 352.00) as decimal(10,2)));
Insert Input_Table values(Cast( DateAdd(mm, - Rand() * 12, GetDate()) as Date), 'Cust-3', Cast ((Rand() * 352.00) as decimal(10,2)));
Insert Input_Table values(Cast( DateAdd(mm, - Rand() * 12, GetDate()) as Date), 'Cust-3', Cast ((Rand() * 352.00) as decimal(10,2)));
Insert Input_Table values(Cast( DateAdd(mm, - Rand() * 12, GetDate()) as Date), 'Cust-3', Cast ((Rand() * 352.00) as decimal(10,2)));
Insert Input_Table values(Cast( DateAdd(mm, - Rand() * 12, GetDate()) as Date), 'Cust-3', Cast ((Rand() * 352.00) as decimal(10,2)));
Insert Input_Table values(Cast( DateAdd(mm, - Rand() * 12, GetDate()) as Date), 'Cust-3', Cast ((Rand() * 352.00) as decimal(10,2)));

Select * From Input_Table order by 2,1

With pivot_data as (
    Select *
    From (
            Select format(SalesDate, 'MMM-yy') as SalesDate, CutomerId as CustomerId, Amount
            From Input_Table  
        ) as SourceTable
    Pivot (
        Sum(Amount)
        For SalesDate in ([Aug-24], [Dec-24], [Feb-25], [Jan-25], [Jul-24], [Jun-24], [Mar-25], [May-25], [Nov-24], [Oct-24])
    ) as PivotTable
    Union 
    Select *
    From (
            Select 'Total' as Customer
                    , format(SalesDate, 'MMM-yy') as SalesDate
                    , Amount
            From Input_Table  
        ) as SourceTable
    Pivot (
        Sum(Amount)
        For SalesDate in ([Aug-24], [Dec-24], [Feb-25], [Jan-25], [Jul-24], [Jun-24], [Mar-25], [May-25], [Nov-24], [Oct-24])
    ) as PivotTable
),
  final_data as (
    Select CustomerId, 
          coalesce([Aug-24], 0) as [Aug-24],
          coalesce([Dec-24], 0) as [Dec-24],      
          coalesce([Feb-25], 0) as [Feb-25],  
          coalesce([Jan-25], 0) as [Jan-25],                
          coalesce([Jul-24], 0) as [Jul-24],
          coalesce([Jun-24], 0) as [Jun-24],
          coalesce([Mar-25], 0) as [Mar-25],
          coalesce([May-25], 0) as [May-25],
          coalesce([Nov-24], 0) as [Nov-24],
          coalesce([Oct-24], 0) as [Oct-24]
    From pivot_data)
Select *
From final_data;