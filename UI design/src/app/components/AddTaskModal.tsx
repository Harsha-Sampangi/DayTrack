import { motion, AnimatePresence } from "motion/react";
import { useState } from "react";
import { X } from "lucide-react";

interface AddTaskModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export function AddTaskModal({ isOpen, onClose }: AddTaskModalProps) {
  const [title, setTitle] = useState("");
  const [selectedPriority, setSelectedPriority] = useState("medium");
  const [selectedTime, setSelectedTime] = useState("09:00");

  const priorities = [
    { id: "low", name: "Low", color: "#10B981" },
    { id: "medium", name: "Medium", color: "#F59E0B" },
    { id: "high", name: "High", color: "#EF4444" },
  ];

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="fixed inset-0 bg-black/60 backdrop-blur-sm z-40"
          />
          <motion.div
            initial={{ y: "100%" }}
            animate={{ y: 0 }}
            exit={{ y: "100%" }}
            transition={{ type: "spring", damping: 30, stiffness: 300 }}
            className="fixed bottom-0 left-0 right-0 z-50 bg-card rounded-t-3xl border-t border-border max-h-[85vh] overflow-y-auto"
          >
            <div className="p-6">
              <div className="flex items-center justify-between mb-6">
                <h2>Add Task</h2>
                <button
                  onClick={onClose}
                  className="w-10 h-10 rounded-xl bg-secondary flex items-center justify-center"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>

              <div className="mb-6">
                <label className="text-sm text-muted-foreground mb-2 block">Task Title</label>
                <input
                  type="text"
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  placeholder="What needs to be done?"
                  className="w-full bg-secondary border-2 border-border rounded-2xl px-4 py-4 text-lg focus:border-primary outline-none transition-colors"
                />
              </div>

              <div className="mb-6">
                <label className="text-sm text-muted-foreground mb-3 block">Priority</label>
                <div className="flex gap-3">
                  {priorities.map((priority) => (
                    <motion.button
                      key={priority.id}
                      whileHover={{ scale: 1.05 }}
                      whileTap={{ scale: 0.95 }}
                      onClick={() => setSelectedPriority(priority.id)}
                      className={`flex-1 p-4 rounded-2xl border-2 transition-all ${
                        selectedPriority === priority.id
                          ? "border-primary bg-primary/10"
                          : "border-border bg-secondary"
                      }`}
                    >
                      <div
                        className="w-3 h-3 rounded-full mx-auto mb-2"
                        style={{
                          background: priority.color,
                          boxShadow: `0 0 12px ${priority.color}60`,
                        }}
                      />
                      <p className="text-sm">{priority.name}</p>
                    </motion.button>
                  ))}
                </div>
              </div>

              <div className="mb-6">
                <label className="text-sm text-muted-foreground mb-2 block">Time</label>
                <input
                  type="time"
                  value={selectedTime}
                  onChange={(e) => setSelectedTime(e.target.value)}
                  className="w-full bg-secondary border-2 border-border rounded-2xl px-4 py-4 text-lg focus:border-primary outline-none transition-colors"
                />
              </div>

              <motion.button
                whileHover={{ scale: 1.02 }}
                whileTap={{ scale: 0.98 }}
                className="w-full py-4 rounded-2xl font-medium text-white"
                style={{
                  background: "linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%)",
                  boxShadow: "0 8px 32px rgba(99, 102, 241, 0.4)",
                }}
              >
                Add Task
              </motion.button>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
