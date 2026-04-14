import java.awt.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class Complaints {
    public void showWindow() {
        JFrame frame = new JFrame("Barangay San Marino - Complaints");
        frame.setSize(700, 500);
        frame.setLayout(new BorderLayout(10, 10));

        // Header
        JPanel header = new JPanel();
        header.setBackground(new Color(192, 57, 43)); 
        JLabel title = new JLabel("COMPLAINTS MANAGEMENT");
        title.setFont(new Font("Segoe UI", Font.BOLD, 22));
        title.setForeground(Color.WHITE);
        header.add(title);
        frame.add(header, BorderLayout.NORTH);

        // Form (Left Side)
        JPanel form = new JPanel(new GridLayout(6, 1, 5, 5));
        form.setBorder(BorderFactory.createTitledBorder("New Complaint"));
        form.setPreferredSize(new Dimension(250, 0));

        JTextField txtName = new JTextField();
        txtName.setBorder(BorderFactory.createTitledBorder("Name"));
        JTextField txtSub = new JTextField();
        txtSub.setBorder(BorderFactory.createTitledBorder("Subject"));
        JTextArea txtDetails = new JTextArea();
        txtDetails.setLineWrap(true);
        JScrollPane scrollArea = new JScrollPane(txtDetails);
        scrollArea.setBorder(BorderFactory.createTitledBorder("Details"));

        JButton btnSubmit = new JButton("Submit");
        btnSubmit.setBackground(new Color(44, 62, 80));
        btnSubmit.setForeground(Color.WHITE);

        form.add(txtName); form.add(txtSub); form.add(scrollArea); form.add(btnSubmit);
        frame.add(form, BorderLayout.WEST);

        // Table (Center)
        String[] cols = {"ID", "Name", "Subject", "Status"};
        DefaultTableModel model = new DefaultTableModel(cols, 0);
        JTable table = new JTable(model);
        frame.add(new JScrollPane(table), BorderLayout.CENTER);

        // Back Button
        JButton btnBack = new JButton("Back to Dashboard");
        btnBack.addActionListener(e -> frame.dispose());
        frame.add(btnBack, BorderLayout.SOUTH);

        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}



