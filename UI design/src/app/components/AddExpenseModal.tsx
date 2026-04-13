import { motion, AnimatePresence } from "motion/react";
import { useState } from "react";
import { X, ShoppingBag, Coffee, Car, Home, Heart, Smartphone } from "lucide-react";

interface AddExpenseModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export function AddExpenseModal({ isOpen, onClose }: AddExpenseModalProps) {
  const [amount, setAmount] = useState("");
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);

  const categories = [
    { id: "food", name: "Food", icon: Coffee, color: "#F59E0B" },
    { id: "shopping", name: "Shopping", icon: ShoppingBag, color: "#EC4899" },
    { id: "transport", name: "Transport", icon: Car, color: "#6366F1" },
    { id: "housing", name: "Housing", icon: Home, color: "#8B5CF6" },
    { id: "health", name: "Health", icon: Heart, color: "#10B981" },
    { id: "tech", name: "Tech", icon: Smartphone, color: "#3B82F6" },
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
                <h2>Add Expense</h2>
                <button
                  onClick={onClose}
                  className="w-10 h-10 rounded-xl bg-secondary flex items-center justify-center"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>

              <div className="mb-8">
                <label className="text-sm text-muted-foreground mb-2 block">Amount</label>
                <div className="relative">
                  <span className="absolute left-4 top-1/2 -translate-y-1/2 text-4xl font-bold text-muted-foreground">$</span>
                  <input
                    type="number"
                    value={amount}
                    onChange={(e) => setAmount(e.target.value)}
                    placeholder="0.00"
                    className="w-full bg-secondary border-2 border-border rounded-2xl pl-12 pr-4 py-6 text-4xl font-bold focus:border-primary outline-none transition-colors"
                  />
                </div>
              </div>

              <div className="mb-8">
                <label className="text-sm text-muted-foreground mb-3 block">Category</label>
                <div className="grid grid-cols-3 gap-3">
                  {categories.map((category) => {
                    const Icon = category.icon;
                    return (
                      <motion.button
                        key={category.id}
                        whileHover={{ scale: 1.05 }}
                        whileTap={{ scale: 0.95 }}
                        onClick={() => setSelectedCategory(category.id)}
                        className={`p-4 rounded-2xl border-2 transition-all ${
                          selectedCategory === category.id
                            ? "border-primary bg-primary/10"
                            : "border-border bg-secondary"
                        }`}
                      >
                        <Icon
                          className="w-8 h-8 mx-auto mb-2"
                          style={{ color: selectedCategory === category.id ? category.color : "#A0A0A0" }}
                        />
                        <p className="text-xs">{category.name}</p>
                      </motion.button>
                    );
                  })}
                </div>
              </div>

              <div className="mb-6">
                <label className="text-sm text-muted-foreground mb-2 block">Notes (Optional)</label>
                <textarea
                  placeholder="Add a note..."
                  className="w-full bg-secondary border-2 border-border rounded-2xl px-4 py-3 focus:border-primary outline-none transition-colors resize-none"
                  rows={3}
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
                Add Expense
              </motion.button>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
