import { motion } from "motion/react";
import { useState } from "react";
import { CheckCircle2, Circle, Plus } from "lucide-react";

interface TaskScreenProps {
  onAddTask: () => void;
}

export function TaskScreen({ onAddTask }: TaskScreenProps) {
  const [tasks, setTasks] = useState([
    { id: 1, title: "Review budget", priority: "high", completed: false, time: "9:00 AM" },
    { id: 2, title: "Pay electricity bill", priority: "high", completed: false, time: "2:00 PM" },
    { id: 3, title: "Submit expense report", priority: "medium", completed: true, time: "4:00 PM" },
    { id: 4, title: "Call insurance company", priority: "low", completed: false, time: "Tomorrow" },
    { id: 5, title: "Update financial goals", priority: "medium", completed: false, time: "Tomorrow" },
  ]);

  const toggleTask = (id: number) => {
    setTasks(tasks.map(task =>
      task.id === id ? { ...task, completed: !task.completed } : task
    ));
  };

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "high": return "#EF4444";
      case "medium": return "#F59E0B";
      case "low": return "#10B981";
      default: return "#6366F1";
    }
  };

  const completedCount = tasks.filter(t => t.completed).length;
  const totalCount = tasks.length;

  return (
    <div className="flex-1 overflow-y-auto pb-24">
      <div className="px-6 pt-8 pb-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <h1 className="mb-6">Tasks</h1>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.1 }}
          className="relative overflow-hidden rounded-2xl p-6 mb-6"
          style={{
            background: "linear-gradient(135deg, rgba(99, 102, 241, 0.2) 0%, rgba(139, 92, 246, 0.2) 100%)",
            backdropFilter: "blur(10px)",
            border: "1px solid rgba(255, 255, 255, 0.08)",
          }}
        >
          <div className="flex items-center justify-between mb-4">
            <div>
              <p className="text-sm text-muted-foreground mb-1">Progress</p>
              <div className="flex items-baseline gap-2">
                <span className="text-4xl font-bold">{completedCount}</span>
                <span className="text-lg text-muted-foreground">/ {totalCount}</span>
              </div>
            </div>
            <div className="relative w-20 h-20">
              <svg className="w-20 h-20 transform -rotate-90">
                <circle
                  cx="40"
                  cy="40"
                  r="36"
                  stroke="rgba(255, 255, 255, 0.1)"
                  strokeWidth="8"
                  fill="none"
                />
                <motion.circle
                  cx="40"
                  cy="40"
                  r="36"
                  stroke="url(#gradient)"
                  strokeWidth="8"
                  fill="none"
                  strokeLinecap="round"
                  initial={{ strokeDasharray: "0 226" }}
                  animate={{ strokeDasharray: `${(completedCount / totalCount) * 226} 226` }}
                  transition={{ duration: 1, delay: 0.5 }}
                />
                <defs>
                  <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" stopColor="#6366F1" />
                    <stop offset="100%" stopColor="#8B5CF6" />
                  </linearGradient>
                </defs>
              </svg>
              <div className="absolute inset-0 flex items-center justify-center">
                <span className="text-lg font-bold">{Math.round((completedCount / totalCount) * 100)}%</span>
              </div>
            </div>
          </div>
        </motion.div>

        <div className="mb-4">
          <h3 className="mb-3">Today</h3>
          <div className="space-y-2">
            {tasks.filter(t => t.time.includes("AM") || t.time.includes("PM")).map((task, index) => (
              <motion.div
                key={task.id}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.3, delay: 0.3 + index * 0.1 }}
                whileHover={{ scale: 1.02 }}
                onClick={() => toggleTask(task.id)}
                className="flex items-center gap-4 p-4 rounded-2xl bg-card border border-border cursor-pointer"
              >
                <motion.div
                  whileTap={{ scale: 0.9 }}
                  className="flex-shrink-0"
                >
                  {task.completed ? (
                    <CheckCircle2 className="w-6 h-6 text-primary" />
                  ) : (
                    <Circle className="w-6 h-6 text-muted-foreground" />
                  )}
                </motion.div>
                <div className="flex-1">
                  <p className={`font-medium ${task.completed ? 'text-muted-foreground line-through' : ''}`}>
                    {task.title}
                  </p>
                  <p className="text-sm text-muted-foreground">{task.time}</p>
                </div>
                <div
                  className="w-1 h-10 rounded-full"
                  style={{
                    background: getPriorityColor(task.priority),
                    boxShadow: `0 0 12px ${getPriorityColor(task.priority)}40`,
                  }}
                />
              </motion.div>
            ))}
          </div>
        </div>

        <div className="mb-4">
          <h3 className="mb-3">Upcoming</h3>
          <div className="space-y-2">
            {tasks.filter(t => t.time === "Tomorrow").map((task, index) => (
              <motion.div
                key={task.id}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.3, delay: 0.6 + index * 0.1 }}
                whileHover={{ scale: 1.02 }}
                onClick={() => toggleTask(task.id)}
                className="flex items-center gap-4 p-4 rounded-2xl bg-card border border-border cursor-pointer"
              >
                <motion.div
                  whileTap={{ scale: 0.9 }}
                  className="flex-shrink-0"
                >
                  {task.completed ? (
                    <CheckCircle2 className="w-6 h-6 text-primary" />
                  ) : (
                    <Circle className="w-6 h-6 text-muted-foreground" />
                  )}
                </motion.div>
                <div className="flex-1">
                  <p className={`font-medium ${task.completed ? 'text-muted-foreground line-through' : ''}`}>
                    {task.title}
                  </p>
                  <p className="text-sm text-muted-foreground">{task.time}</p>
                </div>
                <div
                  className="w-1 h-10 rounded-full"
                  style={{
                    background: getPriorityColor(task.priority),
                    boxShadow: `0 0 12px ${getPriorityColor(task.priority)}40`,
                  }}
                />
              </motion.div>
            ))}
          </div>
        </div>
      </div>

      <motion.button
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
        onClick={onAddTask}
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
