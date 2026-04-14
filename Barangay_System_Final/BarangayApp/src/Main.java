import java.awt.*;
import java.net.URL;
import javax.swing.*;

public class Main {

    public static void main(String[] args) {
        // Gagamit ng System Look and Feel para sigurado na mag-run kahit walang FlatLaf JAR
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }

        JFrame frame = new JFrame("Barangay San Marino Information System");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(1100, 700);
        frame.setLayout(new BorderLayout());

        // =========================
        // 🌐 TOP NAVIGATION BAR
        // =========================
        JPanel topNav = new JPanel(new BorderLayout());
        topNav.setPreferredSize(new Dimension(0, 70));
        topNav.setBackground(new Color(30, 58, 138)); 

        JLabel brand = new JLabel("  SAN MARINO PORTAL");
        brand.setForeground(Color.WHITE);
        brand.setFont(new Font("Segoe UI", Font.BOLD, 22));
        topNav.add(brand, BorderLayout.WEST);

        JPanel menuPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 15, 20));
        menuPanel.setOpaque(false);

        String[] menuItems = {"Home", "Residents", "Complaints", "Announcements", "Documents"};

        for (String item : menuItems) {
            JButton btn = new JButton(item);
            btn.setFont(new Font("Segoe UI", Font.PLAIN, 14));
            btn.setForeground(Color.WHITE);
            btn.setContentAreaFilled(false);
            btn.setBorderPainted(false);
            btn.setFocusPainted(false);
            btn.setCursor(new Cursor(Cursor.HAND_CURSOR));

            // ✅ CLICKABLE FEATURE
            btn.addActionListener(e -> JOptionPane.showMessageDialog(frame, "Opening " + item + "..."));

            menuPanel.add(btn);
        }

        // 🔴 LOGOUT BUTTON WITH CONFIRMATION
        JButton logout = new JButton("Logout");
        logout.setFont(new Font("Segoe UI", Font.BOLD, 13));
        logout.setForeground(Color.WHITE);
        logout.setBackground(new Color(239, 68, 68));
        logout.setFocusPainted(false);

        logout.addActionListener(e -> {
            int confirm = JOptionPane.showConfirmDialog(frame, 
                "Are you sure you want to logout?", "Confirmation", 
                JOptionPane.YES_NO_OPTION);
            if (confirm == JOptionPane.YES_OPTION) {
                frame.dispose();
            }
        });

        menuPanel.add(logout);
        topNav.add(menuPanel, BorderLayout.EAST);

        // =========================
        // 📜 MAIN CONTENT
        // =========================
        JPanel content = new JPanel();
        content.setLayout(new BoxLayout(content, BoxLayout.Y_AXIS));
        content.setBackground(new Color(241, 245, 249));

        content.add(createHero());
        content.add(Box.createVerticalStrut(20));
        content.add(createCard("BARANGAY MISSION", "To provide excellent public service..."));
        content.add(Box.createVerticalStrut(10));
        content.add(createCard("BARANGAY VISION", "A safe and progressive community..."));

        JScrollPane scroll = new JScrollPane(content);
        scroll.setBorder(null);

        frame.add(topNav, BorderLayout.NORTH);
        frame.add(scroll, BorderLayout.CENTER);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }

    private static JPanel createHero() {
        JLayeredPane layer = new JLayeredPane();
        layer.setPreferredSize(new Dimension(1100, 350));

        JLabel bg = new JLabel();
        // Siguraduhin na ang image file ay nasa parehong folder ng Main.java
        String imgName = "cityscape-with-buildings-background-v_1405776jpg!sw800.jpg";
        URL imgURL = Main.class.getResource("/" + imgName);

        if (imgURL != null) {
            bg.setIcon(new ImageIcon(new ImageIcon(imgURL).getImage()
                .getScaledInstance(1100, 350, Image.SCALE_SMOOTH)));
        } else {
            bg.setBackground(new Color(45, 67, 120));
            bg.setOpaque(true);
        }
        bg.setBounds(0, 0, 1100, 350);

        JPanel overlay = new JPanel();
        overlay.setBackground(new Color(0, 0, 0, 120));
        overlay.setBounds(0, 0, 1100, 350);

        JLabel title = new JLabel("WELCOME TO SAN MARINO", SwingConstants.CENTER);
        title.setFont(new Font("Segoe UI", Font.BOLD, 40));
        title.setForeground(Color.WHITE);
        title.setBounds(0, 130, 1100, 50);

        layer.add(bg, JLayeredPane.DEFAULT_LAYER);
        layer.add(overlay, JLayeredPane.PALETTE_LAYER);
        layer.add(title, JLayeredPane.MODAL_LAYER);

        JPanel wrapper = new JPanel(new BorderLayout());
        wrapper.add(layer);
        return wrapper;
    }

    private static JPanel createCard(String title, String text) {
        JPanel card = new JPanel(new BorderLayout());
        card.setBackground(Color.WHITE);
        card.setMaximumSize(new Dimension(900, 120));
        card.setBorder(BorderFactory.createEmptyBorder(15, 20, 15, 20));
        card.setAlignmentX(Component.CENTER_ALIGNMENT);

        JLabel t = new JLabel(title);
        t.setFont(new Font("Segoe UI", Font.BOLD, 18));
        JLabel d = new JLabel(text);

        card.add(t, BorderLayout.NORTH);
        card.add(d, BorderLayout.CENTER);
        return card;
    }
}