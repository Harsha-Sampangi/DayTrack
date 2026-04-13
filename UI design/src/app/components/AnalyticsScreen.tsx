import { motion } from "motion/react";
import { PieChart, Pie, Cell, BarChart, Bar, XAxis, YAxis, ResponsiveContainer } from "recharts";

export function AnalyticsScreen() {
  const categoryData = [
    { name: "Food", value: 420, color: "#F59E0B" },
    { name: "Transport", value: 180, color: "#6366F1" },
    { name: "Housing", value: 850, color: "#8B5CF6" },
    { name: "Shopping", value: 210, color: "#EC4899" },
    { name: "Health", value: 95, color: "#10B981" },
  ];

  const weeklyData = [
    { day: "Mon", amount: 45 },
    { day: "Tue", amount: 78 },
    { day: "Wed", amount: 35 },
    { day: "Thu", amount: 92 },
    { day: "Fri", amount: 65 },
    { day: "Sat", amount: 120 },
    { day: "Sun", amount: 48 },
  ];

  const total = categoryData.reduce((sum, item) => sum + item.value, 0);

  return (
    <div className="flex-1 overflow-y-auto pb-24">
      <div className="px-6 pt-8 pb-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <h1 className="mb-6">Analytics</h1>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.1 }}
          className="relative overflow-hidden rounded-2xl p-6 mb-6"
          style={{
            background: "linear-gradient(135deg, rgba(99, 102, 241, 0.15) 0%, rgba(139, 92, 246, 0.15) 100%)",
            backdropFilter: "blur(10px)",
            border: "1px solid rgba(255, 255, 255, 0.08)",
          }}
        >
          <h3 className="mb-4">Spending by Category</h3>
          <div className="flex items-center justify-center mb-6">
            <div className="relative w-[200px] h-[200px]">
              <PieChart width={200} height={200}>
                <Pie
                  data={categoryData}
                  cx={100}
                  cy={100}
                  innerRadius={60}
                  outerRadius={80}
                  paddingAngle={4}
                  dataKey="value"
                >
                  {categoryData.map((entry) => (
                    <Cell key={`pie-${entry.name}`} fill={entry.color} />
                  ))}
                </Pie>
              </PieChart>
              <div className="absolute inset-0 flex items-center justify-center">
                <div className="text-center">
                  <p className="text-2xl font-bold">${total}</p>
                  <p className="text-xs text-muted-foreground">Total</p>
                </div>
              </div>
            </div>
          </div>
          <div className="space-y-2">
            {categoryData.map((category, index) => (
              <motion.div
                key={category.name}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.3, delay: 0.3 + index * 0.1 }}
                className="flex items-center justify-between"
              >
                <div className="flex items-center gap-2">
                  <div
                    className="w-3 h-3 rounded-full"
                    style={{
                      background: category.color,
                      boxShadow: `0 0 8px ${category.color}60`,
                    }}
                  />
                  <span className="text-sm">{category.name}</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-sm font-medium">${category.value}</span>
                  <span className="text-xs text-muted-foreground">
                    {Math.round((category.value / total) * 100)}%
                  </span>
                </div>
              </motion.div>
            ))}
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.4 }}
          className="relative overflow-hidden rounded-2xl p-6"
          style={{
            background: "linear-gradient(135deg, rgba(99, 102, 241, 0.15) 0%, rgba(139, 92, 246, 0.15) 100%)",
            backdropFilter: "blur(10px)",
            border: "1px solid rgba(255, 255, 255, 0.08)",
          }}
        >
          <h3 className="mb-4">Weekly Spending</h3>
          <ResponsiveContainer width="100%" height={200}>
            <BarChart data={weeklyData}>
              <defs>
                <linearGradient id="weeklyBarGradient" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="0%" stopColor="#6366F1" stopOpacity={0.8} />
                  <stop offset="100%" stopColor="#8B5CF6" stopOpacity={0.8} />
                </linearGradient>
              </defs>
              <XAxis
                dataKey="day"
                stroke="#A0A0A0"
                fontSize={12}
                tickLine={false}
                axisLine={false}
              />
              <YAxis
                stroke="#A0A0A0"
                fontSize={12}
                tickLine={false}
                axisLine={false}
                tickFormatter={(value) => `$${value}`}
              />
              <Bar dataKey="amount" radius={[8, 8, 0, 0]} fill="url(#weeklyBarGradient)" />
            </BarChart>
          </ResponsiveContainer>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.5 }}
          className="grid grid-cols-2 gap-3 mt-6"
        >
          <div className="p-4 rounded-2xl bg-card border border-border">
            <p className="text-sm text-muted-foreground mb-1">Avg Daily</p>
            <p className="text-2xl font-bold">$68</p>
            <p className="text-xs text-success mt-1">↓ 12% vs last week</p>
          </div>
          <div className="p-4 rounded-2xl bg-card border border-border">
            <p className="text-sm text-muted-foreground mb-1">Saved</p>
            <p className="text-2xl font-bold">$1,240</p>
            <p className="text-xs text-success mt-1">↑ 8% vs last month</p>
          </div>
        </motion.div>
      </div>
    </div>
  );
}
