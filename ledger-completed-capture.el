  (setq ledger-expense-completions
        (list
         "" ;; needed for first | for mapconcat
         "Income:Savings"
         "Income:Salary"
         "Assets:Cash" "Assets:Bank"
         "Expenses:Food" "Expenses:Food:Restraunts" "Expenses:Food:Groceries" "Expenses:Food:Sweets" "Expenses:Food:FastFood" "Expenses:Flat:Rent" "Expenses:Flat:Utilities" "Expenses:Outfit:Apparel" "Expenses:Outfit:Accessories" "Expenses:Goods" "Expenses:Electronics:Gadgets" "Expenses:Electronics:Toys" "Expenses:Electronics:Parts" "Expenses:Telecom:Internet" "Expenses:Telecom:Phone" "Expenses:Tools" "Expenses:Transport" "Expenses:Services" "Expenses:Entertainment" "Expenses:Dog" "Expenses:Dog:Food" "Expenses:Dog:Treatement" "Expenses:Dog:Medicine" "Expenses:Moto" "Expenses:Moto:Gas" "Expenses:Moto:Servicing" "Expenses:Moto:Expendables" "Expenses:Moto:Parts"
         ))
  
  (setq capture-expense-template
        "%%(org-read-date)  %%^{What}
      Expenses:%%^{Expense%s}  %%^{Amount}
      Account:Cash")
  
(defun return-capture-expense-template ()
  (let ((compstring
         (mapconcat 'identity ledger-expense-completions  "|" )))
    (format capture-expense-template compstring)))

(setq org-capture-templates nil)
(setq org-capture-templates
        (append '(("l" "Ledger entries")
                  ("lc" "Cash" plain
                  (file "~/org/stat/expenses.ldg")
                  (function return-capture-expense-template)
                  :empty-lines-before 1
                  :empty-lines-after 1))
                org-capture-templates))
