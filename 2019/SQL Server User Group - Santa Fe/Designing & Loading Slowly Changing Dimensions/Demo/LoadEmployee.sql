/************************************************************************************
Created By	: 	Martin Schoombee 
				martin.schoombee@28twelve.consulting
Company		:	28twelve consulting
Date		:	7/22/2019
Summary		:	This procedure loads the employee dimension. 

*************************************************************************************
-- CHANGE CONTROL --
*************************************************************************************
Version			:	
CO Number		:	
Changed By		:	
Date			:	
Details			:	

*************************************************************************************/
CREATE procedure [Dimension].[LoadEmployee]
as

--------------------------------------------------------------------------------------
-- data types & defaults

-- contact
update  [MChap_DW].[Staging_CRM].[contact]
set     -- source fields 
        [contactid] = ltrim(rtrim([contactid]))
    ,   [ownerid] = isnull(ltrim(rtrim([ownerid])), '-9')
    ,   [customertypecode] = isnull(ltrim(rtrim([customertypecode])), '-9')
    ,   [customertypecodename] = isnull(ltrim(rtrim([customertypecodename])), 'Unknown')
    ,   [firstname] = isnull(ltrim(rtrim([firstname])), 'Unknown')
    ,   [middlename] = isnull(ltrim(rtrim([middlename])), 'Unknown')
    ,   [lastname] = isnull(ltrim(rtrim([lastname])), 'Unknown')
    ,   [suffix] = isnull(ltrim(rtrim([suffix])), 'Unknown')
    ,   [nickname] = isnull(ltrim(rtrim([nickname])), 'Unknown')
    ,   [salutation] = isnull(ltrim(rtrim([salutation])), 'Unknown')
    ,   [gendercode] = isnull(ltrim(rtrim([gendercode])), '-9')
    ,   [gendercodename] = isnull(ltrim(rtrim([gendercodename])), 'Unknown')
    ,   [birthdate] = isnull(ltrim(rtrim([birthdate])), '19000101')
    ,   [dcp_mothersmaidenname] = isnull(ltrim(rtrim([dcp_mothersmaidenname])), 'Unknown')
    ,   [spousesname] = isnull(ltrim(rtrim([spousesname])), 'Unknown')
    ,   [anniversary] = isnull(ltrim(rtrim([anniversary])), '19000101')
    ,   [haschildrencode] = isnull(ltrim(rtrim([haschildrencode])), '-9')
    ,   [haschildrencodename] = isnull(ltrim(rtrim([haschildrencodename])), 'Unknown')
    ,   [familystatuscode] = isnull(ltrim(rtrim([familystatuscode])), '-9')
    ,   [familystatuscodename] = isnull(ltrim(rtrim([familystatuscodename])), 'Unknown')
    ,   [dcp_ethnicorigincode] = isnull(ltrim(rtrim([dcp_ethnicorigincode])), '-9')
    ,   [dcp_ethnicorigincodename] = isnull(ltrim(rtrim([dcp_ethnicorigincodename])), 'Unknown')
    ,   [address1_line1] = isnull(ltrim(rtrim([address1_line1])), 'Unknown')
    ,   [address1_line2] = isnull(ltrim(rtrim([address1_line2])), 'Unknown')
    ,   [address1_city] = isnull(ltrim(rtrim([address1_city])), 'Unknown')
    ,   [address1_stateorprovince] = isnull(ltrim(rtrim([address1_stateorprovince])), 'Unknown')
    ,   [address1_country] = isnull(ltrim(rtrim([address1_country])), 'Unknown')
    ,   [address1_postalcode] = isnull(ltrim(rtrim([address1_postalcode])), 'Unknown')
    ,   [dcp_primaryphone] = isnull(ltrim(rtrim([dcp_primaryphone])), 'Unknown')
    ,   [dcp_primaryphonename] = isnull(ltrim(rtrim([dcp_primaryphonename])), 'Unknown')
    ,   [telephone1] = isnull(ltrim(rtrim([telephone1])), 'Unknown')
    ,   [telephone2] = isnull(ltrim(rtrim([telephone2])), 'Unknown')
    ,   [mobilephone] = isnull(ltrim(rtrim([mobilephone])), 'Unknown')
    ,   [emailaddress1] = isnull(ltrim(rtrim([emailaddress1])), 'Unknown')
    ,   [entityimage_url] = isnull(ltrim(rtrim([entityimage_url])), 'Unknown')
    ,   [dcp_emergencycontact] = isnull(ltrim(rtrim([dcp_emergencycontact])), 'Unknown')
    ,   [dcp_emergencycontactphonenumber] = isnull(ltrim(rtrim([dcp_emergencycontactphonenumber])), 'Unknown')
    ,   [dcp_driverslicensestate] = isnull(ltrim(rtrim([dcp_driverslicensestate])), 'Unknown')
    ,   [dcp_driverslicensestatename] = isnull(ltrim(rtrim([dcp_driverslicensestatename])), 'Unknown')
    ,   [dcp_driverslicensestateorprovince] = isnull(ltrim(rtrim([dcp_driverslicensestateorprovince])), 'Unknown')
    ,   [dcp_driverslicensenumber] = isnull(ltrim(rtrim([dcp_driverslicensenumber])), 'Unknown')
    ,   [dcp_driverslicenseexpiration] = isnull(ltrim(rtrim([dcp_driverslicenseexpiration])), '19000101')
    ,   [dcp_autoinsurancecompany] = isnull(ltrim(rtrim([dcp_autoinsurancecompany])), 'Unknown')
    ,   [dcp_autoinsurancepolicy] = isnull(ltrim(rtrim([dcp_autoinsurancepolicy])), 'Unknown')
    ,   [dcp_autoinsuranceexpiration] = isnull(ltrim(rtrim([dcp_autoinsuranceexpiration])), '19000101')
    ,   [jobtitle] = isnull(ltrim(rtrim([jobtitle])), 'Unknown')
    ,   [dcp_executive] = isnull(ltrim(rtrim([dcp_executive])), 'Unknown')
    ,   [dcp_executivename] = isnull(ltrim(rtrim([dcp_executivename])), 'Unknown')
    ,   [dcp_chaplainflag] = isnull(ltrim(rtrim([dcp_chaplainflag])), 'Unknown')
    ,   [dcp_chaplainflagname] = isnull(ltrim(rtrim([dcp_chaplainflagname])), 'Unknown')
    ,   [dcp_hiredate] = isnull(ltrim(rtrim([dcp_hiredate])), '19000101')
    ,   [dcp_ordainedflag] = isnull(ltrim(rtrim([dcp_ordainedflag])), 'Unknown')
    ,   [dcp_ordainedflagname] = isnull(ltrim(rtrim([dcp_ordainedflagname])), 'Unknown')
    ,   [dcp_ordainedagency] = isnull(ltrim(rtrim([dcp_ordainedagency])), 'Unknown')
    ,   [dcp_ordaineddate] = isnull(ltrim(rtrim([dcp_ordaineddate])), '19000101')
    ,   [dcp_licensedflag] = isnull(ltrim(rtrim([dcp_licensedflag])), 'Unknown')
    ,   [dcp_licensedflagname] = isnull(ltrim(rtrim([dcp_licensedflagname])), 'Unknown')
    ,   [dcp_licensedagency] = isnull(ltrim(rtrim([dcp_licensedagency])), 'Unknown')
    ,   [dcp_licenseddate] = isnull(ltrim(rtrim([dcp_licenseddate])), '19000101')
    ,   [dcp_churchcommissionedflag] = isnull(ltrim(rtrim([dcp_churchcommissionedflag])), 'Unknown')
    ,   [dcp_churchcommissionedflagname] = isnull(ltrim(rtrim([dcp_churchcommissionedflagname])), 'Unknown')
    ,   [dcp_churchcommissioneddate] = isnull(ltrim(rtrim([dcp_churchcommissioneddate])), '19000101')
    ,   [dcp_churchcommissionedname] = isnull(ltrim(rtrim([dcp_churchcommissionedname])), 'Unknown')
    ,   [dcp_churchcommissionedcity] = isnull(ltrim(rtrim([dcp_churchcommissionedcity])), 'Unknown')
    ,   [dcp_churchcommissionedstate] = isnull(ltrim(rtrim([dcp_churchcommissionedstate])), 'Unknown')
    ,   [dcp_irsapprovedministerflag] = isnull(ltrim(rtrim([dcp_irsapprovedministerflag])), 'Unknown')
    ,   [dcp_irsapprovedministerflagname] = isnull(ltrim(rtrim([dcp_irsapprovedministerflagname])), 'Unknown')
    ,   [dcp_denominationcode] = isnull(ltrim(rtrim([dcp_denominationcode])), '-9')
    ,   [dcp_denominationcodename] = isnull(ltrim(rtrim([dcp_denominationcodename])), 'Unknown')
    ,   [dcp_denominationalendorsementflag] = isnull(ltrim(rtrim([dcp_denominationalendorsementflag])), 'Unknown')
    ,   [dcp_denominationalendorsementflagname] = isnull(ltrim(rtrim([dcp_denominationalendorsementflagname])), 'Unknown')
    ,   [dcp_denominationalendorsementagency] = isnull(ltrim(rtrim([dcp_denominationalendorsementagency])), 'Unknown')
    ,   [dcp_denominationalendorsementdate] = isnull(ltrim(rtrim([dcp_denominationalendorsementdate])), '19000101')
    ,   [cat_employeestatusglobal] = isnull(ltrim(rtrim([cat_employeestatusglobal])), 'Unknown')
    ,   [cat_employeestatusglobalname] = isnull(ltrim(rtrim([cat_employeestatusglobalname])), 'Unknown')
    ,   [statuscode] = isnull(ltrim(rtrim([statuscode])), '-9')
    ,   [statuscodename] = isnull(ltrim(rtrim([statuscodename])), 'Unknown')
    ,   [modifiedon] = isnull(ltrim(rtrim([modifiedon])), '19000101')
    -- additional fields
    ,   [EmployeeKey] = null
    ,   [DurableEmployeeKey] = null
    ,   [EmployeeName] = 'Unknown'
    ,   [DateOfBirth] = convert(date, '19000101')
    ,   [Address] = 'Unknown'
    ,   [DriversLicenseExpirationDate] = convert(date, '19000101')
    ,   [AutoInsuranceExpirationDate] = convert(date, '19000101')
    ,   [HireDate] = convert(date, '19000101')
    ,   [MaximumWeeklyHours] = convert(money, 0.00)
    ,   [PayFrequency] = 'Unknown'
    ,   [PayAmount] = convert(money, 0.00)
    ,   [Chaplain] = convert(bit, 0)
    ,   [IRSApprovedMinister] = convert(bit, 0)
    ,   [DenominationalEndorsement] = convert(bit, 0)
    ,   [EndorsementDate] = convert(date, '19000101')
    ,   [Ordained] = convert(bit, 0)
    ,   [OrdainedDate] = convert(date, '19000101')
    ,   [Licensed] = convert(bit, 0)
    ,   [LicensedDate] = convert(date, '19000101')
    ,   [ChurchCommissioned] = convert(bit, 0)
    ,   [CommissionedDate] = convert(date, '19000101')
    ,   [ImageURL] = 'about:blank'
    ,   [Active] = convert(bit, 1)
    ,   [Type_1_Change] = convert(bit, 0)
    ,   [Type_2_Change] = convert(bit, 0)
    ,   [Type_2_Exception] = convert(bit, 0)

where   [customertypecode] = '804810000' -- employees
;


-- dcp_payrollrecord
update  [MChap_DW].[Staging_CRM].[dcp_payrollrecord]
set     -- source fields 
        [dcp_payrollrecordid] = ltrim(rtrim([dcp_payrollrecordid]))
    ,   [dcp_contactid] = ltrim(rtrim([dcp_contactid]))
    ,   [dcp_employmentstatus] = isnull(ltrim(rtrim([dcp_employmentstatus])), '-9')
    ,   [dcp_employmentstatusname] = isnull(ltrim(rtrim([dcp_employmentstatusname])), 'Unknown')
    ,   [dcp_paytype] = isnull(ltrim(rtrim([dcp_paytype])), '-9')
    ,   [dcp_paytypename] = isnull(ltrim(rtrim([dcp_paytypename])), 'Unknown')
    ,   [dcp_effectivedate] = isnull(ltrim(rtrim([dcp_effectivedate])), '19000101')
    ,   [dcp_payamount] = isnull([dcp_payamount], convert(decimal(10,4), 0.00))
    ,   [transactioncurrencyid] = isnull(ltrim(rtrim([transactioncurrencyid])), '-9')
    ,   [transactioncurrencyidname] = isnull(ltrim(rtrim([transactioncurrencyidname])), 'Unknown')
    ,   [dcp_maxhoursperweek] = isnull([dcp_maxhoursperweek], convert(decimal(10,4), 0.00))
    ,   [modifiedon] = isnull(ltrim(rtrim([modifiedon])), '19000101')
    ,   [statuscode] = isnull(ltrim(rtrim([statuscode])), '-9')
    ,   [statuscodename] = isnull(ltrim(rtrim([statuscodename])), 'Unknown')
    -- additional fields
    ,   [EffectiveDate] = convert(date, '19000101')
;


----------------------------------------------------------------------------------------------------
-- lookups (order is important here)

-- dcp_payrollrecord: general
update  [MChap_DW].[Staging_CRM].[dcp_payrollrecord]
set     [EffectiveDate] =   isnull
                            (
                                try_convert(date, [dcp_effectivedate])
                            ,   convert(date, '19000101') 
                            )
;


-- contact: general
update  [MChap_DW].[Staging_CRM].[contact]
set     [EmployeeName] = trim(replace([firstname] + ' ' + [lastname], 'Unknown', ''))
    ,   [DateOfBirth] = isnull
                        (
                            try_convert(date, [birthdate])
                        ,   convert(date, '19000101')
                        )
    ,   [Address] = replace
                    (
                        replace
                        (
                            concat_ws
                            (
                                ', '
                            ,   [address1_line1]
                            ,   [address1_line2]
                            ,   [address1_city]
                            ,   [address1_stateorprovince]
                            ,   [address1_country]
                            ,   [address1_postalcode]
                            )
                        ,   ', Unknown'
                        ,   ''   
                        )    
                    ,   'Unknown, '
                    ,   ''
                    )  
    ,   [DriversLicenseExpirationDate] =    isnull
                                            (
                                                try_convert(date, [dcp_driverslicenseexpiration])
                                            ,   convert(date, '19000101')
                                            )
    ,   [AutoInsuranceExpirationDate] = isnull
                                        (
                                            try_convert(date, [dcp_autoinsuranceexpiration])
                                        ,   convert(date, '19000101')
                                        )
    ,   [HireDate] =    isnull
                        (
                            try_convert(date, [dcp_hiredate])
                        ,   convert(date, '19000101')
                        )
    ,   [Chaplain] =    isnull
                        (
                            try_convert(bit, [dcp_chaplainflag])
                        ,   convert(bit, 0)
                        )
    ,   [IRSApprovedMinister] = isnull
                                (
                                    try_convert(bit, [dcp_irsapprovedministerflag])
                                ,   convert(bit, 0)
                                )
    ,   [DenominationalEndorsement] =   isnull
                                        (
                                            try_convert(bit, [dcp_denominationalendorsementflag])
                                        ,   convert(bit, 0)
                                        )
    ,   [EndorsementDate] = isnull
                            (
                                try_convert(date, [dcp_denominationalendorsementdate])
                            ,   convert(date, '19000101')
                            )
    ,   [Ordained] =    isnull
                        (
                            try_convert(bit, [dcp_ordainedflag])
                        ,   convert(bit, 0)
                        )
    ,   [OrdainedDate] =    isnull
                            (
                                try_convert(date, [dcp_ordaineddate])
                            ,   convert(date, '19000101')
                            )
    ,   [Licensed] =    isnull
                        (
                            try_convert(bit, [dcp_licensedflag])
                        ,   convert(bit, 0)
                        )
    ,   [LicensedDate] =    isnull
                            (
                                try_convert(date, [dcp_licenseddate])
                            ,   convert(date, '19000101')
                            )
    ,   [ChurchCommissioned] =  isnull
                                (
                                    try_convert(bit, [dcp_churchcommissionedflag])
                                ,   convert(bit, 0)
                                )
    ,   [CommissionedDate] =    isnull
                                (
                                    try_convert(date, [dcp_churchcommissioneddate])
                                ,   convert(date, '19000101')
                                )
    ,   [ImageURL] = iif([entityimage_url] = 'about:blank', [entityimage_url], 'https://mchapusa.crm.dynamics.com' + [entityimage_url])
    ,   [Active] = iif([statuscode] = '1', convert(bit, 1), convert(bit, 0))

where   [customertypecode] = '804810000' -- employees
;


-- payroll info
update  [MChap_DW].[Staging_CRM].[contact]
set     [MaximumWeeklyHours] = isnull(payroll.[dcp_maxhoursperweek], convert(money, 0.00))
    ,   [PayFrequency] = isnull(payroll.[dcp_paytypename] , 'Unknown')
    ,   [PayAmount] = isnull(payroll.[dcp_payamount], convert(money, 0.00))

from    [MChap_DW].[Staging_CRM].[contact] ct 
outer apply (
                select  top 1 
                        convert(money, prl.[dcp_maxhoursperweek]) as [dcp_maxhoursperweek]
                    ,   prl.[dcp_paytypename]
                    ,   convert(money, prl.[dcp_payamount]) as [dcp_payamount]

                from    [MChap_DW].[Staging_CRM].[dcp_payrollrecord] prl

                where   prl.[dcp_contactid] = ct.[contactid]
                        and prl.[statuscode] = '1' -- active
                        and prl.[dcp_payamount] <> convert(decimal(10,4), 0.00) -- exclude zero entries
                        and prl.[EffectiveDate] <> convert(date, '19000101') -- exclude blank dates
                        and prl.[EffectiveDate] <= convert(date, getdate()) -- exclude future dated records

                order by prl.[EffectiveDate] desc
                    ,   convert(date, prl.[modifiedon]) desc -- give preference to the most recent modification
            ) payroll

where   ct.[customertypecode] = '804810000' -- employees
;


-- dimension keys
update  [MChap_DW].[Staging_CRM].[contact]
set     [EmployeeKey] = dim.[EmployeeKey]
    ,   [DurableEmployeeKey] = dim.[DurableEmployeeKey]

from    [MChap_DW].[Staging_CRM].[contact] ct 
inner join [MChap_DW].[Dimension].[Employee] dim on dim.[EmployeeId] = ct.[contactid] and dim.[CurrentRecord] = convert(bit, 1)

where   ct.[customertypecode] = '804810000' -- employees
;


----------------------------------------------------------------------------------------------------
-- identify change types

-- type-2 changes
update  [MChap_DW].[Staging_CRM].[contact]
set     [Type_2_Change] = convert(bit, 1)

from    [MChap_DW].[Staging_CRM].[contact] ct 
inner join [MChap_DW].[Dimension].[Employee] dim on dim.[EmployeeKey] = ct.[EmployeeKey]

where   ct.[customertypecode] = '804810000' -- employees 
        and 
        (
            dim.[DivisionId] <> ct.[ownerid]
            or dim.[MaritalStatus] <> ct.[familystatuscodename]
            or dim.[Address] <> ct.[Address]
            or dim.[City] <> ct.[address1_city]
            or dim.[StateOrProvince] <> ct.[address1_stateorprovince]
            or dim.[Country] <> ct.[address1_country]
            or dim.[PostalCode] <> ct.[address1_postalcode]
            or dim.[DriversLicenseStateOrProvince] <> ct.[dcp_driverslicensestateorprovince]
            or dim.[DriversLicenseExpirationDate] <> ct.[DriversLicenseExpirationDate]
            or dim.[AutoInsuranceCompany] <> ct.[dcp_autoinsurancecompany]
            or dim.[AutoInsuranceExpirationDate] <> ct.[AutoInsuranceExpirationDate]
            or dim.[JobTitle] <> ct.[jobtitle]
            or dim.[EmploymentStatus] <> ct.[cat_employeestatusglobalname]
            or dim.[HireDate] <> ct.[HireDate]
            or dim.[MaximumWeeklyHours] <> ct.[MaximumWeeklyHours]
            or dim.[PayFrequency] <> ct.[PayFrequency]
            or dim.[PayAmount] <> ct.[PayAmount]
            or dim.[Chaplain] <> ct.[Chaplain]
            or dim.[IRSApprovedMinister] <> ct.[IRSApprovedMinister]
            or dim.[Denomination] <> ct.[dcp_denominationcodename]
            or dim.[DenominationalEndorsement] <> ct.[DenominationalEndorsement]
            or dim.[EndorsementAgency] <> ct.[dcp_denominationalendorsementagency]
            or dim.[EndorsementDate] <> ct.[EndorsementDate]
            or dim.[Ordained] <> ct.[Ordained]
            or dim.[OrdainedDate] <> ct.[OrdainedDate]
            or dim.[OrdainedAgency] <> ct.[dcp_ordainedagency]
            or dim.[Licensed] <> ct.[Licensed]
            or dim.[LicensedDate] <> ct.[LicensedDate]
            or dim.[LicensedAgency] <> ct.[dcp_licensedagency]
            or dim.[ChurchCommissioned] <> ct.[ChurchCommissioned]
            or dim.[CommissionedDate] <> ct.[CommissionedDate]
            or dim.[ChurchName] <> ct.[dcp_churchcommissionedname]
            or dim.[ChurchCity] <> ct.[dcp_churchcommissionedcity]
            or dim.[ChurchStateOrPovince] <> ct.[dcp_churchcommissionedstate]
        )
;


-- type-1 changes
update  [MChap_DW].[Staging_CRM].[contact]
set     [Type_1_Change] = convert(bit, 1)

from    [MChap_DW].[Staging_CRM].[contact] ct 
inner join [MChap_DW].[Dimension].[Employee] dim on dim.[EmployeeKey] = ct.[EmployeeKey]

where   ct.[customertypecode] = '804810000' -- employees 
        and ct.[Type_2_Change] = convert(bit, 0)
        and 
        (
            dim.[FirstName] <> ct.[firstname]
            or dim.[LastName] <> ct.[lastname]
            or dim.[EmployeeName] <> ct.[EmployeeName]
            or dim.[Gender] <> ct.[gendercodename]
            or dim.[DateOfBirth] <> ct.[DateOfBirth]
            or dim.[EthnicOrigin] <> ct.[dcp_ethnicorigincodename]
            or dim.[PhoneNumber] <> ct.[mobilephone]
            or dim.[EmailAddress] <> ct.[emailaddress1]
            or dim.[ImageURL] <> ct.[ImageURL]
        )
;


-- change type-2 changes to type-2 exceptions (if required)
-- this is a special case where there's a type-2 change but a current record with the same effective date already exists
-- possible scenarios: the etl process is executed more than once on the same day, or multiple type-2 changes occur within the same month
update  [MChap_DW].[Staging_CRM].[contact]
set		[Type_1_Change] = convert(bit, 0)
	,	[Type_2_Change] = convert(bit, 0)
    ,   [Type_2_Exception] = convert(bit, 1)

from    [MChap_DW].[Staging_CRM].[contact] ct 
inner join [MChap_DW].[Dimension].[Employee] dim on dim.[EmployeeKey] = ct.[EmployeeKey]

where	ct.[Type_2_Change] = convert(bit, 1)
        and ct.[customertypecode] = '804810000' -- employees 
		and dim.[EffectiveDate] = convert(date, getdate()) -- current record has already been updated/inserted today
;


----------------------------------------------------------------------------------------------------
-- implement type 1 changes
-- we use the durable key to update all historic record versions

update  [MChap_DW].[Dimension].[Employee] 
set     [FirstName] = ct.[firstname]
    ,   [LastName] = ct.[lastname]
    ,   [EmployeeName] = ct.[EmployeeName]
    ,   [Gender] = ct.[gendercodename]
    ,   [DateOfBirth] = ct.[DateOfBirth]
    ,   [EthnicOrigin] = ct.[dcp_ethnicorigincodename]
    ,   [PhoneNumber] = ct.[mobilephone]
    ,   [EmailAddress] = ct.[emailaddress1]
    ,   [ImageURL] = ct.[ImageURL]
    ,   [UpdateDate] = getdate()

from    [MChap_DW].[Dimension].[Employee] dim 
inner join [MChap_DW].[Staging_CRM].[contact] ct on ct.[DurableEmployeeKey] = dim.[DurableEmployeeKey] 

where   ct.[Type_1_Change] = convert(bit, 1)
        and ct.[customertypecode] = '804810000' -- employees 
        and dim.[EmployeeKey] <> -9 -- don't update the default record
;


----------------------------------------------------------------------------------------------------
-- implement type-2 exceptions 
-- we update all attributes to effectively replace the current record

update  [MChap_DW].[Dimension].[Employee] 
set     [DivisionId] = ct.[ownerid]
    ,   [FirstName] = ct.[firstname]
    ,   [LastName] = ct.[lastname]
    ,   [EmployeeName] = ct.[EmployeeName]
    ,   [Gender] = ct.[gendercodename]
    ,   [DateOfBirth] = ct.[DateOfBirth]
    ,   [MaritalStatus] = ct.[familystatuscodename]
    ,   [EthnicOrigin] = ct.[dcp_ethnicorigincodename]
    ,   [Address] = ct.[Address]
    ,   [City] = ct.[address1_city]
    ,   [StateOrProvince] = ct.[address1_stateorprovince]
    ,   [Country] = ct.[address1_country]
    ,   [PostalCode] = ct.[address1_postalcode]
    ,   [PhoneNumber] = ct.[mobilephone]
    ,   [EmailAddress] = ct.[emailaddress1]
    ,   [DriversLicenseStateOrProvince] = ct.[dcp_driverslicensestateorprovince]
    ,   [DriversLicenseExpirationDate] = ct.[DriversLicenseExpirationDate]
    ,   [AutoInsuranceCompany] = ct.[dcp_autoinsurancecompany]
    ,   [AutoInsuranceExpirationDate] = ct.[AutoInsuranceExpirationDate]
    ,   [JobTitle] = ct.[jobtitle]
    ,   [EmploymentStatus] = ct.[cat_employeestatusglobalname]
    ,   [HireDate] = ct.[HireDate]
    ,   [MaximumWeeklyHours] = ct.[MaximumWeeklyHours]
    ,   [PayFrequency] = ct.[PayFrequency]
    ,   [PayAmount] = ct.[PayAmount]
    ,   [Chaplain] = ct.[Chaplain]
    ,   [IRSApprovedMinister] = ct.[IRSApprovedMinister]
    ,   [Denomination] = ct.[dcp_denominationcodename]
    ,   [DenominationalEndorsement] = ct.[DenominationalEndorsement]
    ,   [EndorsementAgency] = ct.[dcp_denominationalendorsementagency]
    ,   [EndorsementDate] = ct.[EndorsementDate]
    ,   [Ordained] = ct.[Ordained]
    ,   [OrdainedDate] = ct.[OrdainedDate]
    ,   [OrdainedAgency] = ct.[dcp_ordainedagency]
    ,   [Licensed] = ct.[Licensed]
    ,   [LicensedDate] = ct.[LicensedDate]
    ,   [LicensedAgency] = ct.[dcp_licensedagency]
    ,   [ChurchCommissioned] = ct.[ChurchCommissioned]
    ,   [CommissionedDate] = ct.[CommissionedDate]
    ,   [ChurchName] = ct.[dcp_churchcommissionedname]
    ,   [ChurchCity] = ct.[dcp_churchcommissionedcity]
    ,   [ChurchStateOrPovince] = ct.[dcp_churchcommissionedstate]
    ,   [ImageURL] = ct.[ImageURL]
    ,   [Active] = ct.[Active]
    ,   [UpdateDate] = getdate()

from    [MChap_DW].[Dimension].[Employee] dim 
inner join [MChap_DW].[Staging_CRM].[contact] ct on ct.[EmployeeKey] = dim.[EmployeeKey] 

where   ct.[Type_2_Exception] = convert(bit, 1)
        and ct.[customertypecode] = '804810000' -- employees 
        and dim.[EmployeeKey] <> -9 -- don't update the default record
;


----------------------------------------------------------------------------------------------------
-- implement type 2 changes

-- terminate current record
update  [MChap_DW].[Dimension].[Employee]
set     [TerminationDate] = convert(date, dateadd(day, -1, getdate())) 
    ,   [CurrentRecord] = convert(bit, 0)
    ,   [UpdateDate] = getdate()

from    [MChap_DW].[Dimension].[Employee] dim 
inner join [MChap_DW].[Staging_CRM].[contact] ct on ct.[EmployeeKey] = dim.[EmployeeKey]

where   ct.[Type_2_Change] = convert(bit, 1)
        and ct.[customertypecode] = '804810000' -- employees 
        and dim.[CurrentRecord] = convert(bit, 1)
        and dim.[EmployeeKey] <> -9 -- don't update the default record
;


-- insert new record version
insert into [MChap_DW].[Dimension].[Employee] 
(
    [DurableEmployeeKey]
,   [EmployeeId]
,   [DivisionId]
,   [FirstName]
,   [LastName]
,   [EmployeeName]
,   [Gender]
,   [DateOfBirth]
,   [MaritalStatus]
,   [EthnicOrigin]
,   [Address]
,   [City]
,   [StateOrProvince]
,   [Country]
,   [PostalCode]
,   [PhoneNumber]
,   [EmailAddress]
,   [DriversLicenseStateOrProvince]
,   [DriversLicenseExpirationDate]
,   [AutoInsuranceCompany]
,   [AutoInsuranceExpirationDate]
,   [JobTitle]
,   [EmploymentStatus]
,   [HireDate]
,   [MaximumWeeklyHours]
,   [PayFrequency]
,   [PayAmount]
,   [Chaplain]
,   [IRSApprovedMinister]
,   [Denomination]
,   [DenominationalEndorsement]
,   [EndorsementAgency]
,   [EndorsementDate]
,   [Ordained]
,   [OrdainedDate]
,   [OrdainedAgency]
,   [Licensed]
,   [LicensedDate]
,   [LicensedAgency]
,   [ChurchCommissioned]
,   [CommissionedDate]
,   [ChurchName]
,   [ChurchCity]
,   [ChurchStateOrPovince]
,   [ImageURL]
,   [Active]
,   [EffectiveDate]
,   [TerminationDate]
,   [CurrentRecord]
,   [InsertDate]
)
(
    select  ct.[DurableEmployeeKey]
        ,   ct.[contactid] as [EmployeeId]
        ,   ct.[ownerid] as [DivisionId]
        ,   ct.[firstname] as [FirstName]
        ,   ct.[lastname] as [LastName]
        ,   ct.[EmployeeName]
        ,   ct.[gendercodename] as [Gender]
        ,   ct.[DateOfBirth]
        ,   ct.[familystatuscodename] as [MaritalStatus]
        ,   ct.[dcp_ethnicorigincodename] as [EthnicOrigin]
        ,   ct.[Address]
        ,   ct.[address1_city] as [City]
        ,   ct.[address1_stateorprovince] as [StateOrProvince]
        ,   ct.[address1_country] as [Country]
        ,   ct.[address1_postalcode] as [PostalCode]
        ,   ct.[mobilephone] as [PhoneNumber]
        ,   ct.[emailaddress1] as [EmailAddress]
        ,   ct.[dcp_driverslicensestateorprovince] as [DriversLicenseStateOrProvince]
        ,   ct.[DriversLicenseExpirationDate]
        ,   ct.[dcp_autoinsurancecompany] as [AutoInsuranceCompany]
        ,   ct.[AutoInsuranceExpirationDate]
        ,   ct.[jobtitle] as [JobTitle]
        ,   ct.[cat_employeestatusglobalname] as [EmploymentStatus]
        ,   ct.[HireDate]
        ,   ct.[MaximumWeeklyHours]
        ,   ct.[PayFrequency]
        ,   ct.[PayAmount]
        ,   ct.[Chaplain]
        ,   ct.[IRSApprovedMinister]
        ,   ct.[dcp_denominationcodename] as [Denomination]
        ,   ct.[DenominationalEndorsement]
        ,   ct.[dcp_denominationalendorsementagency] as [EndorsementAgency]
        ,   ct.[EndorsementDate]
        ,   ct.[Ordained]
        ,   ct.[OrdainedDate]
        ,   ct.[dcp_ordainedagency] as [OrdainedAgency]
        ,   ct.[Licensed]
        ,   ct.[LicensedDate]
        ,   ct.[dcp_licensedagency] as [LicensedAgency]
        ,   ct.[ChurchCommissioned]
        ,   ct.[CommissionedDate]
        ,   ct.[dcp_churchcommissionedname] as [ChurchName]
        ,   ct.[dcp_churchcommissionedcity] as [ChurchCity]
        ,   ct.[dcp_churchcommissionedstate] as [ChurchStateOrPovince]
        ,   ct.[ImageURL]
        ,   ct.[Active]
        ,   convert(date, getdate()) as [EffectiveDate]
        ,   convert(date, '21001231') as [TerminationDate]
        ,   convert(bit, 1) as [CurrentRecord]
        ,   getdate() as [InsertDate]

    from    [MChap_DW].[Staging_CRM].[contact] ct

    where   ct.[Type_2_Change] = convert(bit, 1)
            and ct.[customertypecode] = '804810000' -- employees
            -- existence check
            and not exists 
            (
                select  * 
                from    [MChap_DW].[Dimension].[Employee] dim
                where   dim.[EmployeeId] = ct.[contactid]
                        and dim.[EffectiveDate] = convert(date, getdate())
            )
)
;


----------------------------------------------------------------------------------------------------
-- insert new records

insert into [MChap_DW].[Dimension].[Employee] 
(
    [DurableEmployeeKey]
,   [EmployeeId]
,   [DivisionId]
,   [FirstName]
,   [LastName]
,   [EmployeeName]
,   [Gender]
,   [DateOfBirth]
,   [MaritalStatus]
,   [EthnicOrigin]
,   [Address]
,   [City]
,   [StateOrProvince]
,   [Country]
,   [PostalCode]
,   [PhoneNumber]
,   [EmailAddress]
,   [DriversLicenseStateOrProvince]
,   [DriversLicenseExpirationDate]
,   [AutoInsuranceCompany]
,   [AutoInsuranceExpirationDate]
,   [JobTitle]
,   [EmploymentStatus]
,   [HireDate]
,   [MaximumWeeklyHours]
,   [PayFrequency]
,   [PayAmount]
,   [Chaplain]
,   [IRSApprovedMinister]
,   [Denomination]
,   [DenominationalEndorsement]
,   [EndorsementAgency]
,   [EndorsementDate]
,   [Ordained]
,   [OrdainedDate]
,   [OrdainedAgency]
,   [Licensed]
,   [LicensedDate]
,   [LicensedAgency]
,   [ChurchCommissioned]
,   [CommissionedDate]
,   [ChurchName]
,   [ChurchCity]
,   [ChurchStateOrPovince]
,   [ImageURL]
,   [Active]
,   [EffectiveDate]
,   [TerminationDate]
,   [CurrentRecord]
,   [InsertDate]
)
(
    select  convert(int, -9) as [DurableEmployeeKey]
        ,   ct.[contactid] as [EmployeeId]
        ,   ct.[ownerid] as [DivisionId]
        ,   ct.[firstname] as [FirstName]
        ,   ct.[lastname] as [LastName]
        ,   ct.[EmployeeName]
        ,   ct.[gendercodename] as [Gender]
        ,   ct.[DateOfBirth]
        ,   ct.[familystatuscodename] as [MaritalStatus]
        ,   ct.[dcp_ethnicorigincodename] as [EthnicOrigin]
        ,   ct.[Address]
        ,   ct.[address1_city] as [City]
        ,   ct.[address1_stateorprovince] as [StateOrProvince]
        ,   ct.[address1_country] as [Country]
        ,   ct.[address1_postalcode] as [PostalCode]
        ,   ct.[mobilephone] as [PhoneNumber]
        ,   ct.[emailaddress1] as [EmailAddress]
        ,   ct.[dcp_driverslicensestateorprovince] as [DriversLicenseStateOrProvince]
        ,   ct.[DriversLicenseExpirationDate]
        ,   ct.[dcp_autoinsurancecompany] as [AutoInsuranceCompany]
        ,   ct.[AutoInsuranceExpirationDate]
        ,   ct.[jobtitle] as [JobTitle]
        ,   ct.[cat_employeestatusglobalname] as [EmploymentStatus]
        ,   ct.[HireDate]
        ,   ct.[MaximumWeeklyHours]
        ,   ct.[PayFrequency]
        ,   ct.[PayAmount]
        ,   ct.[Chaplain]
        ,   ct.[IRSApprovedMinister]
        ,   ct.[dcp_denominationcodename] as [Denomination]
        ,   ct.[DenominationalEndorsement]
        ,   ct.[dcp_denominationalendorsementagency] as [EndorsementAgency]
        ,   ct.[EndorsementDate]
        ,   ct.[Ordained]
        ,   ct.[OrdainedDate]
        ,   ct.[dcp_ordainedagency] as [OrdainedAgency]
        ,   ct.[Licensed]
        ,   ct.[LicensedDate]
        ,   ct.[dcp_licensedagency] as [LicensedAgency]
        ,   ct.[ChurchCommissioned]
        ,   ct.[CommissionedDate]
        ,   ct.[dcp_churchcommissionedname] as [ChurchName]
        ,   ct.[dcp_churchcommissionedcity] as [ChurchCity]
        ,   ct.[dcp_churchcommissionedstate] as [ChurchStateOrPovince]
        ,   ct.[ImageURL]
        ,   ct.[Active]
        ,   iif
            (
                ct.[HireDate] < convert(date, getdate()) and ct.[HireDate] <> convert(date, '19000101')
            ,   ct.[HireDate] -- use the hire date (if back-dated) for the effective date
            ,   convert(date, getdate())
            ) as [EffectiveDate]
        ,   convert(date, '21001231') as [TerminationDate]
        ,   convert(bit, 1) as [CurrentRecord]
        ,   getdate() as [InsertDate]

    from    [MChap_DW].[Staging_CRM].[contact] ct

    where   ct.[EmployeeKey] is null
            and ct.[customertypecode] = '804810000' -- employees
            -- existence check
            and not exists 
            (
                select  * 
                from    [MChap_DW].[Dimension].[Employee] dim
                where   dim.[EmployeeId] = ct.[contactid]
            )
)
;


----------------------------------------------------------------------------------------------------
-- update durable employee keys

update  [MChap_DW].[Dimension].[Employee] 
set     [DurableEmployeeKey] = [EmployeeKey]

where   [EmployeeKey] <> -9 -- don't update the default record 
        and [DurableEmployeeKey] = -9 -- only update new records that were inserted above
;