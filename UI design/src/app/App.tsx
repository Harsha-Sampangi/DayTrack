import { useState } from "react";
import { motion, AnimatePresence } from "motion/react";
import { Dashboard } from "./components/Dashboard";
import { ExpenseScreen } from "./components/ExpenseScreen";
import { TaskScreen } from "./components/TaskScreen";
import { IncomeScreen } from "./components/IncomeScreen";
import { AnalyticsScreen } from "./components/AnalyticsScreen";
import { SettingsScreen } from "./components/SettingsScreen";
import { BottomNav } from "./components/BottomNav";
import { AddExpenseModal } from "./components/AddExpenseModal";
import { AddTaskModal } from "./components/AddTaskModal";

export default function App() {
  const [activeTab, setActiveTab] = useState("home");
  const [isExpenseModalOpen, setIsExpenseModalOpen] = useState(false);
  const [isTaskModalOpen, setIsTaskModalOpen] = useState(false);

  const renderScreen = () => {
    switch (activeTab) {
      case "home":
        return (
          <Dashboard
            onAddExpense={() => setIsExpenseModalOpen(true)}
            onAddTask={() => setIsTaskModalOpen(true)}
          />
        );
      case "expenses":
        return <ExpenseScreen onAddExpense={() => setIsExpenseModalOpen(true)} />;
      case "tasks":
        return <TaskScreen onAddTask={() => setIsTaskModalOpen(true)} />;
      case "income":
        return <IncomeScreen />;
      case "analytics":
        return <AnalyticsScreen />;
      case "settings":
        return <SettingsScreen />;
      default:
        return (
          <Dashboard
            onAddExpense={() => setIsExpenseModalOpen(true)}
            onAddTask={() => setIsTaskModalOpen(true)}
          />
        );
    }
  };

  return (
    <div className="h-screen w-full bg-background text-foreground overflow-hidden">
      <div className="max-w-md mx-auto h-full flex flex-col relative">
        <AnimatePresence mode="wait">
          <motion.div
            key={activeTab}
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -20 }}
            transition={{ duration: 0.2 }}
            className="flex-1 overflow-hidden"
          >
            {renderScreen()}
          </motion.div>
        </AnimatePresence>

        <BottomNav activeTab={activeTab} onTabChange={setActiveTab} />

        <AddExpenseModal
          isOpen={isExpenseModalOpen}
          onClose={() => setIsExpenseModalOpen(false)}
        />

        <AddTaskModal
          isOpen={isTaskModalOpen}
          onClose={() => setIsTaskModalOpen(false)}
        />
      </div>
    </div>
  );
}
