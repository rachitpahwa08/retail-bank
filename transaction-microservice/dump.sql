;             
CREATE USER IF NOT EXISTS "USER" SALT '8f0de5d8902cecf9' HASH '2305b1acd67b8cb1fba228f7ec9e6a5c6b0c320e90af7b5cb6ef63830e13aa6e' ADMIN;       
CREATE SEQUENCE "PUBLIC"."SYSTEM_SEQUENCE_8B8444CD_F7B0_43A7_9D26_6AFC642BBD7B" START WITH 6 BELONGS_TO_TABLE;
CREATE SEQUENCE "PUBLIC"."SYSTEM_SEQUENCE_67FB2AE9_56C7_4588_8432_41CB0F525836" START WITH 1 BELONGS_TO_TABLE;
CREATE SEQUENCE "PUBLIC"."SYSTEM_SEQUENCE_F6276B4C_3D33_4B77_8423_4B6264C22C70" START WITH 1 BELONGS_TO_TABLE;
CREATE MEMORY TABLE "PUBLIC"."COUNTERPARTIES"(
    "COUNTERPARTY_ID" INTEGER DEFAULT NEXT VALUE FOR "PUBLIC"."SYSTEM_SEQUENCE_67FB2AE9_56C7_4588_8432_41CB0F525836" NOT NULL NULL_TO_DEFAULT SEQUENCE "PUBLIC"."SYSTEM_SEQUENCE_67FB2AE9_56C7_4588_8432_41CB0F525836",
    "COUNTERPARTY_NAME" VARCHAR(255)
);             
ALTER TABLE "PUBLIC"."COUNTERPARTIES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_3" PRIMARY KEY("COUNTERPARTY_ID");  
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.COUNTERPARTIES;          
CREATE MEMORY TABLE "PUBLIC"."FINANCIAL_TRANSACTIONS"(
    "TRANSACTION_ID" BIGINT DEFAULT NEXT VALUE FOR "PUBLIC"."SYSTEM_SEQUENCE_8B8444CD_F7B0_43A7_9D26_6AFC642BBD7B" NOT NULL NULL_TO_DEFAULT SEQUENCE "PUBLIC"."SYSTEM_SEQUENCE_8B8444CD_F7B0_43A7_9D26_6AFC642BBD7B",
    "ACCOUNT_ID" VARCHAR(255),
    "AMOUNT_OF_TRANSACTION" FLOAT NOT NULL,
    "CLOSING_BALANCE" FLOAT NOT NULL,
    "DATE_OF_TRANSACTION" TIMESTAMP,
    "RECIEVER_ACCOUNT_ID" VARCHAR(255),
    "COUNTERPARTY_ID" INTEGER,
    "PAYMENT_METHOD_CODE" VARCHAR(255),
    "TRANSACTION_STATUS_CODE" VARCHAR(255),
    "TRANSACTION_TYPE_CODE" VARCHAR(255),
    "SERVICE_ID" INTEGER
);               
ALTER TABLE "PUBLIC"."FINANCIAL_TRANSACTIONS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_D" PRIMARY KEY("TRANSACTION_ID");           
-- 5 +/- SELECT COUNT(*) FROM PUBLIC.FINANCIAL_TRANSACTIONS;  
INSERT INTO "PUBLIC"."FINANCIAL_TRANSACTIONS" VALUES
(1, '2000220xc', 22200.0, 42200.0, TIMESTAMP '2021-03-28 13:39:18.578187', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(2, '2000220xc', 12200.0, 54400.0, TIMESTAMP '2021-04-01 13:39:32.076911', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(3, '2000220xc', 2200.0, 56600.0, TIMESTAMP '2021-04-15 13:39:45.351829', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(4, '2000220xc', 200.0, 56400.0, TIMESTAMP '2021-04-28 13:40:07.251801', NULL, NULL, NULL, 'SUCCESS', 'WITHDRAW', NULL),
(5, '2000220xc', 1200.0, 55200.0, TIMESTAMP '2021-04-28 13:40:16.633103', NULL, NULL, NULL, 'SUCCESS', 'WITHDRAW', NULL);     
CREATE MEMORY TABLE "PUBLIC"."REF_PAYMENT_METHODS"(
    "PAYMENT_METHOD_CODE" VARCHAR(255) NOT NULL,
    "PAYEMENT_METHOD_NAME" VARCHAR(255)
);            
ALTER TABLE "PUBLIC"."REF_PAYMENT_METHODS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_7" PRIMARY KEY("PAYMENT_METHOD_CODE");         
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.REF_PAYMENT_METHODS;     
CREATE MEMORY TABLE "PUBLIC"."REF_TRANSACTION_STATUS"(
    "TRANSACTION_STATUS_CODE" VARCHAR(255) NOT NULL,
    "TRANSACTION_STATUS_DESCRIPTION" VARCHAR(255)
);           
ALTER TABLE "PUBLIC"."REF_TRANSACTION_STATUS" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_E" PRIMARY KEY("TRANSACTION_STATUS_CODE");  
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.REF_TRANSACTION_STATUS;  
INSERT INTO "PUBLIC"."REF_TRANSACTION_STATUS" VALUES
('SUCCESS', 'Transaction Success'),
('FAILURE', 'Transaction Failed'); 
CREATE MEMORY TABLE "PUBLIC"."REF_TRANSACTION_TYPES"(
    "TRANSACTION_TYPE_CODE" VARCHAR(255) NOT NULL,
    "TRANSACTION_TYPE_DESCRIPTION" VARCHAR(255)
);
ALTER TABLE "PUBLIC"."REF_TRANSACTION_TYPES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_8" PRIMARY KEY("TRANSACTION_TYPE_CODE");     
-- 3 +/- SELECT COUNT(*) FROM PUBLIC.REF_TRANSACTION_TYPES;   
INSERT INTO "PUBLIC"."REF_TRANSACTION_TYPES" VALUES
('DEPOSIT', 'Amount Deposited'),
('WITHDRAW', 'Amount Withdrawn'),
('TRANSFER', 'Amount Transfer');    
CREATE MEMORY TABLE "PUBLIC"."SERVICES"(
    "SERVICE_ID" INTEGER DEFAULT NEXT VALUE FOR "PUBLIC"."SYSTEM_SEQUENCE_F6276B4C_3D33_4B77_8423_4B6264C22C70" NOT NULL NULL_TO_DEFAULT SEQUENCE "PUBLIC"."SYSTEM_SEQUENCE_F6276B4C_3D33_4B77_8423_4B6264C22C70",
    "DATE_SERVICE_PROVIDED" DATE
);            
ALTER TABLE "PUBLIC"."SERVICES" ADD CONSTRAINT "PUBLIC"."CONSTRAINT_80" PRIMARY KEY("SERVICE_ID");            
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.SERVICES;
ALTER TABLE "PUBLIC"."FINANCIAL_TRANSACTIONS" ADD CONSTRAINT "PUBLIC"."FKGKGUFLDCHYVA7FKCFWTPOO80X" FOREIGN KEY("SERVICE_ID") REFERENCES "PUBLIC"."SERVICES"("SERVICE_ID") NOCHECK;           
ALTER TABLE "PUBLIC"."FINANCIAL_TRANSACTIONS" ADD CONSTRAINT "PUBLIC"."FKL886XAA31RK8SJKSITJTCD1N6" FOREIGN KEY("TRANSACTION_TYPE_CODE") REFERENCES "PUBLIC"."REF_TRANSACTION_TYPES"("TRANSACTION_TYPE_CODE") NOCHECK;        
ALTER TABLE "PUBLIC"."FINANCIAL_TRANSACTIONS" ADD CONSTRAINT "PUBLIC"."FK4BQ0Q41Y4YDM3RH6CBKRWWTBY" FOREIGN KEY("COUNTERPARTY_ID") REFERENCES "PUBLIC"."COUNTERPARTIES"("COUNTERPARTY_ID") NOCHECK;           
ALTER TABLE "PUBLIC"."FINANCIAL_TRANSACTIONS" ADD CONSTRAINT "PUBLIC"."FKCX1XA7I3Y8ONLG0CBH31XQ1H0" FOREIGN KEY("PAYMENT_METHOD_CODE") REFERENCES "PUBLIC"."REF_PAYMENT_METHODS"("PAYMENT_METHOD_CODE") NOCHECK;              
ALTER TABLE "PUBLIC"."FINANCIAL_TRANSACTIONS" ADD CONSTRAINT "PUBLIC"."FKALQCOGAPHGXWLYWUCW39052SG" FOREIGN KEY("TRANSACTION_STATUS_CODE") REFERENCES "PUBLIC"."REF_TRANSACTION_STATUS"("TRANSACTION_STATUS_CODE") NOCHECK;   
