import java.awt.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class Users {
    public void showWindow() {
        JFrame frame = new JFrame("System User Management");
        frame.setSize(600, 450);
        frame.setLayout(new BorderLayout(5, 5));

        // Header
        JPanel header = new JPanel();
        header.setBackground(new Color(52, 73, 94)); // Dark Gray/Blue
        JLabel title = new JLabel("USER & ROLES SETTINGS");
        title.setFont(new Font("Segoe UI", Font.BOLD, 18));
        title.setForeground(Color.WHITE);
        header.add(title);

        // Table
        String[] cols = {"User ID", "Username", "Assigned Role"};
        DefaultTableModel model = new DefaultTableModel(cols, 0);
        JTable table = new JTable(model);
        
        // Sample data base sa Access tables mo
        model.addRow(new Object[]{"1", "admin_anthony", "Administrator"});
        model.addRow(new Object[]{"2", "staff_01", "Barangay Staff"});

        frame.add(header, BorderLayout.NORTH);
        frame.add(new JScrollPane(table), BorderLayout.CENTER);

        JButton btnAdd = new JButton("Add New User");
        frame.add(btnAdd, BorderLayout.SOUTH);

        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}


