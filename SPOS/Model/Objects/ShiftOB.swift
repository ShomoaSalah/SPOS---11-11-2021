//
//  ShiftOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/3/21.
//

import Foundation

class ShiftOB: Codable {
    
    let shift: Shift?
    let cashDrawer: CashDrawer?
    let salesSummary: SalesSummary?

    enum CodingKeys: String, CodingKey {
        case shift
        case cashDrawer = "cash_drawer"
        case salesSummary = "sales_summary"
    }

    init(shift: Shift?, cashDrawer: CashDrawer?, salesSummary: SalesSummary?) {
        self.shift = shift
        self.cashDrawer = cashDrawer
        self.salesSummary = salesSummary
    }
}


class Shift: Codable {
    let id, shiftNumber: Int?
    let employeeName, openedTimeFormat: String?

    enum CodingKeys: String, CodingKey {
        case id
        case shiftNumber = "shift_number"
        case employeeName = "employee_name"
        case openedTimeFormat = "opened_time_format"
    }

    init(id: Int?, shiftNumber: Int?, employeeName: String?, openedTimeFormat: String?) {
        self.id = id
        self.shiftNumber = shiftNumber
        self.employeeName = employeeName
        self.openedTimeFormat = openedTimeFormat
    }
}


class CashDrawer: Codable {
    let startingCash: String?
    let cashPayment, cashRefunds, paidIn, paidOut: String?
    let expectedCashAmount: String?
    let expectedCashAmountState: Int?

    enum CodingKeys: String, CodingKey {
        case startingCash = "starting_cash"
        case cashPayment = "cash_payment"
        case cashRefunds = "cash_refunds"
        case paidIn = "paid_in"
        case paidOut = "paid_out"
        case expectedCashAmount = "expected_cash_amount"
        case expectedCashAmountState = "expected_cash_amount_state"
    }

    init(startingCash: String?, cashPayment: String?, cashRefunds: String?, paidIn: String?, paidOut: String?, expectedCashAmount: String?, expectedCashAmountState: Int?) {
        self.startingCash = startingCash
        self.cashPayment = cashPayment
        self.cashRefunds = cashRefunds
        self.paidIn = paidIn
        self.paidOut = paidOut
        self.expectedCashAmount = expectedCashAmount
        self.expectedCashAmountState = expectedCashAmountState
    }
}


class SalesSummary: Codable {
    let grossSales, refunds, discounts, netSales: String?
    let taxes, totalTendered: String?

    enum CodingKeys: String, CodingKey {
        case grossSales = "gross_sales"
        case refunds, discounts
        case netSales = "net_sales"
        case taxes
        case totalTendered = "total_tendered"
    }

    init(grossSales: String?, refunds: String?, discounts: String?, netSales: String?, taxes: String?, totalTendered: String?) {
        self.grossSales = grossSales
        self.refunds = refunds
        self.discounts = discounts
        self.netSales = netSales
        self.taxes = taxes
        self.totalTendered = totalTendered
    }
}
