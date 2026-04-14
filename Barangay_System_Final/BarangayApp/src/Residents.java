import java.awt.*;
import javax.swing.*;

public class Residents {
    public void showWindow() {
        JFrame frame = new JFrame("Manage Residents - Barangay San Marino");
        frame.setSize(600, 400);
        frame.setLayout(new BorderLayout());

        // Title
        JLabel title = new JLabel("Resident Records", SwingConstants.CENTER);
        title.setFont(new Font("Arial", Font.BOLD, 18));
        frame.add(title, BorderLayout.NORTH);

        // Table (Dito lalabas ang listahan)
        String[] columns = {"ID", "Name", "Age", "Gender"};
        Object[][] data = {
            {"1", "Juan Dela Cruz", "25", "Male"},
            {"2", "Maria Clara", "22", "Female"}
        };
        JTable table = new JTable(data, columns);
        JScrollPane scrollPane = new JScrollPane(table);
        frame.add(scrollPane, BorderLayout.CENTER);

        // Bottom Panel para sa mga Buttons
        JPanel panel = new JPanel();
        JButton btnAdd = new JButton("Add Resident");
        JButton btnBack = new JButton("Back to Dashboard");
        panel.add(btnAdd);
        panel.add(btnBack);
        frame.add(panel, BorderLayout.SOUTH);

        // Action para bumalik sa Main
        btnBack.addActionListener(e -> {
            frame.dispose(); // Isasara itong window
        });

        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}

