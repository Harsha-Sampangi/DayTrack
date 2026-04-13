import { motion } from "motion/react";
import { Plus, TrendingUp, TrendingDown, Wallet } from "lucide-react";

interface DashboardProps {
  onAddExpense: () => void;
  onAddTask: () => void;
}

export function Dashboard({ onAddExpense, onAddTask }: DashboardProps) {
  const transactions = [
    { id: 1, name: "Groceries", amount: 45.50, category: "Food", time: "2h ago" },
    { id: 2, name: "Coffee", amount: 5.20, category: "Food", time: "4h ago" },
    { id: 3, name: "Transport", amount: 12.00, category: "Travel", time: "6h ago" },
  ];

  const tasks = [
    { id: 1, title: "Review budget", completed: false },
    { id: 2, title: "Pay electricity bill", completed: false },
    { id: 3, title: "Submit expense report", completed: true },
  ];

  return (
    <div className="flex-1 overflow-y-auto pb-24">
      <div className="px-6 pt-8 pb-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <h1 className="mb-1">Welcome back</h1>
          <p className="text-muted-foreground">Monday, April 13, 2026</p>
        </motion.div>

        <div className="grid grid-cols-2 gap-3 mt-6">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.1 }}
            className="relative overflow-hidden rounded-2xl p-5"
            style={{
              background: "linear-gradient(135deg, rgba(239, 68, 68, 0.15) 0%, rgba(239, 68, 68, 0.05) 100%)",
              backdropFilter: "blur(10px)",
              border: "1px solid rgba(255, 255, 255, 0.08)",
            }}
          >
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm text-muted-foreground">Today's Expense</span>
              <TrendingDown className="w-4 h-4 text-destructive" />
            </div>
            <div className="flex items-baseline gap-1">
              <span className="text-3xl font-bold">$62.70</span>
            </div>
            <div className="mt-2 h-1.5 bg-black/20 rounded-full overflow-hidden">
              <motion.div
                initial={{ width: 0 }}
                animate={{ width: "62%" }}
                transition={{ duration: 1, delay: 0.5 }}
                className="h-full bg-destructive rounded-full"
              />
            </div>
            <p className="text-xs text-muted-foreground mt-1.5">62% of daily budget</p>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="relative overflow-hidden rounded-2xl p-5"
            style={{
              background: "linear-gradient(135deg, rgba(16, 185, 129, 0.15) 0%, rgba(16, 185, 129, 0.05) 100%)",
              backdropFilter: "blur(10px)",
              border: "1px solid rgba(255, 255, 255, 0.08)",
            }}
          >
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm text-muted-foreground">Today's Income</span>
              <TrendingUp className="w-4 h-4 text-success" />
            </div>
            <div className="flex items-baseline gap-1">
              <span className="text-3xl font-bold">$120</span>
            </div>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.3 }}
            className="col-span-2 relative overflow-hidden rounded-2xl p-5"
            style={{
              background: "linear-gradient(135deg, rgba(99, 102, 241, 0.15) 0%, rgba(139, 92, 246, 0.15) 100%)",
              backdropFilter: "blur(10px)",
              border: "1px solid rgba(255, 255, 255, 0.08)",
            }}
          >
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm text-muted-foreground">Balance</span>
              <Wallet className="w-4 h-4 text-primary" />
            </div>
            <div className="flex items-baseline gap-1">
              <span className="text-3xl font-bold">$57.30</span>
              <span className="text-sm text-success">+92%</span>
            </div>
          </motion.div>
        </div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.4 }}
          className="mt-6"
        >
          <div className="flex items-center justify-between mb-4">
            <h3>Recent Transactions</h3>
            <button className="text-sm text-primary">See all</button>
          </div>
          <div className="space-y-2">
            {transactions.map((transaction, index) => (
              <motion.div
                key={transaction.id}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.3, delay: 0.5 + index * 0.1 }}
                className="flex items-center justify-between p-4 rounded-xl bg-card border border-border"
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-xl bg-primary/10 flex items-center justify-center">
                    <span className="text-lg">🛒</span>
                  </div>
                  <div>
                    <p className="font-medium">{transaction.name}</p>
                    <p className="text-sm text-muted-foreground">{transaction.time}</p>
                  </div>
                </div>
                <span className="font-bold text-destructive">-${transaction.amount}</span>
              </motion.div>
            ))}
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.7 }}
          className="mt-6"
        >
          <div className="flex items-center justify-between mb-4">
            <h3>Today's Tasks</h3>
            <span className="text-sm text-muted-foreground">1/3</span>
          </div>
          <div className="space-y-2">
            {tasks.map((task, index) => (
              <motion.div
                key={task.id}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.3, delay: 0.8 + index * 0.1 }}
                className="flex items-center gap-3 p-4 rounded-xl bg-card border border-border"
              >
                <div className={`w-5 h-5 rounded-lg border-2 flex items-center justify-center ${task.completed ? 'bg-primary border-primary' : 'border-muted-foreground'}`}>
                  {task.completed && <span className="text-xs">✓</span>}
                </div>
                <p className={task.completed ? 'text-muted-foreground line-through' : ''}>{task.title}</p>
              </motion.div>
            ))}
          </div>
        </motion.div>
      </div>

      <motion.button
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
        onClick={onAddExpense}
        className="fixed bottom-28 right-6 w-14 h-14 rounded-2xl flex items-center justify-center shadow-lg"
        style={{
          background: "linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%)",
          boxShadow: "0 8px 32px rgba(99, 102, 241, 0.4)",
        }}
      >
        <Plus className="w-6 h-6" />
      </motion.button>
    </div>
  );
}
