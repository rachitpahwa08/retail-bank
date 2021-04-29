package com.cognizant.retailbank.transaction.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.cognizant.retailbank.transaction.dto.TransactionStatusDTO;
import com.cognizant.retailbank.transaction.model.FinancialTransactions;
import com.cognizant.retailbank.transaction.model.RefTransactionStatus;
import com.cognizant.retailbank.transaction.model.RefTransactionTypes;
import com.cognizant.retailbank.transaction.repositry.RefTranactionStatusRepositry;
import com.cognizant.retailbank.transaction.repositry.RefTranactionTypeRepositry;
import com.cognizant.retailbank.transaction.repositry.TransactionRepositry;
import com.cognizant.retailbank.transaction.utils.ConvertToDTO;

@Service
public class TransactionService {

	@Autowired
	TransactionRepositry transactionRepositry;
	
	public TransactionStatusDTO deposit(String accountId,float amount,float accountBalance) {
		FinancialTransactions financialTransactions=new FinancialTransactions();
		RefTransactionStatus refTransactionStatus=new RefTransactionStatus();
		refTransactionStatus.setTransactionStatusCode("SUCCESS");
		RefTransactionTypes refTransactionTypes=new RefTransactionTypes();
		refTransactionTypes.setTransactionTypeCode("DEPOSIT");
		financialTransactions.setAccountId(accountId);
		financialTransactions.setAmountOfTransaction(amount);
		financialTransactions.setRefTransactionStatus(refTransactionStatus);
		financialTransactions.setDateOfTransaction(LocalDateTime.now());
		financialTransactions.setRefTransactionTypes(refTransactionTypes);
		financialTransactions.setClosingBalance(accountBalance+amount);
		FinancialTransactions result=transactionRepositry.saveAndFlush(financialTransactions);
		return ConvertToDTO.convertToTransactionDTO(result, true);
	}
	
	public TransactionStatusDTO withdraw(String accountId,float amount,float accountBalance) {
		boolean isAllowed=true;
		FinancialTransactions financialTransactions=new FinancialTransactions();
		RefTransactionStatus refTransactionStatus=new RefTransactionStatus();
		RefTransactionTypes refTransactionTypes=new RefTransactionTypes();
		if(isAllowed) {
			refTransactionStatus.setTransactionStatusCode("SUCCESS");
			refTransactionTypes.setTransactionTypeCode("WITHDRAW");
			financialTransactions.setAccountId(accountId);
			financialTransactions.setAmountOfTransaction(amount);
			financialTransactions.setDateOfTransaction(LocalDateTime.now());
			financialTransactions.setRefTransactionStatus(refTransactionStatus);
			financialTransactions.setRefTransactionTypes(refTransactionTypes);
			financialTransactions.setClosingBalance(accountBalance-amount);
			FinancialTransactions result=transactionRepositry.saveAndFlush(financialTransactions);
			return ConvertToDTO.convertToTransactionDTO(result, true);
		}
		else {
			refTransactionStatus.setTransactionStatusCode("FAILURE");
			refTransactionTypes.setTransactionTypeCode("WITHDRAW");
			financialTransactions.setAccountId(accountId);
			financialTransactions.setAmountOfTransaction(amount);
			financialTransactions.setDateOfTransaction(LocalDateTime.now());
			financialTransactions.setRefTransactionStatus(refTransactionStatus);
			financialTransactions.setRefTransactionTypes(refTransactionTypes);
			financialTransactions.setClosingBalance(accountBalance);
			FinancialTransactions result=transactionRepositry.saveAndFlush(financialTransactions);
			return ConvertToDTO.convertToTransactionDTO(result, false);
		}
		
	}
	
	public List<FinancialTransactions> getAllTransactions(String customerId){
		List<String> accounts=new ArrayList<>();
		Sort sort=Sort.by("accountId").ascending();
		accounts.add("2000220xc");
		accounts.add("2000220xd");
		return transactionRepositry.findAllByAccountIdIn(accounts,sort);
	}
	
	public TransactionStatusDTO transfer(String sourceAccountId,String targetAccountId,float amount,float accountBalance) {
		boolean isAllowed=true;
		FinancialTransactions financialTransactions=new FinancialTransactions();
		RefTransactionStatus refTransactionStatus=new RefTransactionStatus();
		RefTransactionTypes refTransactionTypes=new RefTransactionTypes();
		if(isAllowed) {
			refTransactionStatus.setTransactionStatusCode("SUCCESS");
			refTransactionTypes.setTransactionTypeCode("TRANSFER");
			financialTransactions.setAccountId(sourceAccountId);
			financialTransactions.setRecieverAccountId(targetAccountId);
			financialTransactions.setAmountOfTransaction(amount);
			financialTransactions.setDateOfTransaction(LocalDateTime.now());
			financialTransactions.setRefTransactionStatus(refTransactionStatus);
			financialTransactions.setRefTransactionTypes(refTransactionTypes);
			financialTransactions.setClosingBalance(accountBalance-amount);
			FinancialTransactions result=transactionRepositry.saveAndFlush(financialTransactions);
			return ConvertToDTO.convertToTransactionDTO(result, true);
		}
		else {
			refTransactionStatus.setTransactionStatusCode("FAILURE");
			refTransactionTypes.setTransactionTypeCode("TRANSFER");
			financialTransactions.setAccountId(sourceAccountId);
			financialTransactions.setRecieverAccountId(targetAccountId);
			financialTransactions.setAmountOfTransaction(amount);
			financialTransactions.setDateOfTransaction(LocalDateTime.now());
			financialTransactions.setRefTransactionStatus(refTransactionStatus);
			financialTransactions.setRefTransactionTypes(refTransactionTypes);
			financialTransactions.setClosingBalance(accountBalance);
			FinancialTransactions result=transactionRepositry.saveAndFlush(financialTransactions);
			return ConvertToDTO.convertToTransactionDTO(result, false);
		}
	}
	
	public List<TransactionStatusDTO> getAccountStatement(String accountID,String fromDate,String toDate) {
		
		List<FinancialTransactions> statementList;
		if(fromDate.length()<1) {
			statementList=transactionRepositry.findAllByMonth();
		}
		else {
			statementList=transactionRepositry.findAllByDateOfTransactionBetween(fromDate, toDate);
		}
		List<TransactionStatusDTO> accountStatement=statementList.stream().map(x -> {
			return ConvertToDTO.convertToTransactionDTO(x, true);
		}).collect(Collectors.toList());
		return accountStatement;
	}
	
	
}
