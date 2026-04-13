import { motion } from "motion/react";
import { TrendingUp, Briefcase, DollarSign, Gift } from "lucide-react";

export function IncomeScreen() {
  const incomes = [
    { id: 1, name: "Freelance Project", amount: 850.00, source: "Work", icon: Briefcase, date: "Apr 10, 2026" },
    { id: 2, name: "Monthly Salary", amount: 3200.00, source: "Work", icon: DollarSign, date: "Apr 1, 2026" },
    { id: 3, name: "Gift from Family", amount: 100.00, source: "Other", icon: Gift, date: "Mar 28, 2026" },
    { id: 4, name: "Side Project", amount: 450.00, source: "Work", icon: Briefcase, date: "Mar 25, 2026" },
  ];

  return (
    <div className="flex-1 overflow-y-auto pb-24">
      <div className="px-6 pt-8 pb-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <h1 className="mb-6">Income</h1>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.1 }}
          className="relative overflow-hidden rounded-2xl p-6 mb-6"
          style={{
            background: "linear-gradient(135deg, rgba(16, 185, 129, 0.2) 0%, rgba(16, 185, 129, 0.1) 100%)",
            backdropFilter: "blur(10px)",
            border: "1px solid rgba(255, 255, 255, 0.08)",
          }}
        >
          <div className="flex items-center gap-3 mb-2">
            <div className="w-10 h-10 rounded-xl bg-success/20 flex items-center justify-center">
              <TrendingUp className="w-5 h-5 text-success" />
            </div>
            <span className="text-sm text-muted-foreground">Total Income</span>
          </div>
          <div className="flex items-baseline gap-2">
            <span className="text-4xl font-bold">$4,600</span>
            <span className="text-sm text-muted-foreground">this month</span>
          </div>
          <div className="mt-4 flex items-center gap-2">
            <div className="flex-1 h-2 bg-black/20 rounded-full overflow-hidden">
              <motion.div
                initial={{ width: 0 }}
                animate={{ width: "75%" }}
                transition={{ duration: 1, delay: 0.5 }}
                className="h-full bg-success rounded-full"
              />
            </div>
            <span className="text-sm text-muted-foreground">75% of goal</span>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="space-y-3"
        >
          {incomes.map((income, index) => {
            const Icon = income.icon;
            return (
              <motion.div
                key={income.id}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.3, delay: 0.3 + index * 0.1 }}
                whileHover={{ scale: 1.02 }}
                className="flex items-center justify-between p-4 rounded-2xl bg-card border border-border"
              >
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 rounded-xl bg-success/10 flex items-center justify-center">
                    <Icon className="w-6 h-6 text-success" />
                  </div>
                  <div>
                    <p className="font-medium">{income.name}</p>
                    <p className="text-sm text-muted-foreground">{income.date}</p>
                  </div>
                </div>
                <div className="text-right">
                  <p className="font-bold text-success text-lg">+${income.amount}</p>
                  <p className="text-xs text-muted-foreground">{income.source}</p>
                </div>
              </motion.div>
            );
          })}
        </motion.div>
      </div>
    </div>
  );
}
