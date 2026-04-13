import { motion } from "motion/react";
import { ChevronRight, Bell, Lock, Palette, Globe, HelpCircle, LogOut } from "lucide-react";

export function SettingsScreen() {
  const settingsGroups = [
    {
      title: "Preferences",
      items: [
        { icon: Bell, label: "Notifications", hasToggle: true, enabled: true },
        { icon: Palette, label: "Appearance", hasArrow: true },
        { icon: Globe, label: "Language", value: "English", hasArrow: true },
      ],
    },
    {
      title: "Security",
      items: [
        { icon: Lock, label: "App Lock", hasToggle: true, enabled: false },
        { icon: Lock, label: "Change Password", hasArrow: true },
      ],
    },
    {
      title: "Support",
      items: [
        { icon: HelpCircle, label: "Help Center", hasArrow: true },
        { icon: LogOut, label: "Sign Out", hasArrow: true, danger: true },
      ],
    },
  ];

  return (
    <div className="flex-1 overflow-y-auto pb-24">
      <div className="px-6 pt-8 pb-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <h1 className="mb-6">Settings</h1>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.1 }}
          className="flex items-center gap-4 p-6 rounded-2xl mb-6"
          style={{
            background: "linear-gradient(135deg, rgba(99, 102, 241, 0.15) 0%, rgba(139, 92, 246, 0.15) 100%)",
            backdropFilter: "blur(10px)",
            border: "1px solid rgba(255, 255, 255, 0.08)",
          }}
        >
          <div className="w-16 h-16 rounded-2xl bg-primary/20 flex items-center justify-center text-2xl">
            👤
          </div>
          <div>
            <h3 className="mb-0.5">John Doe</h3>
            <p className="text-sm text-muted-foreground">john.doe@email.com</p>
          </div>
        </motion.div>

        {settingsGroups.map((group, groupIndex) => (
          <motion.div
            key={group.title}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.2 + groupIndex * 0.1 }}
            className="mb-6"
          >
            <h4 className="text-sm text-muted-foreground mb-3 px-2">{group.title}</h4>
            <div className="space-y-2">
              {group.items.map((item, itemIndex) => {
                const Icon = item.icon;
                return (
                  <motion.div
                    key={item.label}
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 0.3, delay: 0.3 + groupIndex * 0.1 + itemIndex * 0.05 }}
                    whileHover={{ scale: 1.02 }}
                    className="flex items-center justify-between p-4 rounded-2xl bg-card border border-border cursor-pointer"
                  >
                    <div className="flex items-center gap-3">
                      <div className={`w-10 h-10 rounded-xl flex items-center justify-center ${item.danger ? 'bg-destructive/10' : 'bg-primary/10'}`}>
                        <Icon className={`w-5 h-5 ${item.danger ? 'text-destructive' : 'text-primary'}`} />
                      </div>
                      <span className={item.danger ? 'text-destructive' : ''}>{item.label}</span>
                    </div>
                    {item.hasToggle && (
                      <div
                        className={`w-12 h-7 rounded-full p-1 transition-colors cursor-pointer ${
                          item.enabled ? 'bg-primary' : 'bg-secondary'
                        }`}
                      >
                        <motion.div
                          className="w-5 h-5 rounded-full bg-white"
                          animate={{ x: item.enabled ? 20 : 0 }}
                          transition={{ type: "spring", stiffness: 500, damping: 30 }}
                        />
                      </div>
                    )}
                    {item.value && (
                      <div className="flex items-center gap-2">
                        <span className="text-sm text-muted-foreground">{item.value}</span>
                        <ChevronRight className="w-5 h-5 text-muted-foreground" />
                      </div>
                    )}
                    {item.hasArrow && !item.value && (
                      <ChevronRight className="w-5 h-5 text-muted-foreground" />
                    )}
                  </motion.div>
                );
              })}
            </div>
          </motion.div>
        ))}

        <div className="mt-8 text-center text-sm text-muted-foreground">
          <p>Version 1.0.0</p>
        </div>
      </div>
    </div>
  );
}
