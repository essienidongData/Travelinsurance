--Dataset inspection
select * from [Portfolio Project]..['travel insurance']

-- Gender has null values and would not be used in our analysis
select distinct .dbo.['travel insurance'].Gender from .dbo.['travel insurance']

-- Agency = 16
select distinct .dbo.['travel insurance'].Agency as Number_of_Agencies from .dbo.['travel insurance']

-- Agency Types = 2
select distinct .dbo.['travel insurance'].[Agency Type] as Agency_types from .dbo.['travel insurance']

--Travel Destinations = 149
select distinct .dbo.['travel insurance'].Destination as Travel_Destinations from .dbo.['travel insurance']


-- Product Names = 26
select distinct .dbo.['travel insurance'].[Product Name] as Total_products from .dbo.['travel insurance']

--Total Claims 63326, Total not claimed= 
Select count(all ['travel insurance'].[Claim]) as total_claims,sum(case when .['travel insurance'].Claim='Yes' THEN 1 ELSE 0 END) as Claims_made,sum(case when .['travel insurance'].Claim='No' THEN 1 ELSE 0 END) as Claims_Not_made from ['travel insurance']

-- Total no_claims= 62399
Select count (All ['travel insurance'].[Claim]) as No_claims from ['travel insurance'] where ['travel insurance'].Claim = 'No'


-- Total Claims = 927
(Select count (All ['travel insurance'].[Claim]) as has_claims from ['travel insurance'] where ['travel insurance'].Claim = 'Yes')

-- Maximum age is 118 might be a typing error
Select  Max(['travel insurance'].Age) as max_age from .dbo.['travel insurance']

--Minimum age = 0 might also be a typing error or a baby
Select  Min(['travel insurance'].Age) as minimum_age from .dbo.['travel insurance']

--grouping of the age highest number of persons aged between 31- 40
select  sum(case when ['travel insurance'].Age between 0 and 10 THEN 1 ELSE 0 end) as  [0-10],
		sum(case when ['travel insurance'].Age between 11 and 20 then 1 else 0 end) as [11-20],
		sum(case when ['travel insurance'].Age between 21 and 30 then 1 else 0 end) as [21-30],
		sum(case when ['travel insurance'].Age between 31 and 40 then 1 else 0 end) as [31-40],
		sum(case when ['travel insurance'].Age between 41 and 50 then 1 else 0 end) as [41-50],
		sum(case when ['travel insurance'].Age between 51 and 60 then 1 else 0 end) as [51-60],
		sum(case when ['travel insurance'].Age between 61 and 70 then 1 else 0 end) as [61-70],
		sum(case when ['travel insurance'].Age between 71 and 80 then 1 else 0 end) as [71-80],
		sum(case when ['travel insurance'].Age between 81 and 90 then 1 else 0 end) as [81-90],
		sum(case when ['travel insurance'].Age between 91 and 100 then 1 else 0 end) as [91-100],
		sum(case when ['travel insurance'].Age between 101 and 110 then 1 else 0 end) as [101-110],
		sum(case when ['travel insurance'].Age between 111 and 120 then 1 else 0 end) as [111-120]
from .['travel insurance']


--Looking at Destinations with claims 
Select ['travel insurance'].Destination,  sum(case when .['travel insurance'].Claim='Yes' THEN 1 ELSE 0 END) as Claims_made,
sum(case when .['travel insurance'].Claim='No' THEN 1 ELSE 0 END) as Claims_Not_made, 
sum(case when .['travel insurance'].Claim='Yes' THEN 1 ELSE 0 END)+
sum(case when .['travel insurance'].Claim='No' THEN 1 ELSE 0 END) as Total_claims
 from ['travel insurance']
group by .['travel insurance'].Destination
order by Total_Claims Desc


--Looking at Product_name with claims 
Select ['travel insurance'].[Product Name],  sum(case when .['travel insurance'].Claim='Yes' THEN 1 ELSE 0 END) as Claims_made,
sum(case when .['travel insurance'].Claim='No' THEN 1 ELSE 0 END) as Claims_Not_made, 
sum(case when .['travel insurance'].Claim='Yes' THEN 1 ELSE 0 END)+
sum(case when .['travel insurance'].Claim='No' THEN 1 ELSE 0 END) as Total_claims
from ['travel insurance']
group by .['travel insurance'].[Product Name]
order by Total_Claims Desc

 
--Looking at Product against total net sales and Total commision value that had claims made
Select .['travel insurance'].[Product Name], sum(.['travel insurance'].[Net Sales]) Total_netsales,
sum(.['travel insurance'].[Commision (in value)]) as Total_Commision_value, sum(case when .['travel insurance'].Claim='Yes' THEN 1 ELSE 0 END) as Claims_made
from ['travel insurance']
group by .['travel insurance'].[Product Name]
order by Claims_made Desc

--Looking at Product against total net sales and Total commision value that claims not made
Select .['travel insurance'].[Product Name], sum(.['travel insurance'].[Net Sales]) Total_netsales,
sum(.['travel insurance'].[Commision (in value)]) as Total_Commision_value, sum(case when .['travel insurance'].Claim='No' THEN 1 ELSE 0 END) as Claims_Not_made
from ['travel insurance']
group by .['travel insurance'].[Product Name]
order by Claims_Not_made Desc


--Looking at Product against total net sales and Total commision value
Select .['travel insurance'].[Product Name], sum(.['travel insurance'].[Net Sales]) Total_netsales,
sum(.['travel insurance'].[Commision (in value)]) as Total_Commision_value, count(.['travel insurance'].Claim) as Total_Claims
from ['travel insurance']
group by .['travel insurance'].[Product Name]
order by Total_Claims Desc

--Looking at Agency against total net sales and Total commision value
select distinct .dbo.['travel insurance'].Agency, sum(.['travel insurance'].[Net Sales]) Total_netsales,
sum(.['travel insurance'].[Commision (in value)]) as Total_Commision_value, count(.['travel insurance'].Claim) as Total_Claims
from ['travel insurance']
group by .['travel insurance'].Agency
order by Total_Claims Desc


--Looking at Product name with highest no claims= Cancellation plan
Select .['travel insurance'].[Product Name], count(.['travel insurance'].Claim) as Total_Claims from ['travel insurance']
where ['travel insurance'].Claim = 'No'
group by .['travel insurance'].[Product Name]
order by Total_Claims Desc


--Looking at Product with highest claims= Bronze plan
Select .['travel insurance'].[Product Name], count(.['travel insurance'].Claim) as Total_Claims from ['travel insurance']
where ['travel insurance'].Claim = 'Yes'
group by .['travel insurance'].[Product Name]
order by Total_Claims Desc

--Looking at Age and claims
Select .['travel insurance'].Age,.['travel insurance'].Claim, count(distinct .['travel insurance'].Claim) as Total_Claims from ['travel insurance']
group by ['travel insurance'].Age,['travel insurance'].Claim
order by ['travel insurance'].Age Desc


--Looking at Age with highest claims= 36 Years
Select .['travel insurance'].Age, count(.['travel insurance'].Claim) as Total_Claims from ['travel insurance']
where ['travel insurance'].Claim = 'Yes'
group by .['travel insurance'].Age
order by Total_Claims Desc

--Looking at Age with highest with no claims= 36 Years
Select .['travel insurance'].Age, count(.['travel insurance'].Claim) as Total_No_Claims from ['travel insurance']
where ['travel insurance'].Claim = 'No'
group by .['travel insurance'].Age
order by Total_No_Claims Desc