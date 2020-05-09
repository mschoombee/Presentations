CREATE TABLE [Dimension].[Employee] (
    [EmployeeKey]                   INT            IDENTITY (1, 1) NOT NULL,
    [DurableEmployeeKey]            INT            DEFAULT ((-9)) NOT NULL,
    [EmployeeId]                    VARCHAR (50)   DEFAULT ('-9') NOT NULL,
    [DivisionId]                    VARCHAR (50)   DEFAULT ('-9') NOT NULL,
    [FirstName]                     VARCHAR (50)   DEFAULT ('Unknown') NOT NULL,
    [LastName]                      VARCHAR (50)   DEFAULT ('Unknown') NOT NULL,
    [EmployeeName]                  VARCHAR (100)  DEFAULT ('Unknown') NOT NULL,
    [Gender]                        VARCHAR (10)   DEFAULT ('Unknown') NOT NULL,
    [DateOfBirth]                   DATE           DEFAULT (CONVERT([date],'19000101')) NOT NULL,
    [MaritalStatus]                 VARCHAR (20)   DEFAULT ('Unknown') NOT NULL,
    [EthnicOrigin]                  VARCHAR (20)   DEFAULT ('Unknown') NOT NULL,
    [Address]                       VARCHAR (500)  DEFAULT ('Unknown') NOT NULL,
    [City]                          VARCHAR (50)   DEFAULT ('Unknown') NOT NULL,
    [StateOrProvince]               VARCHAR (50)   DEFAULT ('Unknown') NOT NULL,
    [Country]                       VARCHAR (50)   DEFAULT ('Unknown') NOT NULL,
    [PostalCode]                    VARCHAR (20)   DEFAULT ('Unknown') NOT NULL,
    [PhoneNumber]                   VARCHAR (20)   DEFAULT ('Unknown') NOT NULL,
    [EmailAddress]                  VARCHAR (100)  DEFAULT ('Unknown') NOT NULL,
    [DriversLicenseStateOrProvince] VARCHAR (50)   DEFAULT ('Unknown') NOT NULL,
    [DriversLicenseExpirationDate]  DATE           DEFAULT (CONVERT([date],'19000101')) NOT NULL,
    [AutoInsuranceCompany]          VARCHAR (100)  DEFAULT ('Unknown') NOT NULL,
    [AutoInsuranceExpirationDate]   DATE           DEFAULT (CONVERT([date],'19000101')) NOT NULL,
    [JobTitle]                      VARCHAR (100)  DEFAULT ('Unknown') NOT NULL,
    [EmploymentStatus]              VARCHAR (50)   DEFAULT ('Unknown') NOT NULL,
    [HireDate]                      DATE           DEFAULT (CONVERT([date],'19000101')) NOT NULL,
    [MaximumWeeklyHours]            MONEY          DEFAULT (CONVERT([money],(0.00))) NOT NULL,
    [PayFrequency]                  VARCHAR (20)   DEFAULT ('Unknown') NOT NULL,
    [PayAmount]                     MONEY          DEFAULT (CONVERT([money],(0.00))) NOT NULL,
    [Chaplain]                      BIT            DEFAULT (CONVERT([bit],(0))) NOT NULL,
    [IRSApprovedMinister]           BIT            DEFAULT (CONVERT([bit],(0))) NOT NULL,
    [Denomination]                  VARCHAR (100)  DEFAULT ('Unknown') NOT NULL,
    [DenominationalEndorsement]     BIT            DEFAULT (CONVERT([bit],(0))) NOT NULL,
    [EndorsementAgency]             VARCHAR (100)  DEFAULT ('Unknown') NOT NULL,
    [EndorsementDate]               DATE           DEFAULT (CONVERT([date],'19000101')) NOT NULL,
    [Ordained]                      BIT            DEFAULT (CONVERT([bit],(0))) NOT NULL,
    [OrdainedDate]                  DATE           DEFAULT (CONVERT([date],'19000101')) NOT NULL,
    [OrdainedAgency]                VARCHAR (100)  DEFAULT ('Unknown') NOT NULL,
    [Licensed]                      BIT            DEFAULT (CONVERT([bit],(0))) NOT NULL,
    [LicensedDate]                  DATE           DEFAULT (CONVERT([date],'19000101')) NOT NULL,
    [LicensedAgency]                VARCHAR (100)  DEFAULT ('Unknown') NOT NULL,
    [ChurchCommissioned]            BIT            DEFAULT (CONVERT([bit],(0))) NOT NULL,
    [CommissionedDate]              DATE           DEFAULT (CONVERT([date],'19000101')) NOT NULL,
    [ChurchName]                    VARCHAR (100)  DEFAULT ('Unknown') NOT NULL,
    [ChurchCity]                    VARCHAR (50)   DEFAULT ('Unknown') NOT NULL,
    [ChurchStateOrPovince]          VARCHAR (50)   DEFAULT ('Unknown') NOT NULL,
    [ImageURL]                      VARCHAR (1000) DEFAULT ('about:blank') NOT NULL,
    [Active]                        BIT            DEFAULT (CONVERT([bit],(1))) NOT NULL,
    [EffectiveDate]                 DATE           DEFAULT (CONVERT([date],'19000101')) NOT NULL,
    [TerminationDate]               DATE           DEFAULT (CONVERT([date],'21001231')) NOT NULL,
    [CurrentRecord]                 BIT            DEFAULT (CONVERT([bit],(1))) NOT NULL,
    [InsertDate]                    DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdateDate]                    DATETIME       NULL,
    CONSTRAINT [PK_Dimension_Employee] PRIMARY KEY CLUSTERED ([EmployeeKey] ASC) WITH (FILLFACTOR = 90)
);






GO
CREATE UNIQUE NONCLUSTERED INDEX [uidx_Dimension_Employee_1]
    ON [Dimension].[Employee]([EmployeeId] ASC, [EffectiveDate] ASC)
    INCLUDE([CurrentRecord], [TerminationDate]) WITH (FILLFACTOR = 90);

