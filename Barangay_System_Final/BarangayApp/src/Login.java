import java.awt.*;
import javax.swing.*;

public class Login {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Barangay San Marino - Login");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(400, 300);
        
        // Main Panel with Design
        JPanel panel = new JPanel();
        panel.setLayout(new GridLayout(5, 1, 10, 10));
        panel.setBackground(new Color(44, 62, 80));
        panel.setBorder(BorderFactory.createEmptyBorder(20, 40, 20, 40));

        JLabel lblTitle = new JLabel("USER LOGIN", SwingConstants.CENTER);
        lblTitle.setFont(new Font("Segoe UI", Font.BOLD, 20));
        lblTitle.setForeground(Color.WHITE);

        JTextField txtUser = new JTextField();
        txtUser.setBorder(BorderFactory.createTitledBorder("Username"));

        JPasswordField txtPass = new JPasswordField();
        txtPass.setBorder(BorderFactory.createTitledBorder("Password"));

        JButton btnLogin = new JButton("LOGIN");
        btnLogin.setBackground(new Color(46, 204, 113)); // Green color
        btnLogin.setForeground(Color.WHITE);
        btnLogin.setFocusPainted(false);

        // Action pag clinick ang Login
        btnLogin.addActionListener(e -> {
            String user = txtUser.getText();
            String pass = new String(txtPass.getPassword());

            // Simple validation muna (Username: admin, Password: 123)
            if (user.equals("admin") && pass.equals("123")) {
                frame.dispose(); // Isasara ang login
                Main.main(null); // Bubuksan ang Dashboard
            } else {
                JOptionPane.showMessageDialog(frame, "Invalid Username or Password", "Error", JOptionPane.ERROR_MESSAGE);
            }
        });

        panel.add(lblTitle);
        panel.add(txtUser);
        panel.add(txtPass);
        panel.add(new JLabel("")); // Spacer
        panel.add(btnLogin);

        frame.add(panel);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}


