INSERT into REF_TRANSACTION_STATUS 
VALUES ('SUCCESS','Transaction Success'),('FAILURE','Transaction Failed');

INSERT into ref_transaction_types
VALUES ('DEPOSIT','Amount Deposited'),('WITHDRAW','Amount Withdrawn'),('TRANSFER','Amount Transfer');

INSERT INTO "PUBLIC"."FINANCIAL_TRANSACTIONS" VALUES
(100001, '10054546', 22200.0, 42200.0, TIMESTAMP '2021-03-28 13:39:18.578187', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(100002, '10054546', 12200.0, 54400.0, TIMESTAMP '2021-04-01 13:39:32.076911', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(100003, '10054546', 2200.0, 56600.0, TIMESTAMP '2021-04-15 13:39:45.351829', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(100004, '10054546', 200.0, 56400.0, TIMESTAMP '2021-04-28 13:40:07.251801', NULL, NULL, NULL, 'SUCCESS', 'WITHDRAW', NULL),
(100005, '10054546', 1200.0, 55200.0, TIMESTAMP '2021-04-28 13:40:16.633103', NULL, NULL, NULL, 'SUCCESS', 'WITHDRAW', NULL),
(100006, '10054546', 5780.0, 16780.0, TIMESTAMP '2021-04-28 15:54:52.467266', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(100007, '10054546', 5780.0, 22560.0, TIMESTAMP '2021-04-28 15:55:44.243987', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(100008, '10054546', 5780.0, 5220.0, TIMESTAMP '2021-04-28 15:57:25.816966', NULL, NULL, NULL, 'SUCCESS', 'WITHDRAW', NULL),
(100009, '10054546', 5780.0, 11000.0, TIMESTAMP '2021-04-28 15:57:41.733261', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(100010, '10054546', 5780.0, 16780.0, TIMESTAMP '2021-04-28 16:00:05.41336', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL),
(100011, '10054546', 5780.0, 11000.0, TIMESTAMP '2021-04-28 16:00:17.430832', NULL, NULL, NULL, 'SUCCESS', 'WITHDRAW', NULL),
(100012, '10054546', 8000.0, 3000.0, TIMESTAMP '2021-04-28 16:05:55.198706', NULL, NULL, NULL, 'SUCCESS', 'WITHDRAW', NULL),
(100013, '10054546', 10100.0, 13100.0, TIMESTAMP '2021-04-28 16:06:11.371382', NULL, NULL, NULL, 'SUCCESS', 'DEPOSIT', NULL);    