import { motion } from "motion/react";
import { useState } from "react";
import { ShoppingBag, Coffee, Car, Home, TrendingDown } from "lucide-react";

interface ExpenseScreenProps {
  onAddExpense: () => void;
}

export function ExpenseScreen({ onAddExpense }: ExpenseScreenProps) {
  const [activeFilter, setActiveFilter] = useState("Daily");

  const expenses = [
    { id: 1, name: "Groceries", amount: 45.50, category: "Food", icon: ShoppingBag, date: "Today, 2:30 PM" },
    { id: 2, name: "Coffee", amount: 5.20, category: "Food", icon: Coffee, date: "Today, 10:15 AM" },
    { id: 3, name: "Transport", amount: 12.00, category: "Travel", icon: Car, date: "Today, 8:00 AM" },
    { id: 4, name: "Rent Payment", amount: 850.00, category: "Housing", icon: Home, date: "Yesterday" },
    { id: 5, name: "Restaurant", amount: 34.80, category: "Food", icon: Coffee, date: "Yesterday" },
  ];

  return (
    <div className="flex-1 overflow-y-auto pb-24">
      <div className="px-6 pt-8 pb-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <h1 className="mb-6">Expenses</h1>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.1 }}
          className="relative overflow-hidden rounded-2xl p-6 mb-6"
          style={{
            background: "linear-gradient(135deg, rgba(239, 68, 68, 0.2) 0%, rgba(239, 68, 68, 0.1) 100%)",
            backdropFilter: "blur(10px)",
            border: "1px solid rgba(255, 255, 255, 0.08)",
          }}
        >
          <div className="flex items-center gap-3 mb-2">
            <div className="w-10 h-10 rounded-xl bg-destructive/20 flex items-center justify-center">
              <TrendingDown className="w-5 h-5 text-destructive" />
            </div>
            <span className="text-sm text-muted-foreground">Total Spending</span>
          </div>
          <div className="flex items-baseline gap-2">
            <span className="text-4xl font-bold">$947.50</span>
            <span className="text-sm text-muted-foreground">this month</span>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="flex gap-2 mb-6"
        >
          {["Daily", "Weekly", "Monthly"].map((filter) => (
            <button
              key={filter}
              onClick={() => setActiveFilter(filter)}
              className={`px-4 py-2 rounded-xl transition-all ${
                activeFilter === filter
                  ? "bg-primary text-white"
                  : "bg-card border border-border text-muted-foreground"
              }`}
            >
              {filter}
            </button>
          ))}
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.3 }}
          className="space-y-3"
        >
          {expenses.map((expense, index) => {
            const Icon = expense.icon;
            return (
              <motion.div
                key={expense.id}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.3, delay: 0.4 + index * 0.1 }}
                whileHover={{ scale: 1.02 }}
                className="flex items-center justify-between p-4 rounded-2xl bg-card border border-border"
              >
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 rounded-xl bg-primary/10 flex items-center justify-center">
                    <Icon className="w-6 h-6 text-primary" />
                  </div>
                  <div>
                    <p className="font-medium">{expense.name}</p>
                    <p className="text-sm text-muted-foreground">{expense.date}</p>
                  </div>
                </div>
                <div className="text-right">
                  <p className="font-bold text-destructive text-lg">-${expense.amount}</p>
                  <p className="text-xs text-muted-foreground">{expense.category}</p>
                </div>
              </motion.div>
            );
          })}
        </motion.div>
      </div>
    </div>
  );
}
